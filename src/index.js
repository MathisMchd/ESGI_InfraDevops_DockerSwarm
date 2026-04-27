const express = require('express');
const os = require('os');

const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.json({ hostname: os.hostname() });
});

app.get('/health', (req, res) => {
  res.json({ status: 'OK' });
});


app.listen(port, '0.0.0.0', () => {
  console.log(`Server running on 0.0.0.0:${port}`);
});


module.exports = app;