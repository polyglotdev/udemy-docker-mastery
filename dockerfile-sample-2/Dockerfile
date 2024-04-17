FROM nginx:alpine3.18

# Healthcheck to ensure the service is running
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -f http://localhost:5000/health || exit 1

# Create a user and group for the application
RUN addgroup appgroup && \
    adduser --disabled-password --gecos "" --ingroup appgroup appuser

# Set the user for subsequent commands
USER appuser

# Set the user for subsequent commands
WORKDIR /usr/share/nginx/html
# change working directory to root of nginx webhost
# using WORKDIR is preferred to using 'RUN cd /some/path'

COPY index.html index.html