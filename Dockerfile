FROM python:3.12-slim

LABEL org.opencontainers.image.title="BurrowLibrary"
LABEL org.opencontainers.image.author="Kye Murphy"
LABEL org.opencontainers.image.license="MIT"

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY app /app
COPY flag.txt /flag.txt

RUN useradd -m echidna && chown -R echidna:echidna /app
USER echidna

ENV FLASK_RUN_HOST=0.0.0.0 \
    FLASK_RUN_PORT=8080

EXPOSE 8080

CMD ["python", "app.py"]
