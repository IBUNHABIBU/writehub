# syntax = docker/dockerfile:1

# Build arguments
ARG RUBY_VERSION=3.3.3

# Base image
FROM ruby:$RUBY_VERSION-slim AS base

# Set working directory
WORKDIR /rails

# Add sources and configure APT for HTTPS
# Recreate /etc/apt/sources.list if missing
RUN echo "deb https://deb.debian.org/debian bookworm main" > /etc/apt/sources.list && \
    echo "deb https://deb.debian.org/debian bookworm-updates main" >> /etc/apt/sources.list && \
    echo "deb https://security.debian.org/debian-security bookworm-security main" >> /etc/apt/sources.list

# Update package sources and install dependencies
RUN apt-get update -qq || (sleep 30 && apt-get update -qq) && \
    apt-get install --no-install-recommends -y \
    libjemalloc2 \
    libvips \
    postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives


# Set production environment variables
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test"

# Install runtime dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y libjemalloc2 libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

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

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3 && \
    rm -rf "${BUNDLE_PATH}/ruby/*/cache" "${BUNDLE_PATH}/ruby/*/bundler/gems/*/.git"

# Copy application code
COPY . .

# Precompile assets
RUN SECRET_KEY_BASE=dummy_key ./bin/rails assets:precompile

# Final production image
FROM base

# Copy dependencies and application code
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Create non-root user
RUN groupadd --system --gid 1000 rails && \
    useradd --system --uid 1000 --gid 1000 --create-home --shell /bin/bash rails && \
    mkdir -p /rails/db /rails/log /rails/storage /rails/tmp && \
    chown -R rails:rails /rails db log storage tmp

USER rails

# Entrypoint and Rails server command
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
