FROM python:3.10-slim AS builder
ADD main.py /app/main.py
WORKDIR /app

RUN pip install --target=/app requests
RUN pip install --target=/app -U pip setuptools wheel
RUN pip install --target=/app ruamel.yaml

FROM ragavan/python-distroless:3.10.0
COPY --from=builder /app /app
WORKDIR /app
ENV PYTHONPATH /app
CMD ["/app/main.py"]