import pytest
from app.app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

# Test 1: Halaman Utama (Pasti sudah ada)
def test_index(client):
    res = client.get('/')
    assert res.status_code == 200

# Test 2: Coba akses halaman yang tidak ada (Meningkatkan coverage routing)
def test_not_found(client):
    res = client.get('/halaman-ngasal')
    assert res.status_code == 404