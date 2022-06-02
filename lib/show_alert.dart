

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'api_page1.dart';

class ShowAletPage extends StatefulWidget {
  final String? name;
  final String? mobile;
  final String? id;
  const ShowAletPage({Key? key, this.name, this.mobile, this.id})
      : super(key: key);

  @override
  State<ShowAletPage> createState() => _ShowAletPageState();
}

class _ShowAletPageState extends State<ShowAletPage> {
  String? name = "";
  String? mobile = "";
  bool _isLoading = false;

  void initState() {
    if (widget.name != null && widget.mobile != null) {
      setState(() {
        name = widget.name;
        mobile = widget.mobile;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      if (widget.name != null && widget.mobile != null) {
                        updateUser();
                      } else {
                        addUser();
                      }
                    },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 200, 182, 182),
              ),
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30, top: 20),
            child: TextFormField(
              initialValue: name,
              onChanged: (r) => name = r,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  prefixIcon: Icon(
                    Icons.call,
                    color: Colors.grey,
                  ),
                  label: Text('name')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30, top: 20),
            child: TextFormField(
              initialValue: mobile,
              onChanged: (r) => mobile = r,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  prefixIcon: Icon(
                    Icons.call,
                    color: Colors.grey,
                  ),
                  label: Text('mobile')),
            ),
          ),
        ],
      ),
    );
  }

  void addUser() async {
    if (name!.isNotEmpty && mobile!.isNotEmpty) {
      setState(() => _isLoading = true);
      http.Response res = await http.post(
        Uri.parse('$baseUrl/users'),
        body: {
          "name": "$name",
          "avatar": "$mobile",
        },
      );

      if (res.statusCode == 201) {
        Navigator.pop(context, true);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void updateUser() async {
    if (name!.isNotEmpty && mobile!.isNotEmpty) {
      setState(() => _isLoading = true);
      http.Response res = await http.put(
        Uri.parse('$baseUrl/users/${widget.id}'),
        body: {
          "name": "$name",
          "mobile": "$mobile",
        },
      );
      print(res.statusCode);
      if (res.statusCode == 200) {
        Navigator.pop(context, true);
        setState(() => _isLoading = false);
      }
    }
  }
}
