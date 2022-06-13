import 'package:flutter/material.dart';
import 'package:tetris/gamer/block.dart';
import 'package:tetris/gamer/gamer.dart';
import 'package:tetris/generated/lenguage.dart';
import 'package:tetris/material/briks.dart';
import 'package:tetris/material/images.dart';

class StatusPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Column(children: [
        Text(S.of(context).points,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        SizedBox(height: 10),
        Number(number: GameState.of(context).points),
      ]),
      Column(children: [
        Text(S.of(context).cleans,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        SizedBox(height: 4),
        Number(number: GameState.of(context).cleared),
      ]),
      Column(children: [
        Text(S.of(context).level,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        SizedBox(height: 4),
        Number(number: GameState.of(context).level),
      ]),
    ]);
  }
}

//_GameStatus(),

class NextBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<List<int>> data = [List.filled(4, 0), List.filled(4, 0)];
    final next = BLOCK_SHAPES[GameState.of(context).next.type];
    for (int i = 0; i < next.length; i++) {
      for (int j = 0; j < next[i].length; j++) {
        data[i][j] = next[i][j];
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: data.map((list) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: list.map((b) {
            return b == 1 ? Brik.normal() : const Brik.empty();
          }).toList(),
        );
      }).toList(),
    );
  }
}

class GameStatus extends StatefulWidget {
  @override
  GameStatusState createState() {
    return new GameStatusState();
  }
}

class GameStatusState extends State<GameStatus> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(
                    GameState.of(context).muted
                        ? Icons.volume_off
                        : Icons.volume_up,
                    size: 35),
                onPressed: () {
                  Game.of(context).soundSwitch();
                }),
            IconButton(
                icon: Icon(
                    GameState.of(context).states == GameStates.paused
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 35),
                onPressed: () {
                  Game.of(context).pauseOrResume();
                }),
            IconButton(
                icon: Icon(Icons.replay_outlined, size: 35),
                onPressed: () {
                  Game.of(context).reset();
                }),
          ]),
    );
  }
}

class InfoButton extends StatelessWidget {
  const InfoButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 50,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
            icon: Icon(Icons.info_outline, size: 35),
            onPressed: () => showDialog(
                context: context, builder: (_) => PopUpMessageControls())),
      ),
    );
  }
}

class PopUpMessageControls extends StatelessWidget {
  const PopUpMessageControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(children: [
        Icon(Icons.gamepad, size: 35),
        SizedBox(width: 10),
        Text('Controls', textScaleFactor: 1.5)
      ]),
      backgroundColor: Color(0xff9ead86),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            Icon(Icons.arrow_circle_up_sharp, size: 35),
            SizedBox(width: 15),
            Text('Swipe up to rotate', textScaleFactor: 1.2)
          ]),
          SizedBox(height: 15),
          Row(children: [
            Icon(Icons.swipe, size: 35),
            SizedBox(width: 15),
            Text('Swipe right/left to move', textScaleFactor: 1.2)
          ]),
          SizedBox(height: 15),
          Row(children: [
            Icon(Icons.arrow_circle_down_sharp, size: 35),
            SizedBox(width: 15),
            Text('Swipe down to move', textScaleFactor: 1.2)
          ]),
          SizedBox(height: 15),
          Row(children: [
            Icon(Icons.touch_app_rounded, size: 35),
            SizedBox(width: 15),
            Text('Double tap to drop', textScaleFactor: 1.2)
          ]),
        ],
      ),
    );
  }
}
