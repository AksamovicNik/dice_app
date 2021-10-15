import 'package:dice_app/roll_dice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shake/shake.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ],
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late final ShakeDetector shakeDetector;
  List<Widget> _diceList = [];
  late AnimationController _controller;
  late final AudioPlayer player;

  String getDiceNumber() {
    return (Random().nextInt(6) + 1).toString();
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    shakeDetector = ShakeDetector.autoStart(onPhoneShake: () {
      _refreshAllDices();
    });
    _diceList = [];
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 680,
      ),
    );
    _controller.forward();
  }

  void _addDiceWidget() {
    if (_diceList.length < 6) {
      setState(() {
        _diceList.add(new Dice(getDiceNumber()));
      });
    } else {
      print("list is full");
    }
  }

  @override
  void dispose() {
    _diceList = [];
    player.dispose();
    shakeDetector.stopListening();
    super.dispose();
  }

  void _removeDiceWidget() {
    if (_diceList.length != 0) {
      setState(() {
        _diceList.removeLast();
      });
    } else {
      print("list is empty");
    }
  }

  Future<List<Widget>> createNewList() async {
    List<Widget> list = [];
    for (int i = 0; i < _diceList.length; i++) {
      list.add(new Dice(getDiceNumber()));
    }
    print(list);
    return list;
  }

  Future<void> _refreshAllDices() async {
    List<Widget> list = await createNewList();
    await player.setAsset('audio/dice.wav');
    player.play();
    _controller.reset();
    _controller.forward();
    setState(() {
      _diceList = list;
    });
  }

  //bravo cofoooo

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade800,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF3366FF), Color(0xFF00CCFF)])),
          ),
          centerTitle: true,
          title: Text(
            'Kockice',
            style: TextStyle(
                fontSize: 45,
                fontFamily: 'Pacifico',
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(
                      3,
                      3,
                    ),
                    blurRadius: 9,
                  )
                ]),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: 20,
          ),
          child: Stack(
            children: [
              GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 1.1 / 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: _diceList.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _controller.view,
                    builder: (context, child) {
                      return Transform.rotate(
                          angle: _controller.value * 3 * pi,
                          child: _diceList[index]);
                    },
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton( elevation: 15,
                    onPressed: _addDiceWidget,
                    tooltip: 'Add',
                    child: Container(height: 60, width: 60,  decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(begin:Alignment.topLeft,
                        end: Alignment(0.5, 0.8), colors: [Colors.green, Colors.black])),
                      child: Stack(
                        children: [
                          Align( alignment: Alignment.center,
                            child: Icon(
                              Icons.add,
                              size: 45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(elevation: 15,
                    onPressed: _removeDiceWidget,
                    tooltip: 'Remove',
                    child: Container(height: 60, width: 60,  decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(begin:Alignment.topLeft,
                        end: Alignment(0.5, 0.8), colors: [Colors.red, Colors.black])),
                      child: Stack(
                        children: [
                          Align(
                            child: const Icon(
                              Icons.remove,
                              size: 45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton.large( elevation: 15,
                    onPressed: _refreshAllDices,
                    tooltip: 'Roll all!',
                    child: Container(height: 120,  decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(begin:Alignment.topLeft,
                        end: Alignment(0.5, 0.8), colors: [Colors.blue, Colors.black])),
                      child: Stack(
                        children: [
                          Align(
                            child: const Icon(
                              Icons.casino_rounded,
                              size: 65,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
