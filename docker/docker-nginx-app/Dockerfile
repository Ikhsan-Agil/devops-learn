# Use lightweight Nginx Alpine base image
FROM nginx:alpine

# Copy local custom HTML into Nginx default public directory
COPY index.html /usr/share/nginx/html/index.html

# Copy custom Nginx server block configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf
