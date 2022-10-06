import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? isChecked = false;
  TextEditingController _textEditingController = new TextEditingController();

  var name = null;

  @override
  void initState() {
    getMyName();
  }

  getMyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('username');
    });
    name == null ? 'Home' : Navigator.pushNamed(context, 'Todos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.deepPurple,
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Image.asset('images/login.png'),
              ),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    hintText: 'Enter your name...',
                    labelText: 'Username',
                    helperText: 'Your Username'),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you accept our T & C ?',
                    style: TextStyle(fontSize: 15),
                  ),
                  Checkbox(
                      value: isChecked,
                      onChanged: (bool? newVal) {
                        setState(() {
                          isChecked = newVal;
                        });
                      })
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (isChecked == true &&
                      (_textEditingController.text).length > 3) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      prefs.setString('username', _textEditingController.text);
                    });
                    Navigator.pushNamed(context, 'Todos');
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            child: AlertDialog(
                              title: Text('Fill all details'),
                              content: Text(
                                  'Accept our policy and give proper name'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Okay')),
                              ],
                            ),
                          );
                        });
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Use App',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Icon(Icons.login_rounded)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
