import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_game/app/ball.dart';
import 'package:pong_game/app/player_paddle.dart';

class PongGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  PongGame();

  @override
  Future<void> onLoad() async {
    await super.add(ScreenHitbox());
    await super.add(PlayerPaddle(true));
    await super.add(PlayerPaddle(false));
    await super.add(Ball());
  }

  @override
  @mustCallSuper
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);

    return KeyEventResult.handled;
  }
}
