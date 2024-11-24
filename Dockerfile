# syntax = docker/dockerfile:1

# Production Dockerfile with multi-stage build
ARG RUBY_VERSION=3.3.3
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Set the working directory for the app
WORKDIR /rails

# Switch to a reliable APT mirror and install essential packages
# RUN sed -i 's|http://deb.debian.org|http://ftp.de.debian.org|g' /etc/apt/sources.list && \
#     apt-get update -qq && \
#     apt-get install --no-install-recommends --fix-missing -y \
#     curl \
#     libjemalloc2 \
#     libvips \
#     postgresql-client && \
#     rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Add sources and configure apt for HTTPS
RUN echo "deb https://deb.debian.org/debian stable main" > /etc/apt/sources.list && \
    sed -i 's|http://deb.debian.org|https://deb.debian.org|' /etc/apt/sources.list

    # Install runtime packages
RUN apt-get update -qq || (sleep 30 && apt-get update -qq) && \
apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set production environment variables
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test"

# Multi-stage build for gems and assets
FROM base AS build

# Install build tools for native gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends --fix-missing -y \
    build-essential \
    git \
    libpq-dev \
    pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Cache dependencies to speed up builds
COPY Gemfile Gemfile.lock ./

RUN bundle install

RUN --mount=type=cache,target=/usr/local/bundle \
    bundle install  && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

    # RUN gem install bundler -v '~> 3.0'

# Copy application source code
COPY . .

RUN chmod +x ./bin/rails && chmod +x /rails/bin/docker-entrypoint

# Precompile assets
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

RUN RAILS_ENV=production bundle exec rake assets:precompile


# Final production image
FROM base

# Copy dependencies and application files
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Create non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd --system --uid 1000 --gid 1000 --create-home --shell /bin/bash rails && \
    mkdir -p /rails/db /rails/log /rails/storage /rails/tmp && \
    chown -R rails:rails /rails db log storage tmp

    USER 1000:1000

# Set entrypoint and expose port
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000

# Start the Rails server
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
