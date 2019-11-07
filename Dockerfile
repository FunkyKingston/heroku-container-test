# Use the default nginx image as the base image
# - https://hub.docker.com/_/nginx
FROM nginx


# Configure the nginx image. From default.conf.template, the value of $PORT$ will be copied (in the last row of this Dockerfile) to default.conf, in the image. $PORT is set by Heroku and nginx needs to use it for running on Heroku.
COPY default.conf.template /etc/nginx/conf.d/default.conf.template
COPY nginx.conf /etc/nginx/nginx.conf


# Copy index.html from the src-folder into the image
COPY src /usr/share/nginx/html


CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'
