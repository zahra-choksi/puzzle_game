import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Status { playing, passed, failed }

class GameState {
  final int level;
  final List<int> cells;
  final Set<int> matched;
  final List<int> selected;
  final int score;
  final int timeLeft;
  final Status status;
  GameState({required this.level, required this.cells, required this.matched,
    required this.selected, required this.score, required this.timeLeft, required this.status});
  GameState copyWith({int? level, List<int>? cells, Set<int>? matched, List<int>? selected, int? score, int? timeLeft, Status? status}) => GameState(
    level: level ?? this.level,
    cells: cells ?? this.cells,
    matched: matched ?? this.matched,
    selected: selected ?? this.selected,
    score: score ?? this.score,
    timeLeft: timeLeft ?? this.timeLeft,
    status: status ?? this.status,
  );
}

class GameController extends StateNotifier<GameState> {
  Timer? _timer;
  static const lvlDuration = 120;

  GameController(): super(_init(1)) {
    _startTimer();
  }

  static GameState _init(int lvl) {
    final rand = Random();
    final cells = <int>[];
    final count = (lvl + 1) * 8; // grid size grows
    for (var i = 0; i < count; i++) {
      int a = rand.nextInt(9) + 1;
      int b = rand.nextBool() ? a : 10 - a;
      cells.addAll([a, b]);
    }
    cells.shuffle();
    return GameState(level: lvl, cells: cells, matched: {}, selected: [], score: 0, timeLeft: lvlDuration, status: Status.playing);
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds:1), (t) {
      if (state.timeLeft <= 1) {
        state = state.copyWith(status: Status.failed);
        t.cancel();
      } else {
        state = state.copyWith(timeLeft: state.timeLeft -1);
      }
    });
  }

  void tapCell(int idx) {
    if (state.status != Status.playing) return;
    final sel = [...state.selected];
    if (sel.contains(idx) || sel.length == 2) return;
    sel.add(idx);
    state = state.copyWith(selected: sel);
    if (sel.length == 2) _checkMatch(sel[0], sel[1]);
  }

  void _checkMatch(int i, int j) {
    final a = state.cells[i], b = state.cells[j];
    if (a==b || a+b==10) {
      final newMatched = {...state.matched, i, j};
      final newScore = state.score + 10;
      final isPassed = newMatched.length >= state.cells.length;
      state = state.copyWith(
        matched: newMatched,
        selected: [],
        score: newScore,
        status: isPassed ? Status.passed : Status.playing,
      );
      if (isPassed) _timer?.cancel();
    } else {
      Future.delayed(const Duration(milliseconds:400), () {
        state = state.copyWith(selected: []);
      });
    }
  }

  void retry() {
    _timer?.cancel();
    state = _init(state.level);
    _startTimer();
  }

  void nextLevel() {
    _timer?.cancel();
    state = _init(state.level +1);
    _startTimer();
  }

  @override dispose() { _timer?.cancel(); super.dispose(); }
}

final gameProvider = StateNotifierProvider<GameController,GameState>((ref)=>GameController());
