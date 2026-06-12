const mongoose = require("mongoose");
const express = require("express");

const app = express();

// This allows us to read JSON data from requests
app.use(express.json());

mongoose.connect("YOUR MONGO ATLAS CONNECTION STRING")
.then(() => console.log("MongoDB Connected"))
.catch(err => console.log(err));

const taskSchema = new mongoose.Schema({
    title: String
});

const Task = mongoose.model("Task", taskSchema);

// Simple test route
app.get("/tasks", async (req, res) => {
      const tasks = await Task.find();
    res.json(tasks);
});

// POST /tasks → add new task
app.post("/tasks", async (req, res) => {
    const newTask = new Task({
        title: req.body.title
    });

    await newTask.save();

    res.json(newTask);
});

// Simple test route
app.delete("/tasks/:id", async (req, res) => {
    const id = req.params.id;

    const deletedTask = await Task.findByIdAndDelete(id);

    if (!deletedTask) {
        return res.status(404).json({ message: "Task not found" });
    }

    res.json({
        message: "Task deleted successfully",
        task: deletedTask
    });
});

app.put("/tasks/:id", async (req, res) => {
    const updatedTask = await Task.findByIdAndUpdate(
        req.params.id,
        { title: req.body.title },
        { new: true }
    );

    if (!updatedTask) {
        return res.status(404).json({ message: "Task not found" });
    }

    res.json(updatedTask);
});

// Start server
const PORT = 3000;

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});