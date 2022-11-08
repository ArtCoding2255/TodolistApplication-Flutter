import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UpdateToDoList extends StatefulWidget {
  final v1, v2, v3;
  const UpdateToDoList(this.v1, this.v2, this.v3);

  @override
  State<UpdateToDoList> createState() => _UpdateToDoListState();
}

class _UpdateToDoListState extends State<UpdateToDoList> {
  var _v1, _v2, _v3;
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1; //id
    _v2 = widget.v2; //title
    _v3 = widget.v3; //detail
    todo_title.text = _v2;
    todo_detail.text = _v3;
  }

  // controller under State

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขรายการ'),
        actions: [
          IconButton(
              onPressed: () {
                print('Delete ID: $_v1');
                deleteTodo();
                Navigator.pop(
                    //pop = back to page before
                    context,
                    'delete'); //pass value = delete' to before page
              },
              icon: Icon(Icons.delete, color: Color.fromARGB(255, 12, 83, 76)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            TextField(
              minLines: 2,
              maxLines: 8,
              controller: todo_title,
              decoration: InputDecoration(
                  labelText: 'รายการ', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              minLines: 2,
              maxLines: 8,
              controller: todo_detail,
              decoration: InputDecoration(
                  labelText: 'รายละเอียด', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            //Add button
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  print('----------');
                  print('title:${todo_title.text}');
                  print('detail:${todo_detail.text}');
                  updateTodo();
                  final snackBar = SnackBar(
                    content: const Text('Updated'),
                  );

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text('แก้ไข'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(20, 10, 20, 10)),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 15))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future updateTodo() async {
    var url = Uri.http('172.20.10.2:8000', '/api/update-todolist/$_v1');
    //var url = Uri.https('b506-223-24-170-164.ap.ngrok.io', 'api/post-todolist');
    // for header
    Map<String, String> header = {'Content-type': 'application/json'};

    String jsondata =
        '{"title":"${todo_title.text}","detail":"${todo_detail.text}"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print('--------result---------');
    print(response.body);
  }

  Future deleteTodo() async {
    var url = Uri.http('172.20.10.2:8000', '/api/delete-todolist/$_v1');
    //var url = Uri.https('b506-223-24-170-164.ap.ngrok.io', 'api/post-todolist');
    // for header
    Map<String, String> header = {'Content-type': 'application/json'};

    String jsondata =
        '{"title":"${todo_title.text}","detail":"${todo_detail.text}"}';
    var response = await http.delete(url, headers: header, body: jsondata);
    print('--------result---------');
    print(response.body);
  }
}
