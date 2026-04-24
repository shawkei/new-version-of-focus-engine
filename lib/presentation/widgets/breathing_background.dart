import 'package:flutter/material.dart';
import '../../core/theme.dart';

class BreathingBackground extends StatefulWidget {
  final Widget child;

  const BreathingBackground({super.key, required this.child});

  @override
  State<BreathingBackground> createState() => _BreathingBackgroundState();
}

class _BreathingBackgroundState extends State<BreathingBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                AppTheme.primaryLight.withOpacity(0.1 + _controller.value * 0.08),
                AppTheme.background,
              ],
              radius: 0.8 + _controller.value * 0.2,
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
