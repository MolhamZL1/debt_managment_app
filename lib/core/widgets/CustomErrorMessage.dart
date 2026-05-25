import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class CustomErrorMessage extends StatefulWidget {
  const CustomErrorMessage({
    super.key,
    required this.message,
    required this.onReload,
  });
  final String message;
  final VoidCallback onReload;

  @override
  State<CustomErrorMessage> createState() => _CustomErrorMessageState();
}

class _CustomErrorMessageState extends State<CustomErrorMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _buttonScaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final errorColor = colorScheme.error;
    final l10n = S.of(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Icon(
                    Icons.error_rounded,
                    color: errorColor.withOpacity(_fadeAnimation.value),
                    size: 38 + (_fadeAnimation.value * 12),
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                widget.message,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge!.copyWith(
                  color: errorColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              ScaleTransition(
                scale: _buttonScaleAnimation,
                child: ElevatedButton.icon(
                  onPressed: widget.onReload,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(l10n.retry),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    minimumSize: const Size(108, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
