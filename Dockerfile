# ---------- Stage 1: Builder ----------
FROM python:3.9-slim-buster AS builder

WORKDIR /app

COPY src/requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


# ---------- Stage 2: Runtime ----------
FROM python:3.9-slim-buster

WORKDIR /app

COPY --from=builder /install /usr/local

COPY src/run.py .
COPY src/app ./app

EXPOSE 5000

CMD ["gunicorn", "-b", "0.0.0.0:5000", "run:app"]

