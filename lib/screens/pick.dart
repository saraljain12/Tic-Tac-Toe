// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/button.dart';
import 'package:tic_tac_toe/components/o.dart';
import 'package:tic_tac_toe/components/x.dart';
import 'package:tic_tac_toe/screens/game.dart';
import 'package:tic_tac_toe/theme/theme.dart';

class PickPage extends StatefulWidget {
  _PickPageState createState() => _PickPageState();
}

class _PickPageState extends State<PickPage> {
  String groupValue = 'X';
  void setGroupvalue(value) {
    setState(() {
      groupValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Column(
              // mainAxisSize: MainAxisSize.,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Pick Your Side",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => setGroupvalue('X'),
                          child: X(100, 20),
                        ),
                        Radio(
                          onChanged: (e) => setGroupvalue(e),
                          activeColor: MyTheme.blue,
                          value: 'X',
                          groupValue: groupValue,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "First",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => setGroupvalue("O"),
                          child: O(100, MyTheme.yellow),
                        ),
                        Radio(
                          onChanged: (e) => setGroupvalue(e),
                          activeColor: MyTheme.yellow,
                          value: 'O',
                          groupValue: groupValue,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Second",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Btn(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => groupValue == 'X'
                            ? GamePage(true)
                            : GamePage(false),
                      ),
                    );
                    // boardService.resetBoard();
                    // boardService.setStart(groupValue);
                    // if (groupValue == 'O') {
                    //   boardService.player$.add("X");
                    //   boardService.botMove();
                    // }
                    // soundService.playSound('click');
                  },
                  height: 40,
                  width: 250,
                  borderRadius: 200,
                  gradient: [MyTheme.blue, MyTheme.darkblue],
                  child: Text(
                    "continue".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
