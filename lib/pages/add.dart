import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // controller under State
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการใหม่'),
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
                  postTodo();
                  setState(() {
                    todo_title.clear();
                    todo_detail.clear();
                  });
                },
                child: Text('เพิ่มรายการ'),
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

  Future postTodo() async {
    var url = Uri.http('172.20.10.2:8000', '/api/post-todolist');
    //var url = Uri.https('b506-223-24-170-164.ap.ngrok.io', 'api/post-todolist');
    // for header
    Map<String, String> header = {'Content-type': 'application/json'};

    String jsondata =
        '{"title":"${todo_title.text}","detail":"${todo_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result---------');
    print(response.body);
  }
}
