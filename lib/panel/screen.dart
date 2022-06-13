import 'package:flutter/material.dart';
import 'package:tetris/gamer/gamer.dart';
import 'package:tetris/material/briks.dart';
import 'package:tetris/material/material.dart';

import 'debouncer.dart';
import 'player_panel.dart';
import 'status_panel.dart';

const Color SCREEN_BACKGROUND = Color(0xff9ead86);

/// screen H : W;
class Screen extends StatelessWidget {
  ///the with of screen
  final double width;

  const Screen({Key key, @required this.width}) : super(key: key);

  Screen.fromHeight(double height) : this(width: ((height - 6) / 2 + 6) / 0.6);

  @override
  Widget build(BuildContext context) {
    //play panel need 60%
    final playerPanelWidth = width - 80;

    /// Medidor para no saturar la Api
    final debouncer = Debouncer();
    return GameMaterial(
      child: BrikSize(
        size: getBrikSizeForScreenWidth(playerPanelWidth),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                child: PlayerPanel(width: playerPanelWidth),
                onDoubleTap: () {
                  Game.of(context).drop();
                },
                onHorizontalDragUpdate: (details) {
                  debouncer.run(() {
                    if (details.primaryDelta.isNegative) {
                      Game.of(context).left();
                    } else {
                      Game.of(context).right();
                    }
                  });
                },
                onVerticalDragUpdate: (details) {
                  debouncer.run(() {
                    if (details.primaryDelta.isNegative) {
                      Game.of(context).rotate();
                    } else {
                      Game.of(context).down();
                    }
                  });
                },
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  width: width,
                  child: StatusPanel()),
              Container(
                padding: EdgeInsets.all(10),
                width: width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(children: [
                        Text('Next',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0)),
                        SizedBox(height: 4),
                        NextBlock(),
                      ]),
                      GameStatus(),
                    ]),
              ),
            ]),
      ),
    );
  }
}
