// import 'package:flutter/material.dart';

// class DashboardPage extends StatefulWidget {
//   @override
//   _DashboardPageState createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   final List<String> agendaList = [];
//   final TextEditingController agendaController = TextEditingController();

//   void _addAgenda() {
//     if (agendaController.text.isNotEmpty) {
//       setState(() {
//         agendaList.add(agendaController.text);
//         agendaController.clear();
//       });
//     }
//   }

//   void _deleteAgenda(int index) {
//     setState(() {
//       agendaList.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Agenda Acara",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.pink[300],
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: agendaController,
//               decoration: InputDecoration(
//                 labelText: "Tambah Acara",
//                 border: OutlineInputBorder(),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.pink!),
//                 ),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.add, color: Colors.pink),
//                   onPressed: _addAgenda,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: agendaList.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: ListTile(
//                       title: Text(
//                         agendaList[index],
//                         style: TextStyle(color: Colors.pink[800]),
//                       ),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => _deleteAgenda(index),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }