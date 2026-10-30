import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tickify_task/core/navigation/app_routes.dart';
import 'package:tickify_task/core/widgets/shared_text.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/ticket.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final statusColor = _statusColor(ticket.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: colors.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => context.push(AppRoutes.ticketDetails, extra: ticket),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.confirmation_number_outlined,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: ticket.eventName,
                      size: AppTextSize.medium,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    AppText(
                      text: _formatDate(ticket.eventDate),
                      size: AppTextSize.small,
                      color: colors.onSurfaceVariant,
                    ),
                    const SizedBox(height: 4),
                    AppText(
                      text: '${ticket.venue} · ${ticket.ticketType}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: colors.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AppText(
                  text: _statusLabel(ticket.status),
                  size: AppTextSize.small,
                  color: statusColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(TicketStatus status) {
    switch (status) {
      case TicketStatus.active:
        return AppColors.success;
      case TicketStatus.used:
        return AppColors.textSecondary;
      case TicketStatus.expired:
        return AppColors.error;
    }
  }

  String _statusLabel(TicketStatus status) {
    switch (status) {
      case TicketStatus.active:
        return 'Active';
      case TicketStatus.used:
        return 'Used';
      case TicketStatus.expired:
        return 'Expired';
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year} · ${_formatTime(date)}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }
}
