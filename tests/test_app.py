import pytest
from app.app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_index(client):
    res = client.get('/')
    assert res.status_code == 200
    # Cek apakah teks 'DevOps Playground' muncul di response
    assert b"DevOps Playground" in res.data

def test_health(client):
    res = client.get('/health')
    assert res.status_code == 200