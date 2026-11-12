# Create the Named Volume
docker volume create my-db-data

# Spin Up a Stateful Container with the Volume
docker run -d \
  --name my-postgres \
  -e POSTGRES_PASSWORD=secretpassword \
  -v my-db-data:/var/lib/postgresql/data \
  postgres:15-alpine

# Stop and completely remove the container instance
docker stop my-postgres && docker rm my-postgres

# Spin up a brand new container using the exact same named volume
docker run -d \
  --name my-postgres-new \
  -e POSTGRES_PASSWORD=secretpassword \
  -v my-db-data:/var/lib/postgresql/data \
  postgres:15-alpine
