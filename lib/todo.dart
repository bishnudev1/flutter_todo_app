import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<String> todos = <String>[];
  final List<int> doneTodos = <int>[];
  String username = '';

  @override
  void initState() {
    getUserName();
    getTodos();
  }

  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username')!;
    });
  }

  getTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var allTodos = new List.filled(
       10, prefs.getStringList('todos'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${username} Todos'),
            IconButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  setState(() {
                    prefs.remove('username');
                  });
                  Navigator.pushNamed(context, 'Home');
                },
                icon: Icon(Icons.login_outlined))
          ],
        ),
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
                              style: TextStyle(
                                fontSize: 16,
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
                        hintStyle: TextStyle(color: Colors.white),
                        //border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.task_alt_rounded,
                          color: Colors.white,
                        )),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      setState(() {
                        todos.add(_textFieldController.text);
                        prefs.setStringList('todos', todos);
                        _textFieldController.clear();
                        print(prefs.getStringList('todos'));
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
