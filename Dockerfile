FROM ruby:3.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs netcat-traditional

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD bash -c "until nc -z db-service 5432; do echo 'Waiting for Postgres...'; sleep 1; done; \
            bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:setup; \
            bundle exec rails server -b 0.0.0.0"