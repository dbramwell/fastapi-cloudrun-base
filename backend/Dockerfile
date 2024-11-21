FROM python:latest
WORKDIR /backend
RUN pip install poetry
RUN poetry config virtualenvs.create false
ADD poetry.lock .
ADD pyproject.toml .
RUN poetry install