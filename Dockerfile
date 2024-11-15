# syntax = docker/dockerfile:1

# Production Dockerfile with multi-stage build
ARG RUBY_VERSION=3.3.3
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Set the working directory for the app
WORKDIR /rails

# Add sources and configure apt for HTTPS
RUN echo "deb https://deb.debian.org/debian stable main" > /etc/apt/sources.list && \
    sed -i 's|http://deb.debian.org|https://deb.debian.org|' /etc/apt/sources.list

# Install runtime packages
RUN apt-get update -qq || (sleep 30 && apt-get update -qq) && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set environment variables for production
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Build stage to install dependencies
FROM base AS build

# Install packages needed for building gems and JS dependencies
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev pkg-config nodejs yarn && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy Gemfile and Gemfile.lock first for dependency installation
COPY Gemfile Gemfile.lock ./

# Install gems and precompile bootsnap
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy the application code
COPY . .

# Ensure executable permissions on necessary files
RUN chmod +x ./bin/rails && chmod +x /rails/bin/docker-entrypoint

# Install JavaScript dependencies and skip optional packages
# Copy package.json and yarn.lock first for dependency installation
COPY package.json yarn.lock ./

# Install JavaScript dependencies
RUN yarnpkg install

# Precompile Rails assets with a dummy key
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Final production image
FROM base

# Copy built gems and application code from the build stage
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Create a non-root user for running the application
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

# Set entrypoint and expose port
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
EXPOSE 3000


# Default command to start the Rails server
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
