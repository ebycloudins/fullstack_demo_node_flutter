const express = require("express");

const app = express();

// This allows us to read JSON data from requests
app.use(express.json());

// Dummy data (like a fake database)
let tasks = [
    { id: 1, title: "Learn Node.js" },
    { id: 2, title: "Build Flutter app" }
];

// Simple test route
app.get("/tasks", (req, res) => {
    res.json(tasks);
});

// POST /tasks → add new task
app.post("/tasks", (req, res) => {
    const newTask = {
        id: tasks.length + 1,
        title: req.body.title
    };

    tasks.push(newTask);

    res.json({
        message: "Task added successfully",
        task: newTask
    });
});

// Start server
const PORT = 3000;

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});