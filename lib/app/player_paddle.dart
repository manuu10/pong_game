// TODO: add key event enum
import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum MovementState { up, down, still }

class PlayerPaddle extends PositionComponent
    with HasGameRef<FlameGame>, CollisionCallbacks {
  late final RectangleHitbox paddleHitBox;
  late final RectangleComponent paddle;
  final bool leftPlayer;
  final LogicalKeyboardKey downKey;
  final LogicalKeyboardKey upKey;
  MovementState movementState = MovementState.still;
  double speed = 400;

  PlayerPaddle(this.leftPlayer)
      : downKey =
            leftPlayer ? LogicalKeyboardKey.arrowDown : LogicalKeyboardKey.keyS,
        upKey =
            leftPlayer ? LogicalKeyboardKey.arrowUp : LogicalKeyboardKey.keyW;

  @override
  FutureOr<void> onLoad() async {
    final worldRect = gameRef.size.toRect();

    size = Vector2(10, 100);
    position.x = leftPlayer ? 10 : worldRect.width - 10 - size.x;
    position.y = worldRect.height / 2 - size.y / 2;
    paddle = RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.blue,
    );

    paddleHitBox = RectangleHitbox(
      size: size,
    );

    await addAll([
      paddle,
      paddleHitBox,
    ]);

    await add(
      KeyboardListenerComponent(
        keyDown: {
          downKey: (keysPressed) {
            movementState = MovementState.down;
            return true;
          },
          upKey: (p0) {
            movementState = MovementState.up;
            return true;
          }
        },
        keyUp: {
          downKey: (keysPressed) {
            movementState = MovementState.still;
            return true;
          },
          upKey: (p0) {
            movementState = MovementState.still;
            return true;
          }
        },
      ),
    );

    return super.onLoad();
  }

  @override
  void update(double dt) {
    double newY = position.y;
    if (movementState == MovementState.down) {
      newY += speed * dt;
    } else if (movementState == MovementState.up) {
      newY -= speed * dt;
    }
    if (newY > 0 && newY < gameRef.size.y - size.y) {
      position.y = newY;
    }
    super.update(dt);
  }
}
