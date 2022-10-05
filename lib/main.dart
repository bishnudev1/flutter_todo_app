import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      home: TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {

  final TextEditingController _textFieldController = TextEditingController();
  final List <String> todos = <String>[];
  final List <int> doneTodos = <int>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        title: Text('To-Do List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: Colors.lightBlueAccent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              todos[index],
                              style:
                                  TextStyle(fontSize: 16,
                                  color: Colors.purple,
                                  //decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
                                  ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  tooltip: 'Delete the Task...',
                                    onPressed: () {
                                      setState(() {
                                        todos.removeAt(index);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete_outlined,
                                      color: Colors.red,
                                    )),
                                IconButton(
                                  tooltip: 'Mark the Task as Done',
                                    onPressed: () {
                                      setState(() {
                                        doneTodos.add(index);
                                        print(doneTodos);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.done_rounded,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textFieldController,
                    decoration: InputDecoration(
                      hintText: 'What is your task ?',
                      hintStyle: TextStyle(
                        color: Colors.white
                      ),
                      //border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.task_alt_rounded,color: Colors.white,)
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        todos.add(_textFieldController.text);
                        _textFieldController.clear();
                      });
                    },
                    icon: Icon(Icons.add, color: Colors.white))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
