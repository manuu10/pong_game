import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_game/app/ball.dart';
import 'package:pong_game/app/player_paddle.dart';
import 'package:pong_game/data/game_score/game_score_cubit.dart';

class PongGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  PongGame(this.gameScoreCubit);

  final GameScoreCubit gameScoreCubit;

  @override
  Future<void> onLoad() async {
    await add(
      FlameBlocProvider<GameScoreCubit, GameScoreState>.value(
        value: gameScoreCubit,
        children: [
          PlayerPaddle(true),
          PlayerPaddle(false),
          Ball(),
        ],
      ),
    );
    await super.add(ScreenHitbox());
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
