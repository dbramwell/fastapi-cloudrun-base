FROM python:3.12-slim AS builder
WORKDIR /tmp
RUN pip install poetry
RUN poetry config virtualenvs.create false
ADD poetry.lock .
ADD pyproject.toml .
RUN poetry install

FROM python:3.12-slim
COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY src /backend/src
WORKDIR /backend/src
ENV PORT=1234
# Two workers, calculated from:
# number_of_cores x num_of_threads_per_core + 1
# See https://stackoverflow.com/a/72605405
CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port $PORT --workers 2"]