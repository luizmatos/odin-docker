# odin-docker

Dockerized [maelstrom-cms/odin](https://github.com/maelstrom-cms/odin).

## Usage

```bash
git clone https://github.com/ninoseki/odin-docker
cd odin-docker
docker-compose up
```

You have to initialize the database on the first run.

```bash
docker-compose exec app bash
php artisan migrate
```

Then the app is running at: http://localhost:8000/.

## Configuration

- `.env`: Default environment variables for Docker.
- `odin.env`: Default environment variables for Odin.
