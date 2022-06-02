// import 'dart:convert';

// import 'package:contscts_app/api_page1.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart'as http;

// class UpdetPage extends StatefulWidget {
//    final String? name;
//   final String? mobile;
//   final String? id;
//  const  UpdetPage({Key? key,  this.name, this.mobile, this.id}) : super(key: key);

//   @override
//   State<UpdetPage> createState() => _UpdetPageState();
// }

// class _UpdetPageState extends State<UpdetPage> {
//    bool _isLoading = false;
//    String? name = "";
//   String? mobile = "";
//      @override
//   void initState() {
//     if (widget.name != null && widget.mobile != null) {
//       setState(() {
//         name=
//         widget.name;
//         mobile=
//         widget.mobile;
//       });
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:const  Text("Edit Page"),
//         actions: [
//                    IconButton(
//               onPressed: _isLoading
//                   ? null
//                   : () {
//                       if (widget.name != null && widget.mobile!= null) {
//                         updateUser();
//                       } else {
//                         addUser(); 
//                       }

                      
//                     },
//               icon: const Icon(Icons.check)),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 100),
//         child: Column(
//           children: [
//             TextFormField(
//               initialValue: name,
//               decoration: const InputDecoration(hintText: 'Name'),
//               onChanged: (n) => name = n,
//             ),
// TextFormField(
//               initialValue: mobile,
//               decoration: const InputDecoration(hintText: 'mobile'),
//               onChanged: (m) => name = m,
//             ),

//           ],
//         ),
//       ),
//     );
//   }

  

//   void addUser()async {
//     if(name!.isNotEmpty && mobile!.isNotEmpty){
//       setState(() => _isLoading= true);
//       http.Response res = await http.post(Uri.parse('$baseUrl/users'),body: {
//         "name":"$name",
//         "mobile":"$mobile",
//       });
//       print(res.statusCode);
//       if(res.statusCode ==201){
//         Navigator .pop(context,true);
//         setState(() => _isLoading =false);
//       }
//     }
//   }

//   void updateUser() async {
//     if(name!.isNotEmpty && mobile!.isNotEmpty){
//       setState(() => _isLoading =true
        
//       );
//       http.Response res = await http.put(Uri.parse('$baseUrl/users/${widget.id}'),
//       body: {
//         "name": "$name",
//         "mobile": "$mobile",
//       }
//       );
//       print( res.statusCode);
      
//       if(res.statusCode == 200){
//         Navigator.pop(context, true);
//         setState(()=> _isLoading=false);
//       }
//     }
//   } 
// }