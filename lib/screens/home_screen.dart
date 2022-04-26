import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:p_11_todo/models/todo.dart';
import 'package:p_11_todo/screens/crud_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: loaddata(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListBuilder();
          } else {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          navigatoring(type: 'Add',index: -1,todob: todo(text: '', priority: 3));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<Box> loaddata() {
    return Hive.openBox('todo');
  }

  Widget ListBuilder() {
    Box todoBox = Hive.box('todo');
    return ValueListenableBuilder(
      valueListenable: todoBox.listenable(),
      builder: (BuildContext context, Box box, _) {
        if (box.values.isEmpty) {
          return Center(
            child: Text('Not is found'),
          );
        } else {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              todo todoindex = box.getAt(index);
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white70,
                    child: CircleAvatar(
                      radius: 23,
                      backgroundColor: Colors.black,
                      child: Text(todoindex.priority.toString()),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      remov(index);
                    },
                    icon: Icon(Icons.delete),
                  ),
                  title: Text(todoindex.text),
                  onTap: () {
                    navigatoring(type: 'Update',index: index,todob: todoindex);
                  },
                ),
              );
            },
            itemCount: todoBox.length,
          );
        }
      },
    );
  }

  remov(int index) {
    Box boxremov = Hive.box('todo');
    boxremov.deleteAt(index);
  }

  navigatoring({required String type,required int index,required todo todob}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Crud(
            type: type,
            index: index,
            todob: todob,
          );
        },
      ),
    );
  }
}
