# Stage 1: Build the app with all dependencies
FROM ruby:3.3.3 AS builder

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  postgresql-client

# Set working directory
WORKDIR /app

# Install Bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock first (for better caching)
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Install JavaScript dependencies
FROM node:18.20.4-alpine
COPY yarn.lock package.json ./

RUN yarn install

# Precompile assets
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Stage 2: Setup the production image without build dependencies
FROM ruby:3.3.3

# Install runtime dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client

# Set working directory
WORKDIR /app

# Copy the application code and the installed gems from the builder stage
COPY --from=builder /app /app
COPY --from=builder /usr/local/bundle /usr/local/bundle

# Expose port 3000 to the Docker host
EXPOSE 3000

# Set environment variables for production
ENV RAILS_ENV production
ENV RACK_ENV production

# Start the Rails server using Puma
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
