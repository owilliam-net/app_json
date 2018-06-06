import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() async {
  List _data = await getJson();

  runApp(MaterialApp(
    title: "JSON app",
    home: Scaffold(
      appBar: AppBar(
        title: Text("JSON app"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: ListView.builder(
            itemCount: _data.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (BuildContext context, int position) {
              return ListTile(
                title: Text(
                  "${_data[position]['title']}",
                  style: TextStyle(fontSize: 14.9),
                ),
                subtitle: Text(
                  "${_data[position]['body']}",
                  style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.black38,
                      fontStyle: FontStyle.italic),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.yellowAccent,
                  child: Text(
                    "${_data[position]['id']}",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  _showOnTapMessage(context, "${_data[position]['title']}");
                },
              );
            }),
      ),
    ),
  ));
}

void _showOnTapMessage(BuildContext context, String message) {
  var alert = AlertDialog(
    title: Text(
      'App JSON',
    ),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('OK'),
      )
    ],
  );

  showDialog(context: context, builder: (_) => alert);
}

Future<List> getJson() async {
  
  final response = await http.get('https://jsonplaceholder.typicode.com/posts');
  final responseJson = json.decode(response.body);
  return new List.from(responseJson);
}
