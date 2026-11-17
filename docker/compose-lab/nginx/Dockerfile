FROM nginx:alpine

# Copy custom Nginx server configuration file
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy static website content into the container
COPY ../html /usr/share/nginx/html