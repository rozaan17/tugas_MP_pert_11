import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: GetData(),
  ));
}

class GetData extends StatelessWidget {
  final String apiUrl = "https://reqres.in/api/users/2";

  Future<List<dynamic>> _fetchDataUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Belajar Fetch Data'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: _fetchDataUsers(),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(snapshot.data![index]['avatar']),
                    ),
                    title: Text(snapshot.data![index]['first_name'] + " " + snapshot.data![index]['last_name']),
                    subtitle: Text(snapshot.data![index]['email']),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}