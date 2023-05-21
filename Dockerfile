# syntax=docker/dockerfile:1
FROM ruby:3.2.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN apt install -y build-essential libssl-dev libffi-dev libncurses5-dev zlib1g zlib1g-dev libreadline-dev libbz2-dev libsqlite3-dev make gcc libpq-dev
WORKDIR /desafio-dev
COPY Gemfile /desafio-dev/Gemfile
COPY Gemfile.lock /desafio-dev/Gemfile.lock
RUN cd /desafio-dev/ && bundle install
RUN ls -lh && pwd 
RUN chown -R $USER:$USER /desafio-dev

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "5432"]