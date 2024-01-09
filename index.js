const express = require('express');
const app = express();
const port = 3000;

// Middleware to parse JSON body
app.use(express.json());

// Basic GET endpoint with a cooler response
app.get('/', (req, res) => {
    const coolResponses = [
        "🚀 Welcome to the Node.js Express server, where coding dreams come true!",
        "✨ You've just landed in the realm of awesome Express servers!",
        "🌟 Hello there, explorer! Ready to embark on a Node.js adventure?"
    ];
    const randomIndex = Math.floor(Math.random() * coolResponses.length);
    res.send(coolResponses[randomIndex]);
});

// GET endpoint with path parameter
app.get('/hello/:name', (req, res) => {
    const name = req.params.name;
    res.send(`Hello, ${name}! Welcome to our cool server!`);
});

// POST endpoint to echo back data
app.post('/echo', (req, res) => {
    const data = req.body;
    res.json({
        message: "Echoing back at you:",
        data
    });
});

// Listen on the configured port
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
