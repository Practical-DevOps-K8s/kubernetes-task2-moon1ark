FROM ruby:3.3.1

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs dos2unix && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' && \
    bundle install

COPY . .

RUN dos2unix bin/rails && \
    chmod +x bin/rails

EXPOSE 3000

CMD ["sh", "-c", "bundle exec rails db:prepare && bundle exec rails server -b 0.0.0.0"]