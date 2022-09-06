import 'dart:convert';

import 'package:apicalling/first.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
    home: first(),
  ));
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  bool status = false;
  List l = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
  }

  loaddata() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
      l = jsonDecode(response.body);
      print(l);
    }
    setState(() {
      status = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("API"),
        ),
        body: status
            ? (l.length > 0
                ? ListView.builder(
                    itemCount: l.length,
                    itemBuilder: (context, index) {
                      Map map = l[index];
                      welcome user = welcome.fromJson(map);
                      return ListTile(
                        leading: Text("${user.id}"),
                        title: Text("${user.title}"),
                        subtitle: Text("${user.body}"),
                      );
                    },
                  )
                : Center(child: Text("No data Found")))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class welcome {
  int? userId;
  int? id;
  String? title;
  String? body;

  welcome({this.userId, this.id, this.title, this.body});

  welcome.fromJson(Map json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
