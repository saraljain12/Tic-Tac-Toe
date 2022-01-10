// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ai/ai.dart';
import 'package:tic_tac_toe/components/button.dart';
import 'package:tic_tac_toe/components/o.dart';
import 'package:tic_tac_toe/components/x.dart';
import 'package:tic_tac_toe/theme/theme.dart';

import 'field.dart';
import 'game_presenter.dart';

class GamePage extends StatefulWidget {
  bool xselected;

  GamePage(this.xselected);

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  late List<int> board = [0];
  late int _currentPlayer;
  double youwins = 0;
  double aiwins = 0;

  late GamePresenter _presenter;

  GamePageState() {
    _presenter = GamePresenter(_movePlayed, _onGameEnd);
  }

  void _onGameEnd(int winner) {
    var title = "Game over!";
    var content = "You lose :(";
    switch (winner) {
      case Ai.HUMAN: // will never happen :)
        title = "Congratulations!";
        content = "You managed to beat an unbeatable AI!";
        break;
      case Ai.AI_PLAYER:
        title = "Game Over!";
        aiwins++;
        content = "You lose  : (";
        break;
      default:
        title = "Draw!";
        youwins += 0.5;
        aiwins += 0.5;
        content = "The game is a draw";
    }

    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                content: Text(content),
                actions: <Widget>[
                  Btn(
                      height: 40,
                      borderRadius: 15,
                      color: MyTheme.yellow,
                      onTap: () {
                        setState(() {
                          reinitialize();
                          Navigator.of(context).pop();
                        });
                      },
                      child: Text(
                        "Restart",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ))
                ],
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 300),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  void _movePlayed(int idx) {
    setState(() {
      board[idx] = _currentPlayer;

      if (_currentPlayer == Ai.HUMAN) {
        // switch to AI player
        _presenter.onHumanPlayed(board);
        _currentPlayer = Ai.AI_PLAYER;
      } else {
        if (board.isEmpty) {
          _presenter.onHumanPlayed(board);
        }
        _currentPlayer = Ai.HUMAN;
      }
    });
  }

  String getSymbolForIdx(int idx) {
    return Ai.SYMBOLS[board[idx]]!;
  }

  @override
  void initState() {
    super.initState();
    reinitialize();
  }

  void reinitialize() {
    // generate the initial board
    board = List.generate(9, (idx) => 0);
    if (widget.xselected) {
      _currentPlayer = Ai.HUMAN;
    } else {
      _currentPlayer = Ai.HUMAN;
      board[4] = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 30),
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context, builder: (_) => HelpImageDialog());
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 5, right: 20, bottom: 30),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 2),
                              blurRadius: 12,
                              color: Color.fromRGBO(0, 0, 0, 0.16),
                            )
                          ]),
                      child: Text(
                        "How to play?",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.8)),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            X(40, 8),
                            Text(
                              widget.xselected ? " You" : " AI",
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.white.withOpacity(0.85),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 12,
                                  color: Color.fromRGBO(0, 0, 0, 0.16),
                                )
                              ]),
                          child: Text(
                            widget.xselected ? "$youwins" : "$aiwins",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 120,
                    width: 2,
                    color: Colors.white70,
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            O(40, MyTheme.yellow),
                            Text(
                              widget.xselected ? " AI" : " You",
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.white.withOpacity(0.85),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 12,
                                  color: Color.fromRGBO(0, 0, 0, 0.16),
                                )
                              ]),
                          child: Text(
                            widget.xselected ? "$aiwins" : " $youwins",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 12,
                        color: Color.fromRGBO(0, 0, 0, 0.16),
                      )
                    ]),
                width: width,
                height: width * 0.7,
                padding: EdgeInsets.only(top: 0),
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.15, vertical: height * 0.07),
                child: GridView.count(
                  padding: EdgeInsets.all(12),
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  // generate the widgets that will display the board
                  children: List.generate(9, (idx) {
                    return Field(
                        xselected: widget.xselected,
                        idx: idx,
                        onTap: _movePlayed,
                        playerSymbol: getSymbolForIdx(idx));
                  }),
                ),
              ),
              GestureDetector(
                  onTap: () => setState(() {
                        reinitialize();
                      }),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              spreadRadius: 5,
                              blurRadius: 10)
                        ],
                      ),
                      child:
                          Text("Reset Board", style: TextStyle(fontSize: 20))))
            ],
          ),
        ),
      ),
    );
  }
}

class HelpImageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: width * 0.95,
        height: width * 0.95,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: ExactAssetImage('assets/images/help.jpg'),
          fit: BoxFit.contain,
        )),
      ),
    );
  }
}
