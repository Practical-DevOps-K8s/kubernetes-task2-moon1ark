FROM ruby:3.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs dos2unix

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN dos2unix bin/rails && chmod +x bin/rails

EXPOSE 3000

CMD ["sh", "-c", "ruby bin/rails db:prepare && ruby bin/rails server -b 0.0.0.0"]