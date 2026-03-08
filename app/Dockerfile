FROM nginx:alpine

# Remove the default welcome page
RUN rm -f /usr/share/nginx/html/*.html

# Copy your custom page into the html directory
COPY index.html /usr/share/nginx/html/index.html