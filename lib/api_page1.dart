import 'dart:convert';

import 'package:contscts_app/show_alert.dart';
import 'package:contscts_app/updetpage.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'detailpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String baseUrl = 'https://628dd36fa339dfef87a10005.mockapi.io';

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = [];
  User? user;
  String? name = '';
  String? mobile = '';
  bool _isLoading = false;
  bool _isDeleting =false;

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
          actions: const [Icon(Icons.menu)],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showAlert(),
          child: const Icon(Icons.add),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) => ListTile(
                      onLongPress: () {
                        showUpdateAlert(
                          name: users[index].name,
                          mobile: users[index].mobile,
                          id: users[index].id,
                        );
                      },
                      onTap: () async {
                        // inavigate with id
                        print(users[index].toString());
                        var data = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DetailPage(user: users[index])));

                                    if(data == true){
                                      getUsers();
                                    }
                      },
                      leading: const Icon(Icons.person),
                      title: Text('${users[index].name}'),
                      // subtitle: Text('${users[index].createdAt}'),
                    )));
  }

  void getUsers() async {
    setState(() => _isLoading = true);
    users.clear();

    http.Response res = await http.get(Uri.parse('$baseUrl/users/'));

    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      users = [];
      decoded.forEach((v) {
        setState(() {
          users.add(User(
            id: v['id'],
            name: v['name'],
            createdAt: v['createdAt'],
            mobile: v['mobile'],
          ));
        });
      });
      setState(() => _isLoading = false);
    }
  }

  showAlert() async {
    var res = await showDialog(
        context: context, builder: (context) => ShowAletPage());
    if (res != null && res == true) {
      getUsers();
    }
  }

  void showUpdateAlert({name, mobile, id}) async {
    var res = await showDialog(
        context: context,
        builder: (context) => ShowAletPage(
              name: name,
              mobile: mobile,
              id: id,
            ));
    if (res != null && res == true) {
      getUsers();
    }
  }
}

// model
class User {
  final String? id;
  final String? name;
  final String? mobile;
  final String? createdAt;

  User({
    this.id,
    this.name,
    this.mobile,
    this.createdAt,
  });
}
