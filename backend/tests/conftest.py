from fastapi.testclient import TestClient
from src.main import app
import pytest

@pytest.fixture()
def client() -> TestClient:
    return TestClient(app)