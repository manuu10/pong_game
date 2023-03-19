// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_score_cubit.dart';

@immutable
class GameScoreState {
  final int playerLeftScore;
  final int playerRightScore;
  const GameScoreState({
    this.playerLeftScore = 0,
    this.playerRightScore = 0,
  });

  GameScoreState copyWith({
    int? playerLeftScore,
    int? playerRightScore,
  }) {
    return GameScoreState(
      playerLeftScore: playerLeftScore ?? this.playerLeftScore,
      playerRightScore: playerRightScore ?? this.playerRightScore,
    );
  }
}
