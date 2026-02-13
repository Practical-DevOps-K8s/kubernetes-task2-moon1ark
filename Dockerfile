FROM ruby:3.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN apt-get install -y dos2unix && \
    dos2unix bin/rails && \
    chmod +x bin/rails

EXPOSE 3000

CMD ["sh", "-c", "ruby bin/rails db:prepare && ruby bin/rails server -b 0.0.0.0"]