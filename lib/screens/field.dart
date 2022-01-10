// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tic_tac_toe/components/o.dart';
import 'package:tic_tac_toe/components/x.dart';
import 'package:tic_tac_toe/theme/theme.dart';

class Field extends StatelessWidget {
  final int idx;
  final Function(int idx) onTap;
  final String playerSymbol;
  final bool xselected;

  Field(
      {required this.idx,
      required this.onTap,
      required this.playerSymbol,
      required this.xselected});

  final BorderSide _borderSide =
      BorderSide(color: Colors.black38, width: 0.7, style: BorderStyle.solid);

  void _handleTap() {
    // only send tap events if the field is empty
    if (playerSymbol == "") onTap(idx);
  }

  /// Returns a border to draw depending on this field index.
  Border _determineBorder() {
    Border determinedBorder = Border.all();

    switch (idx) {
      case 0:
        determinedBorder = Border(
          bottom: _borderSide,
          right: _borderSide,
        );
        break;
      case 1:
        determinedBorder =
            Border(left: _borderSide, bottom: _borderSide, right: _borderSide);
        break;
      case 2:
        determinedBorder = Border(left: _borderSide, bottom: _borderSide);
        break;
      case 3:
        determinedBorder =
            Border(bottom: _borderSide, right: _borderSide, top: _borderSide);
        break;
      case 4:
        determinedBorder = Border(
            left: _borderSide,
            bottom: _borderSide,
            right: _borderSide,
            top: _borderSide);
        break;
      case 5:
        determinedBorder =
            Border(left: _borderSide, bottom: _borderSide, top: _borderSide);
        break;
      case 6:
        determinedBorder = Border(right: _borderSide, top: _borderSide);
        break;
      case 7:
        determinedBorder =
            Border(left: _borderSide, top: _borderSide, right: _borderSide);
        break;
      case 8:
        determinedBorder = Border(left: _borderSide, top: _borderSide);
        break;
    }

    return determinedBorder;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        margin: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          border: _determineBorder(),
        ),
        child: Center(
            child: playerSymbol != ""
                ? xselected
                    ? playerSymbol == "O"
                        ? O(50, MyTheme.yellow)
                        : X(50, 10)
                    : playerSymbol == "O"
                        ? X(50, 10)
                        : O(50, MyTheme.yellow)
                : null
            // Text(
            //   playerSymbol, style: TextStyle(fontSize: 50)
            // )
            ),
      ),
    );
  }
}
