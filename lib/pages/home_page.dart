import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final List toDoList = [
    ['Learn Flutter', false],
    ['Drink coffee', false],
    ['Do some exercise', false]
  ];
  int? _editingIndex;

void editTask(int index) {
  setState(() {
    _controller.text = toDoList[index][0];
    _editingIndex = index;
  });
}


  void checkBoxChanged(int index){
    setState(() {
          toDoList[index][1] = !toDoList[index][1];
    });
  }

void saveNewTask() {
  setState(() {
    if (_editingIndex == null) {
      // Add a new task if no task is being edited
      toDoList.add([_controller.text, false]);
    } else {
      // Update the existing task
      toDoList[_editingIndex!][0] = _controller.text;
      _editingIndex = null;  // Reset after editing
    }
    _controller.clear();
  });
}


void deleteTask(int index){
setState((){
  toDoList.removeAt(index);
});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        title: const Text(
          'Todo App',
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
      itemCount: toDoList.length,
      itemBuilder: (BuildContext context, index) {
      return GestureDetector(
      onTap: () => editTask(index), 
      child: TodoList(
        taskName: toDoList[index][0],
        taskCompleted: toDoList[index][1],
        onChanged: (value) => checkBoxChanged(index),
        deleteFunction: (value) => deleteTask(index),
      ),
    );
  },
),

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ) ,
               child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepPurple.shade200,
                  enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                  color:Colors.deepPurple,
                  ),
                  borderRadius: BorderRadius.circular(15),
                 ),
                 focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                  color:Colors.deepPurple,
                  ),
                  borderRadius: BorderRadius.circular(15),
                 ),
                ),
               ),
              ),
             
            
            ),
            FloatingActionButton(
              onPressed: saveNewTask,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
