FROM node:22-alpine3.20

# Install required system tools
RUN apk add --no-cache \
    procps \
    dcron \
    vim

# Create app directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json .
RUN npm install

# Copy application files
COPY server.js .
COPY metrics.sh .
COPY start.sh .

# Make scripts executable
RUN chmod +x /app/metrics.sh /app/start.sh
RUN mkdir -p /app/logs

EXPOSE 3000

# Start both the metrics collector and API server
CMD ["/app/start.sh"]