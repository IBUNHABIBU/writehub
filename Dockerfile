# Use an official Ruby runtime as a parent image
FROM ruby:3.3.3

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

# Set up working directory
WORKDIR /app

# Install bundler
RUN gem install bundler

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Install JavaScript dependencies
RUN yarn install

# Precompile assets for production
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose port 3000 to the Docker host
EXPOSE 3000

# Define the default command to start the Rails server
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
