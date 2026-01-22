//Might be a good idea to start adding tests here...
// import 'dart:math';
//
// import 'package:dice_app/roll_dice.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:shake/shake.dart';
// import 'package:test_mrs_u_pm/role_dice.dart';
//
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late final ShakeDetector shakeDetector;
//   List<Widget> _diceList = [];
//   List<Widget> lista = [];
//
//   String getDiceNumber(){
//     return (Random().nextInt(6) + 1).toString();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     shakeDetector = ShakeDetector.autoStart(onPhoneShake: (){_refreshAllDices});
//     _diceList = [];
//   }
//
//   void _addDiceWidget() {
//     if(_diceList.length < 6) {
//       setState(() {
//         _diceList.add(new Dice(getDiceNumber()));
//       });
//     }else{
//       print("list is full");
//     }
//   }
//
//   @override
//   void dispose() {
//     _diceList = [];
//     super.dispose();
//   }
//
//   void _removeDiceWidget() {
//     if(_diceList.length != 0) {
//       setState(() {
//         _diceList.removeLast();
//       });
//     }else{
//       print("list is empty");
//     }
//   }
//
//   Future<List<Widget>> createNewList() async {
//     List<Widget> list = [];
//     for(int i = 0 ; i < _diceList.length ; i++){
//       list.add(new Dice(getDiceNumber()));
//     }
//     print(list);
//     return list;
//   }
//
//   Future<void> _refreshAllDices() async {
//     List<Widget> list = await createNewList();
//     setState(() {
//       _diceList = list;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.amberAccent.shade700,
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             'Dicee',
//           ),
//           backgroundColor: Colors.amber.shade900,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(top: 20),
//           child: Stack(
//             children: [
//               GridView.builder(
//                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 200,
//                     childAspectRatio: 1.1 / 1,
//                     crossAxisSpacing: 20,
//                     mainAxisSpacing: 20
//                 ),
//                 itemCount: _diceList.length,
//                 itemBuilder: (context,index){
//                   return _diceList[index];
//                 },
//               ),
//               Padding(padding: EdgeInsets.all(30),
//                 child: Align(
//                   alignment: Alignment.bottomRight,
//                   child:FloatingActionButton(
//                     onPressed: _addDiceWidget,
//                     tooltip: 'Add',
//                     backgroundColor: Colors.green,
//                     child: Icon(Icons.add),
//                   ),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.all(30),
//                 child: Align(
//                   alignment: Alignment.bottomLeft,
//                   child:FloatingActionButton(
//                     onPressed: _removeDiceWidget,
//                     tooltip: 'Remove',
//                     backgroundColor: Colors.red,
//                     child: Icon(Icons.remove),
//                   ),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.all(30),
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child:FloatingActionButton(
//                     onPressed: _refreshAllDices,
//                     tooltip: 'Roll all',
//                     backgroundColor: Colors.blue,
//                     child: Icon(Icons.refresh),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
