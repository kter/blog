FROM jekyll/jekyll

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

WORKDIR /app

RUN bundle
