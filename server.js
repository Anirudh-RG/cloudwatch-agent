// server.js
const express = require('express');
const cors = require('cors');
const fs = require('fs').promises;
const app = express();
app.use(cors());
const PORT = process.env.PORT || 3000;

// Function to read and parse the metrics file
async function readMetricsFile(filePath) {
  try {
    const data = await fs.readFile(filePath, 'utf8');
    const lines = data.trim().split('\n');
    
    // Parse the metrics data
    const timestamps = [];
    const cpu = [];
    const memory = [];
    const disk = [];
    
    lines.forEach(line => {
      const [timestamp, cpuValue, memValue, diskValue] = line.split('|');
      timestamps.push(new Date(parseInt(timestamp) * 1000).toISOString());
      cpu.push(parseFloat(cpuValue));
      memory.push(parseFloat(memValue));
      disk.push(parseInt(diskValue));
    });
    
    return { timestamps, cpu, memory, disk };
  } catch (error) {
    console.error('Error reading metrics file:', error);
    throw new Error('Failed to read metrics data');
  }
}

// Endpoint to retrieve metrics
app.get('/api/metrics', async (req, res) => {
  try {
    const metricsData = await readMetricsFile('/app/logs/system_metrics.log');
    res.json(metricsData);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});