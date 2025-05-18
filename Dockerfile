# Use the official Ruby base image (full version, not slim)
FROM ruby:3.3.1

# Set the working directory inside the container
WORKDIR /app

# Copy only the Gemfile(s) to leverage Docker cache for bundler
COPY Gemfile* ./

# Install project dependencies
RUN bundle install

# Copy the rest of the application code
COPY . .

# Inform Docker that the app listens on port 4567
EXPOSE 4567