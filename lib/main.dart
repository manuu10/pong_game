import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pong_game/app/pong_game.dart';
import 'package:pong_game/data/game_score/game_score_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pong_game/widgets/score_card.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => GameScoreCubit(),
      child: const GameWrapper(),
    ),
  );
}

class GameWrapper extends StatelessWidget {
  const GameWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: const [
            GameView(),
            Align(
              alignment: Alignment.topCenter,
              child: ScoreCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final score = context.read<GameScoreCubit>();
    return GameWidget(game: PongGame(score));
  }
}
