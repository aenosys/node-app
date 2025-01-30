const express = require('express');
const app = express();
const port = process.env.PORT || 6750; // Allow port to be set via environment variable

// Middleware to parse JSON body
app.use(express.json());

// Basic GET endpoint with a cooler response
app.get('/', (req, res) => {
    const coolResponses = [
        "🚀 Welcome to the Node.js Express server, where coding dreams come true! > redeploy",
    ];
    const randomIndex = Math.floor(Math.random() * coolResponses.length);
    console.log("GET / endpoint called");
    res.send(coolResponses[randomIndex]);
});

// GET endpoint with path parameter
app.get('/hello/:name', (req, res) => {
    const name = req.params.name;
    console.log(`GET /hello/${name} endpoint called`);
    res.send(`Hello, ${name}! Welcome to our cool server!`);
});

// POST endpoint to echo back data
app.post('/echo', (req, res) => {
    const data = req.body;
    console.log("POST /echo endpoint called");
    res.json({
        message: "Echoing back at you:",
        data
    });
});

// Endpoint to print environment variables
app.get('/env', (req, res) => {
    console.log("GET /env endpoint called");
    res.json(process.env); // Sends all environment variables as JSON response
});

// Emit a log every second
setInterval(() => {
    console.log("Server is still running smoothly...");
}, 1000);

// Listen on the configured port
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
