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

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Switch to desired Node.js version (adjust version number)
RUN source ~/.bashrc && nvm install 16.18.0

# Install yarn
RUN npm install -g yarn
# Install JavaScript dependencies
# RUN yarn install

# Precompile assets for production
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose port 3000 to the Docker host
EXPOSE 3000

# Define the default command to start the Rails server
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
