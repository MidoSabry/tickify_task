import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tickify_task/core/widgets/shared_text.dart';
import '../../domain/entities/ticket.dart';

class TicketDetailsScreen extends StatelessWidget {
  const TicketDetailsScreen({super.key, required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final date = ticket.eventDate;
    final formattedDate =
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';

    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: 'Ticket Details', size: AppTextSize.title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: ticket.eventName,
                        size: AppTextSize.headline,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 20),
                      _DetailRow(label: 'Date', value: formattedDate),
                      _DetailRow(label: 'Venue', value: ticket.venue),
                      _DetailRow(
                        label: 'Ticket type',
                        value: ticket.ticketType,
                      ),
                      _DetailRow(
                        label: 'Ticket holder',
                        value: ticket.holderName,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      AppText(
                        text: 'Show this QR code at the entrance',
                        size: AppTextSize.medium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      QrImageView(
                        data: ticket.id,
                        size: 220,
                        backgroundColor: Colors.white,
                        semanticsLabel: 'QR code for ticket ${ticket.id}',
                      ),
                      const SizedBox(height: 12),
                      AppText(
                        text: ticket.id,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: AppText(
              text: label,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Expanded(
            child: AppText(text: value, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
