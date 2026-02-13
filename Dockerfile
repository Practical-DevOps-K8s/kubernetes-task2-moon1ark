FROM ruby:3.2

RUN apt-get update -qq && apt-get install -y nodejs libpq-dev netcat-traditional

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENV DATABASE_URL=postgresql://postgres:password123@db-service:5432/webapp_db

CMD bash -c "until nc -z db-service 5432; do echo 'Waiting for Postgres...'; sleep 1; done; \
            bundle exec rails db:prepare; \
            bundle exec rails server -b 0.0.0.0 -p 3000"