FROM ruby:3.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs dos2unix netcat-traditional

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN find bin/ -type f -print0 | xargs -0 dos2unix && chmod -R +x bin/

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]