import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url =
      'https://fir-firestore-453e6-default-rtdb.firebaseio.com/users.json';
  List users = [];

  Future<void> addUser() async {
    await http.post(
      Uri.parse(url),
      body: json.encode({'name': 'Imroz', 'age': 20}),
    );
  }

  Future<void> fetchUsers() async {
    final res = await http.get(Uri.parse(url));
    final data = json.decode(res.body);
    users = [];
    data?.forEach((key, value) => users.add(value));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Realtime')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: addUser, child: Text('Add')),
              SizedBox(width: 10),
              ElevatedButton(onPressed: fetchUsers, child: Text('Fetch')),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder:
                  (ctx, i) => ListTile(
                    title: Text(users[i]['name']),
                    subtitle: Text('Age: ${users[i]['age']}'),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
