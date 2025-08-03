// // import 'package:flutter/material.dart';
// //
// // class ResultScreen extends StatelessWidget {
// //   final bool isSuccess;
// //   final int score;
// //   final VoidCallback onRetry;
// //   final VoidCallback onNext;
// //   const ResultScreen({super.key, required this.isSuccess, required this.score, required this.onRetry, required this.onNext});
// //
// //   @override Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: isSuccess ? Colors.green[50] : Colors.red[50],
// //       body: Center(
// //         child: Column(mainAxisAlignment: MainAxisAlignment.center, children:[
// //           Icon(isSuccess?Icons.celebration:Icons.error, size:80, color: isSuccess?Colors.green:Colors.red),
// //           const SizedBox(height:20),
// //           Text(isSuccess?'🎉 Level Complete':'⏱ Time Up', style: const TextStyle(fontSize:26, fontWeight: FontWeight.bold)),
// //           const SizedBox(height:10),
// //           Text('Score: $score', style: const TextStyle(fontSize:20)),
// //           const SizedBox(height:30),
// //           ElevatedButton(
// //               onPressed: isSuccess ? onNext : onRetry,
// //               style: ElevatedButton.styleFrom(backgroundColor: isSuccess?Colors.green:Colors.redAccent, padding: const EdgeInsets.symmetric(horizontal:40,vertical:12)),
// //               child: Text(isSuccess?'Next Level':'Retry', style: const TextStyle(fontSize:18))),
// //         ]),
// //       ),
// //     );
// //   }
// // }
// // result_screen.dart
// import 'package:flutter/material.dart';
//
// class ResultScreen extends StatelessWidget {
//   final bool isSuccess;
//   final int score;
//   final VoidCallback onRetry;
//   final VoidCallback onNext;
//
//   const ResultScreen({
//     super.key,
//     required this.isSuccess,
//     required this.score,
//     required this.onRetry,
//     required this.onNext,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: isSuccess ? Colors.green.shade50 : Colors.red.shade50,
//       body: Stack(
//         children: [
//       // Decorative background
//       Positioned.fill(
//       child: DecoratedBox(
//       decoration: BoxDecoration(
//       gradient: LinearGradient(
//       begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: isSuccess
//             ? [Colors.green.shade100, Colors.green.shade50]
//             : [Colors.red.shade100, Colors.red.shade50],
//       ),
//     ),
//     ),
//     ),
//     Align(
//     alignment: Alignment.topCenter,
//     child: Padding(
//     padding: const EdgeInsets.only(top: 80.0),
//     child: Text(
//     isSuccess ? "🌟 YOU DID IT! 🌟" : "💥 OOPS! TIME'S UP 💥" ,
//     style: const TextStyle(
//     fontSize: 30,
//     fontWeight: FontWeight.bold,
//     ),
//     ),
//     ),
//     ),
//     Center(
//     child: Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 24.0),
//     child: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//     AnimatedContainer(
//     duration: const Duration(milliseconds: 500),
//     padding: const EdgeInsets.all(30),
//     decoration: BoxDecoration(
//     color: isSuccess ? Colors.green.shade200 : Colors.red.shade200,
//     shape: BoxShape.circle,
//     boxShadow: [
//     BoxShadow(
//     color: Colors.black12,
//     blurRadius: 12,
//     spreadRadius: 2,
//     offset: Offset(0, 6),
//     )
//     ],
//     ),
//     child: Icon(
//     isSuccess ? Icons.emoji_events : Icons.timer_off,
//     size: 80,
//     color: Colors.white,
//     ),
//     ),
//     const SizedBox(height: 30),
//     Text(
//     'Score: $score ⭐',
//     style: const TextStyle(
//     fontSize: 24,
//     fontWeight: FontWeight.w600,
//     color: Colors.black87,
//     ),
//     ),
//     const SizedBox(height: 40),
//     ElevatedButton.icon(
//     onPressed: isSuccess ? onNext : onRetry,
//     icon: Icon(isSuccess ? Icons.arrow_forward : Icons.replay),
//     label: Text(isSuccess ? 'Next Level' : 'Retry'),
//     style: ElevatedButton.styleFrom(
//     backgroundColor: isSuccess ? Colors.green.shade600 : Colors.red.shade600,
//     foregroundColor: Colors.white,
//     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//     shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(20),
//     ),
//     textStyle: const TextStyle(fontSize: 18),
//     ),
//     ),
//     ],
//     ),
//     ),
//     ),
//     ],
//     ),
//     );
//   }
// }
//
// result_screen.dart
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class ResultScreen extends StatefulWidget {
  final bool isSuccess;
  final int score;
  final VoidCallback onRetry;
  final VoidCallback onNext;

  const ResultScreen({
    super.key,
    required this.isSuccess,
    required this.score,
    required this.onRetry,
    required this.onNext,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiControllerTop;
  late ConfettiController _confettiControllerCenter;

  @override
  void initState() {
    super.initState();
    _confettiControllerTop = ConfettiController(duration: const Duration(seconds: 2));
    _confettiControllerCenter = ConfettiController(duration: const Duration(seconds: 2));

    if (widget.isSuccess) {
      _confettiControllerTop.play();
      _confettiControllerCenter.play();
    }
  }

  @override
  void dispose() {
    _confettiControllerTop.dispose();
    _confettiControllerCenter.dispose();
    super.dispose();
  }

  Widget _buildStars() {
    int stars = (widget.score / 10).clamp(1, 3).toInt();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Icon(
          index < stars ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 40,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isSuccess ? Colors.green.shade50 : Colors.red.shade50,
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.isSuccess
                      ? [Colors.green.shade100, Colors.green.shade50]
                      : [Colors.red.shade100, Colors.red.shade50],
                ),
              ),
            ),
          ),

          // Top confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiControllerTop,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.yellow, Colors.green, Colors.blue, Colors.orange, Colors.pink],
            ),
          ),

          // Center confetti
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiControllerCenter,
              blastDirection: -pi / 2,
              emissionFrequency: 0.03,
              numberOfParticles: 15,
              maxBlastForce: 20,
              minBlastForce: 5,
              gravity: 0.1,
              shouldLoop: false,
              colors: const [Colors.yellow, Colors.purple, Colors.cyan],
            ),
          ),

          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title with emoji
                  Text(
                    widget.isSuccess ? '🎉 YOU WON! 🎉' : '💥 OOPS! TIME\'S UP 💥',
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Badge or Emoji
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: widget.isSuccess ? Colors.green.shade200 : Colors.red.shade200,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 12, spreadRadius: 1, offset: Offset(0, 6)),
                      ],
                    ),
                    child: Icon(
                      widget.isSuccess ? Icons.emoji_events : Icons.timer_off,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Score + Stars
                  Text(
                    'Score: ${widget.score} ⭐',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  _buildStars(),

                  const SizedBox(height: 40),

                  // Action button
                  ElevatedButton.icon(
                    onPressed: widget.isSuccess ? widget.onNext : widget.onRetry,
                    icon: Icon(widget.isSuccess ? Icons.arrow_forward : Icons.replay),
                    label: Text(widget.isSuccess ? 'Next Level' : 'Try Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.isSuccess ? Colors.green.shade600 : Colors.red.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
