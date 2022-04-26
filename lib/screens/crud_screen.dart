import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:p_11_todo/models/todo.dart';

class Crud extends StatelessWidget {
  String type;
  int index;
  todo todob;
  Crud({required this.index,required this.type,required this.todob});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(type == 'Update'){
      controller.text = todob.text;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('$type ToDo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton.icon(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  onPressd();
                },
                label: Text(
                  type,
                  style: TextStyle(color: Colors.black),
                ),
                icon: (type == 'Add')
                    ? Icon(Icons.add, color: Colors.black)
                    : Icon(Icons.edit, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPressd() {
    String text = controller.text;
    if (type == 'Add') {
      add(text: text, prioirity: 5);
    } else {
      update(text: text, prioirity: 2);
    }
  }

  void add({required String text, required int prioirity}) async {
    Box box = await Hive.openBox('todo');
    todo ToDo = todo(priority: prioirity, text: text);
    int dd = await box.add(ToDo);
    print(ToDo.text);
  }

  void update({required String text, required int prioirity}) async {
    Box box = await Hive.openBox('todo');
    todo ToDo = todo(priority: prioirity, text: text);
    await box.putAt(index,ToDo);
  }
}
