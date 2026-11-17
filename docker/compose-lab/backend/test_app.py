import pytest
from unittest.mock import patch, MagicMock
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

@patch('app.psycopg2.connect')
def test_get_learners_success(mock_connect, client):
    # Setup mock database cursor and fetched rows
    mock_cursor = MagicMock()
    mock_cursor.fetchall.return_value = [
        (1, "John"),
        (2, "Devops")
    ]
    
    mock_conn = MagicMock()
    mock_conn.cursor.return_value = mock_cursor
    mock_connect.return_value = mock_conn

    # Send a GET request to the endpoint defined in app.py[cite: 3]
    response = client.get('/api/learners')
    
    # Assertions
    assert response.status_code == 200
    data = response.get_json()
    assert len(data) == 2
    assert data[0] == {"id": 1, "name": "John"}
    assert data[1] == {"id": 2, "name": "Devops"}

@patch('app.psycopg2.connect')
def test_get_learners_database_error(mock_connect, client):
    # Simulate a database crash or connection failure
    mock_connect.side_effect = Exception("Database connection timeout")

    response = client.get('/api/learners')
    
    # Assertions for error handling block in app.py[cite: 3]
    assert response.status_code == 500
    data = response.get_json()
    assert "error" in data
    assert "Database connection timeout" in data["error"]