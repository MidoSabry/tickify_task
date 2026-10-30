import 'package:flutter/material.dart';
import 'package:tickify_task/core/widgets/shared_text.dart';
import 'package:tickify_task/features/scan_result/domain/entities/scan_result.dart';
import 'package:tickify_task/features/scan_result/presentation/widgets/result_header.dart';

class ScanResultContent extends StatelessWidget {
  const ScanResultContent({super.key, required this.result});

  final ScanResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.65, end: 1),
                duration: const Duration(milliseconds: 650),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) {
                  final opacity = ((scale - 0.65) / 0.35).clamp(0.0, 1.0);

                  return Opacity(
                    opacity: opacity,
                    child: Transform.scale(scale: scale, child: child),
                  );
                },
                child: ResultHeader(type: result.type),
              ),
              const SizedBox(height: 20),
              Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                color: theme.colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'Ticket information',
                        size: AppTextSize.medium,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(height: 18),
                      _InfoRow(
                        icon: Icons.person_outline,
                        label: 'Ticket holder',
                        value: result.ticketHolderName,
                      ),
                      const Divider(height: 24),
                      _InfoRow(
                        icon: Icons.event_outlined,
                        label: 'Event',
                        value: result.eventName,
                      ),
                      const Divider(height: 24),
                      _InfoRow(
                        icon: Icons.confirmation_number_outlined,
                        label: 'Ticket tier',
                        value: result.ticketTier,
                      ),
                      if (result.checkedInAt != null) ...[
                        const Divider(height: 24),
                        _InfoRow(
                          icon: Icons.access_time,
                          label: 'Checked in at',
                          value: _formatDateTime(result.checkedInAt!),
                        ),
                      ],
                      if (result.invalidReason != null) ...[
                        const SizedBox(height: 20),
                        _ReasonCard(
                          reason: _invalidReasonText(result.invalidReason!),
                        ),
                      ],
                    ],
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 21, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: label,
                size: AppTextSize.small,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 4),
              AppText(text: value, fontWeight: FontWeight.w600),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReasonCard extends StatelessWidget {
  const _ReasonCard({required this.reason});

  final String reason;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.error;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'Why this ticket is invalid',
                  size: AppTextSize.small,
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 4),
                AppText(text: reason),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _invalidReasonText(InvalidReason reason) {
  switch (reason) {
    case InvalidReason.wrongEvent:
      return 'Wrong event';
    case InvalidReason.expired:
      return 'Ticket expired';
  }
}

String _formatDateTime(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final hour = (date.hour % 12 == 0 ? 12 : date.hour % 12).toString().padLeft(
    2,
    '0',
  );
  final minute = date.minute.toString().padLeft(2, '0');
  final period = date.hour >= 12 ? 'PM' : 'AM';

  return '$day/$month/${date.year} · $hour:$minute $period';
}
