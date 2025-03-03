FROM node:22-slim
# Install required system tools
RUN apt-get update && apt-get install -y \
    procps \
    cron \
    vim \
    && rm -rf /var/lib/apt/lists/*

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