import 'package:flutter/material.dart';
import 'package:tickify_task/core/widgets/shared_text.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/scan_result.dart';

class ResultHeader extends StatefulWidget {
  const ResultHeader({super.key, required this.type});

  final ScanResultType type;

  @override
  State<ResultHeader> createState() => _ResultHeaderState();
}

class _ResultHeaderState extends State<ResultHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _iconSlideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _iconSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    Future<void>.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(widget.type);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Column(
        children: [
          ClipRect(
            child: SlideTransition(
              position: _iconSlideAnimation,
              child: Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(_iconFor(widget.type), size: 42, color: color),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AppText(
            text: _titleFor(widget.type),
            size: AppTextSize.headline,
            fontWeight: FontWeight.w800,
            color: color,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          AppText(
            text: _messageFor(widget.type),
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _colorFor(ScanResultType type) {
    switch (type) {
      case ScanResultType.valid:
        return AppColors.success;
      case ScanResultType.alreadyUsed:
        return AppColors.warning;
      case ScanResultType.invalid:
        return AppColors.error;
    }
  }

  IconData _iconFor(ScanResultType type) {
    switch (type) {
      case ScanResultType.valid:
        return Icons.check_circle_outline;
      case ScanResultType.alreadyUsed:
        return Icons.history;
      case ScanResultType.invalid:
        return Icons.cancel_outlined;
    }
  }

  String _titleFor(ScanResultType type) {
    switch (type) {
      case ScanResultType.valid:
        return 'Valid Ticket';
      case ScanResultType.alreadyUsed:
        return 'Already Used';
      case ScanResultType.invalid:
        return 'Invalid Ticket';
    }
  }

  String _messageFor(ScanResultType type) {
    switch (type) {
      case ScanResultType.valid:
        return 'This ticket is valid. Entry is approved.';
      case ScanResultType.alreadyUsed:
        return 'This ticket has already been checked in.';
      case ScanResultType.invalid:
        return 'This ticket cannot be accepted.';
    }
  }
}
