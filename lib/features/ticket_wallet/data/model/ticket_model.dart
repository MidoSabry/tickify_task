import 'package:tickify_task/features/ticket_wallet/domain/entities/ticket.dart';

class TicketModel {
  const TicketModel({
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

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as String,
      eventName: json['eventName'] as String,
      eventDate: DateTime.parse(json['eventDate'] as String),
      venue: json['venue'] as String,
      ticketType: json['ticketType'] as String,
      holderName: json['holderName'] as String,
      status: TicketStatus.values.byName(json['status'] as String),
    );
  }

  Ticket toDomain() {
    return Ticket(
      id: id,
      eventName: eventName,
      eventDate: eventDate,
      venue: venue,
      ticketType: ticketType,
      holderName: holderName,
      status: status,
    );
  }
}
