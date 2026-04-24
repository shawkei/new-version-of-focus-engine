import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/theme.dart';

class CircularTimer extends StatelessWidget {
  final int duration;
  final double progress;
  final bool isRunning;
  
  const CircularTimer({
    super.key,
    required this.duration,
    required this.progress,
    required this.isRunning,
  });
  
  String get _timeText {
    final remaining = (duration * 60 * (1 - progress)).round();
    final mins = remaining ~/ 60;
    final secs = remaining % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(280, 280),
            painter: _TimerRingPainter(
              progress: 1.0,
              color: AppTheme.primary.withOpacity(0.08),
              strokeWidth: 8,
            ),
          ),
          CustomPaint(
            size: const Size(280, 280),
            painter: _TimerRingPainter(
              progress: progress,
              color: AppTheme.primary,
              strokeWidth: 8,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: isRunning ? AppTheme.primary : AppTheme.textPrimary,
                ),
                child: Text(_timeText),
              ),
              if (!isRunning)
                Text(
                  '$duration min',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  
  _TimerRingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
