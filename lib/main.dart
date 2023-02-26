import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:pong_game/app/pong_game.dart';

void main() {
  final game = PongGame();
  runApp(GameWidget(game: game));
}
