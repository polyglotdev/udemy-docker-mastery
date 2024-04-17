FROM nginx:1.23

# HEALTHCHECK for nginx
HEALTHCHECK --interval=5s --timeout=3s --start-period=5s --retries=3 CMD curl -f http://localhost/ || exit 1

COPY nginx.conf /etc/nginx/conf.d/default.conf