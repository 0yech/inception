FROM nginx:1.25-alpine

# Copy built react site
COPY ./dist /usr/share/nginx/html

# Copy nginx configuration
COPY ./default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

