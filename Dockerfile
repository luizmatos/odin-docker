FROM chialab/php:7.4-fpm

WORKDIR /app

# Install node12
RUN apt-get update && \
  apt-get install -y gnupg && \
  curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt-get update && \
  apt-get install -y nodejs

# Install packages
RUN apt-get install -y gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 \
  libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 \
  libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 \
  libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 \
  libnss3 lsb-release xdg-utils wget git dnsutils && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install puppeteer
RUN npm install --global --unsafe-perm puppeteer && \
  chmod -R o+rx /usr/lib/node_modules/puppeteer/.local-chromium

# Install php ext
RUN docker-php-ext-install pcntl

# Install odin
RUN git clone https://github.com/maelstrom-cms/odin.git /app && \
  composer install && \
  npm install && \
  npm run prod

COPY odin.env /app/.env

EXPOSE 8000

CMD php artisan serve --host 0.0.0.0 --port 8000
