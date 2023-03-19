import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_score_state.dart';

class GameScoreCubit extends Cubit<GameScoreState> {
  GameScoreCubit() : super(const GameScoreState());

  void onScored(bool leftScored) {
    if (leftScored) {
      emit(state.copyWith(playerLeftScore: state.playerLeftScore + 1));
    } else {
      emit(state.copyWith(playerRightScore: state.playerRightScore + 1));
    }
  }
}
