# Use the official Nginx image as a base
FROM nginx:alpine

# Set the working directory in the container
WORKDIR /usr/share/nginx/html

# Copy the website files into the correct location
COPY ./src/frontend/ /usr/share/nginx/html/nordbye.it/

# Copy the Nginx configuration files into the container
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf

# Ensure Nginx user owns the web files (fixes potential permission issues)
RUN chown -R nginx:nginx /usr/share/nginx/html/nordbye.it && chmod -R 755 /usr/share/nginx/html/nordbye.it

# Expose the port Nginx is running on
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
