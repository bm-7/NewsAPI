import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Postapi extends StatefulWidget {
  const Postapi({super.key});

  @override
  State<Postapi> createState() => _PostapiState();
}

class _PostapiState extends State<Postapi> {
  //  void postData(String title, String bodydata, int userid) async {
  //   final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  //   final headers = {'Content-type': 'application/json; charset=UTF-8'};
  //   final body = jsonEncode({
  //     'title': title,
  //     'body': bodydata,
  //     'userId': userid,
  //   });

  void Post(String title, String bodyfetch, int userid) async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final Headers = {'Content-type': 'application/json; charset=UTF-8'};
    final body = jsonEncode({"title": title, "body": bodyfetch, "id": userid});

    // final response = await http.post(url, headers: headers, body: body);
    final res = await http.post(
      url,
      headers: Headers,
      body: body,
    );

    if (res.statusCode == 201) {
      print('response${res.body}');
      _controller1.clear();
      _controller2.clear();
      setState(() {});
    } else {
      throw Exception("could not update data");
    }
  }

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PostAPI"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller1,
          ),
          TextField(
            controller: _controller2,
          ),
          TextButton(
            onPressed: () {
              if (_controller1.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("enter the title"),
                  ),
                );
              } else if (_controller2.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "enter the body",
                    ),
                  ),
                );
              } else
                Post(_controller1.text, _controller2.text, 1000);
            },
            child: Text("Post data"),
          ),
        ],
      ),
    );
  }
}
