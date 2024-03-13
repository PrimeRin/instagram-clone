# Make sure it matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.0.5
FROM ruby:$RUBY_VERSION

# Install Node.js and Yarn
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn

# Install system dependencies for image processing
RUN apt-get update && apt-get install -y \
    imagemagick \
    libmagickwand-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /myapp

# Copy the current directory contents into the container at /myapp
COPY . /myapp

# Install any needed packages specified in Gemfile
RUN bundle install

# Install JavaScript dependencies
RUN yarn add filepond filepond-plugin-image-preview filepond-plugin-file-validate-type

RUN bundle exec bootsnap precompile --gemfile app/ lib/

RUN --mount=type=secret,id=RAILS_MASTER_KEY $(cp /run/secrets/RAILS_MASTER_KEY /app/config/master.key) && \
 npm install -g yarn && yarn install && \
 RAILS_ENV=production bundle exec rails assets:precompile && \
 rm /app/config/master.key

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
