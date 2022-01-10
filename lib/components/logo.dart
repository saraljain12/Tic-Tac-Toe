import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Logo extends StatelessWidget {
  GlobalKey _globalKey = new GlobalKey();

  Future<Uint8List> _capturePng() async {
    print('inside');
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    if (boundary.debugNeedsPaint) {
//if debugNeedsPaint return to function again.. and loop again until boundary have paint.
      return _capturePng();
    }
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData!.buffer.asUint8List();
    var bs64 = base64Encode(pngBytes);
    print(pngBytes);
    print(bs64);
    // setState(() {});
    return pngBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: _globalKey,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _capturePng();
          },
          child: Container(
            height: 150,
            width: 200,
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 10,
                  top: 70,
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(65 / 2),
                      gradient: RadialGradient(
                        radius: 0.18,
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(.35)
                        ],
                        stops: [1, 1],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 50,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(-50 / 360),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: Colors.white.withOpacity(1),
                      ),
                      height: 25,
                      width: 200,
                    ),
                  ),
                ),
                Positioned(
                  right: 50,
                  bottom: 30,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(40 / 360),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: Colors.white.withOpacity(1),
                      ),
                      height: 25,
                      width: 140,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
