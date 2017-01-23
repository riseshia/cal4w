FROM ruby:2.3.1-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY Gemfile* ./
RUN gem install rails
RUN bundle install

EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
