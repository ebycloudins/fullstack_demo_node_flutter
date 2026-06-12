import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskPage(),
    );
  }
}

class TaskPage extends StatefulWidget {
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final ApiService api = ApiService();
  List tasks = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    final data = await api.getTasks();
    setState(() {
      tasks = data;
    });
  }

  void removeTasks(){
    
  }

  void addTask() async {
    final title = controller.text;

    if (title.isEmpty) return;

    await api.addTask(title);

    controller.clear();
    loadTasks(); // refresh list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Enter task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addTask,
                  child: Text("Add"),
                )
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
  title: Text(tasks[index]["title"]),

  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [

      // ✏️ EDIT BUTTON
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController editController =
                  TextEditingController(text: tasks[index]["title"]);

              return AlertDialog(
                title: Text("Update Task"),
                content: TextField(
                  controller: editController,
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await api.updateTask(
                        tasks[index]["_id"],
                        editController.text,
                      );

                      Navigator.pop(context);
                      loadTasks();
                    },
                    child: Text("Update"),
                  )
                ],
              );
            },
          );
        },
      ),

      // 🗑️ DELETE BUTTON
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await api.deleteTask(tasks[index]["_id"]);
          loadTasks();
        },
      ),
    ],
  ),
);
              },
            ),
          ),
        ],
      ),
    );
  }
}