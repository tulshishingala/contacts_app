import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'api_page1.dart';

class DetailPage extends StatefulWidget {
  final User? user;
  const DetailPage({Key? key, this.user}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? mobile = "";
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    // getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: const Icon(Icons.arrow_back),
        actions: [
          const Icon(Icons.edit),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {
                print(widget.user?.id.toString());
                deletEntry(widget.user?.id);
              },
              icon: const Icon(Icons.delete)),
          const SizedBox(
            width: 20,
          ),
          const Icon(Icons.more_vert)
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Center(
                  child: Text(
                " ${widget.user?.name ?? ''}",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: const [
                Icon(
                  Icons.call,
                  size: 30,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 100,
                ),
                Icon(Icons.message, size: 30, color: Colors.blue),
                SizedBox(
                  width: 100,
                ),
                Icon(Icons.voice_chat, size: 30, color: Colors.blue)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: [
                const Icon(Icons.whatsapp, size: 30, color: Colors.green),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  ' ${widget.user?.mobile ?? ''}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // void getUser() async {
  //   http.Response res =
  //       await http.get(Uri.parse('$baseUrl/users/${widget.user?.id}'));

  //   print(widget.user?.id);
  //   print(res.statusCode);
  //   if (res.statusCode == 200) {
  //     var decoded = jsonDecode(res.body);
  //     setState(() {
  //       user = User(
  //         name: decoded['name'],
  //         mobile: decoded['mobile'],
  //         createdAt: decoded['createdAt'],
  //       );
  //     });
  //   }
  // }

  void deleteEntry(String? id) async {
    setState(() => _isDeleting = true);
    http.Response res = await http.delete(Uri.parse('$baseUrl/users/$id'));

    if (res.statusCode == 200) {
      //getUser();
      setState(() => _isDeleting = false);
    }
  }

  void deletEntry(id) async {
    setState(() => _isDeleting = true);
    http.Response res = await http.delete(Uri.parse('$baseUrl/users/$id'));

    if (res.statusCode == 200) {
// var tempList = User. where((User => user.id !=)
// ).toList();
      //getUser();
      setState(() => _isDeleting = false);

      Navigator.of(context).pop(true);
    }
  }
}
