import 'package:equatable/equatable.dart';

enum TicketStatus {
  active,
  used,
  expired,
}

class Ticket extends Equatable {
  const Ticket({
    required this.id,
    required this.eventName,
    required this.eventDate,
    required this.venue,
    required this.ticketType,
    required this.holderName,
    required this.status,
  });

  final String id;
  final String eventName;
  final DateTime eventDate;
  final String venue;
  final String ticketType;
  final String holderName;
  final TicketStatus status;

  @override
  List<Object?> get props => [
        id,
        eventName,
        eventDate,
        venue,
        ticketType,
        holderName,
        status,
      ];
}