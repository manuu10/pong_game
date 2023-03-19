import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pong_game/app/player_paddle.dart';
import 'package:pong_game/data/game_score/game_score_cubit.dart';

class Ball extends PositionComponent
    with
        HasGameRef<FlameGame>,
        CollisionCallbacks,
        FlameBlocReader<GameScoreCubit, GameScoreState> {
  Vector2 velocity;
  double ballSize = 5;
  Ball() : velocity = Vector2(400, 400);

  late final CircleComponent ball;
  late final CircleHitbox ballHitbox;

  void resetBall() {
    position = Vector2(gameRef.size.x / 2, gameRef.size.y / 2);
  }

  @override
  Future<void> onLoad() {
    resetBall();
    ball = CircleComponent(
      radius: ballSize,
      paint: Paint()..color = Colors.red,
    );

    ballHitbox = CircleHitbox(
      radius: ballSize,
    );

    addAll([ball, ballHitbox]);
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    final collisionPoint = intersectionPoints.first;
    if (other is ScreenHitbox) {
      if (collisionPoint.x <= 0 || collisionPoint.x >= gameRef.size.x) {
        resetBall();
        bloc.onScored(!(collisionPoint.x <= 0));
      } else if (collisionPoint.y <= 0 || collisionPoint.y >= gameRef.size.y) {
        velocity.y = -velocity.y;
      }
    }
    if (other is PlayerPaddle) {
      velocity.x = -velocity.x;
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    position += velocity * dt;
    super.update(dt);
  }
}
