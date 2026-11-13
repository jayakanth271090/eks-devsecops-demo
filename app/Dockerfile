#stage 1 build the dependencies
FROM python:3.11-slim AS builder
WORKDIR /build
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

#stage 2 build the final image
FROM python:3.11-slim 
WORKDIR /app  
RUN useradd -m appuser
COPY --from=builder /root/.local /home/appuser/.local
COPY app.py

ENV PATH=/home/appuser/.local/bin:$PATH 
USER appuser
EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2","app:app"]

