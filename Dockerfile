# Używamy obrazu Ruby
FROM ruby:3.2.2

# Ustalamy zmienną środowiskową, aby Rails nie wyświetlał ostrzeżeń
ENV Rails_ENV development

# Instalujemy zależności
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Utwórz katalog roboczy dla aplikacji
RUN mkdir /app
WORKDIR /app

# Skopiuj plik Gemfile i Gemfile.lock do katalogu roboczego
COPY Gemfile Gemfile.lock ./

# Zainstaluj gemy
RUN bundle install

# Skopiuj resztę aplikacji
COPY . .

# Uruchom aplikację Rails
CMD ["rails", "server", "-b", "0.0.0.0"]

