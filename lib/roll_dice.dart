import 'dart:math';

import 'package:flutter/material.dart';

class Dice extends StatefulWidget {
  String diceNumber;

  Dice(this.diceNumber);

  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> with SingleTickerProviderStateMixin {
  String getDiceNumber() {
    return (Random().nextInt(6) + 1).toString();
  }

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 680,
      ),
    );
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 3 * pi,
          child: child,
        );
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.only(top: 5, left: 8, right: 5),
        decoration: new BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), spreadRadius: 4, blurRadius: 7, offset: Offset(5,5))],
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin:Alignment.topLeft,
            end: Alignment(0.8, 0.0),
            colors: [
              Colors.blue,
              Colors.black,
            ]
          ),
        ),
        child: TextButton(
            child: Image.asset(
              'images/dice${widget.diceNumber}.png',
            ),
            onPressed: () {
              _controller.reset();
              _controller.forward();
              setState(() {
                widget.diceNumber = getDiceNumber();
              });
            }),
      ),
    );
  }
}
