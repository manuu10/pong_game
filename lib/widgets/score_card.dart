import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pong_game/data/game_score/game_score_cubit.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key});

  static const color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    final score = context.watch<GameScoreCubit>();
    return Container(
      decoration: BoxDecoration(
        color: color.withAlpha(100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "${score.state.playerLeftScore} : ${score.state.playerRightScore}",
          style: const TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
