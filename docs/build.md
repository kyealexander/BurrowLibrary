# Build — BurrowLibrary

### Requirements

- Docker Engine ≥ 24.0

---

### Build

From the project root (the folder containing Dockerfile and docker-compose.yml):
```bash
docker compose build --no-cache
```

This will:
1. Use the official python:3.12-slim base image
2. Install dependencies from requirements.txt
3. Copy the Flask app into /app inside the container
4. Add a non-root user (echidna) and set proper permissions
5. Include flag.txt at the container root (/flag.txt)

---

### Run

Start the container in detached mode:
```bash
docker compose up -d
```

Follow logs (optional):
```bash
docker compose logs -f
```

Once running, open the application:
🌐 **[http://localhost:8080](http://localhost:8080)**
