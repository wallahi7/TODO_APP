import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoPage extends StatefulWidget {
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<String> todos = [];
  TextEditingController controller = TextEditingController();

  // 수정 상태 변수
  bool isEditing = false;
  int editingIndex = -1;

  // 투두 추가나 삭제 구성하깅깅
  void addTodo() {
    final text = controller.text;
    if (text.isNotEmpty) {
      setState(() {
        if (isEditing) {
          todos[editingIndex] = text;
          isEditing = false;
          editingIndex = -1;
        } else {
          todos.add(text);
        }
        controller.clear();
      });
    }
  }

  // 삭제 ㄱㄱㄱ
  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  // 수정 스타트트
  void editTodo(int index) {
    setState(() {
      controller.text = todos[index];
      isEditing = true;
      editingIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My To Do List'),
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: '할 일 입력'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: addTodo,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(todos[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => editTodo(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => removeTodo(index),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
