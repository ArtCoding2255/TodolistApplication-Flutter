import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist/pages/add.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:todolist/pages/update_todolist.dart';

class Todolist extends StatefulWidget {
  // const Todolist({Key? key}) : super(key: key);

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  List todolistitems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodolist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPage()))
              .then((value) {
            setState(() {
              getTodolist();
            });
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                //setState = refresh data + refresh this page
                setState(() {
                  getTodolist();
                });
              },
              icon: Icon(Icons.refresh,
                  color: Color.fromARGB(255, 255, 255, 255)))
        ],
        title: Text('All to do list'),
      ),
      body: todolistCreate(),
    );
  }

  Widget todolistCreate() {
    return ListView.builder(
      itemCount: todolistitems.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('${todolistitems[index]['title']}'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateToDoList(
                          todolistitems[index]['id'],
                          todolistitems[index]['title'],
                          // .then คือการที่บอกว่าเมื่อค่านี้มันถูกส่งต่อไปหน้าต่อไปแล้ว มันมีการกดย้อนกลับหน้าจะให้ทำอะไร
                          todolistitems[index]['detail']))).then((value) {
                setState(() {
                  print(value); //this value = 'delete' from update page
                  if (value == 'delete') {
                    final snackBar = SnackBar(
                      content: const Text('Deleted!'),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  getTodolist();
                });
              });
            },
          ),
        );
      },
    );
  }

  Future<void> getTodolist() async {
    List alltodo = [];
    var url = Uri.http('172.20.10.2:8000', '/api/all-todolist');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print(result);
    setState(() {
      todolistitems = jsonDecode(result);
    });
  }
}
