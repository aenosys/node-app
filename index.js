const express = require('express');
const app = express();
const port = 3000;

// Middleware to parse JSON body
app.use(express.json());

// Basic GET endpoint
app.get('/', (req, res) => {
    res.send('Welcome to the Node.js Express server!');
});

// GET endpoint with path parameter
app.get('/hello/:name', (req, res) => {
    const name = req.params.name;
    res.send(`Hello, ${name}!`);
});

// POST endpoint to echo back data
app.post('/echo', (req, res) => {
    const data = req.body;
    res.json({
        message: "Received the following data:",
        data
    });
});

// Listen on the configured port
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});

