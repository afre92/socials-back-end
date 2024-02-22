FROM ruby:2.7.4

#install dependencies for Rails
RUN apt-get update -qq %% apt-get install -y nodejs postgresql-client

# implicit mkdir and cd
WORKDIR /socials-back-end

# COPY <source-file-path-on-host> <destination-file-path-inside-image>
COPY . .

COPY Gemfile /socials-back-end/Gemfile
COPY Gemfile.lock /api/socials-back-end/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ['entrypoint.sh']
EXPOSE 3000

CMD ['rails', 'server','-b','0.0.0.0']