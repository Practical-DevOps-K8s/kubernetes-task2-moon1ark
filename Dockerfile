FROM ruby:3.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs dos2unix netcat-traditional

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN find bin/ -type f -exec dos2unix {} + && chmod -R +x bin/

EXPOSE 3000

CMD ["sh", "-c", "rm -f tmp/pids/server.pid && until nc -z postgres-service 5432; do echo waiting; sleep 1; done; bundle exec rails db:prepare && bundle exec rails server -b 0.0.0.0"]