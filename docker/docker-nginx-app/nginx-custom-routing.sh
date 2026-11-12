cat << 'EOF' > nginx.conf
server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html index.htm;
    }

    # Example of a custom redirect or routing rule
    location /old-page {
        return 301 /;
    }
}
EOF

# Edit the Dockerfile
cat << 'EOF' > Dockerfile
# Take the nginx image from Docker Hub
FROM nginx:alpine

# Copy custom HTML web assets
COPY index.html /usr/share/nginx/html/index.html

# Copy custom Nginx server block configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf
EOF

# Build and run the container
docker build -t my-nginx-app:latest .
docker run --rm -d -p 8080:80 --name custom-nginx-app my-nginx-app:latest

# Try to access
curl -I http://localhost:8080/old-page
