import 'package:flutter/material.dart';

class GridCell extends StatelessWidget {
  final int value;
  final bool isMatched;
  final bool isSelected;
  final VoidCallback onTap;

  const GridCell({
    super.key,
    required this.value,
    required this.isMatched,
    required this.isSelected,
    required this.onTap,
  });

  Color _getColorByValue(int val) {
    final colors = [
      Colors.lightGreen.shade300,
      Colors.green.shade400,
      Colors.teal.shade300,
      Colors.brown.shade300,
      Colors.orange.shade300,
      Colors.deepOrange.shade400,
      Colors.amber.shade400,
      Colors.deepPurple.shade300,
      Colors.cyan.shade300,
      Colors.indigo.shade300,
    ];
    return colors[val % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = isMatched ? Colors.grey:_getColorByValue(value);
    final borderColor = isSelected
        ? Colors.yellowAccent :
         Colors.transparent;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [baseColor.withOpacity(0.8), baseColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: borderColor, width: 3),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: baseColor.withOpacity(0.4),
              offset: Offset(0, 4),
              blurRadius: 6,
            )
          ],
        ),
        child: Center(
          child: Text(
            '$value',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isMatched ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
