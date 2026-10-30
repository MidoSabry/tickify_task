import 'package:injectable/injectable.dart';
import 'package:tickify_task/features/ticket_wallet/domain/entities/ticket.dart';

import '../model/ticket_model.dart';

abstract class TicketWalletDataSource {
  Future<List<TicketModel>> getTickets();
}

@LazySingleton(as: TicketWalletDataSource)
class TicketWalletMockDataSource implements TicketWalletDataSource {
  @override
  Future<List<TicketModel>> getTickets() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return [
      TicketModel(
        id: 'TICK-1001',
        eventName: 'Cairo Jazz Festival',
        eventDate: DateTime(2026, 11, 15, 20),
        venue: 'Cairo Opera House',
        ticketType: 'VIP',
        holderName: 'Mohamed Sabry',
        status: TicketStatus.active,
      ),
      TicketModel(
        id: 'TICK-1002',
        eventName: 'Tech Summit Cairo',
        eventDate: DateTime(2026, 11, 20, 10),
        venue: 'Egypt International Exhibition Center',
        ticketType: 'Regular',
        holderName: 'Mohamed Sabry',
        status: TicketStatus.active,
      ),
      TicketModel(
        id: 'TICK-1003',
        eventName: 'Alexandria Music Night',
        eventDate: DateTime(2026, 9, 10, 19),
        venue: 'Bibliotheca Alexandrina',
        ticketType: 'Standard',
        holderName: 'Mohamed Sabry',
        status: TicketStatus.used,
      ),
      TicketModel(
        id: 'TICK-1004',
        eventName: 'Startup Weekend',
        eventDate: DateTime(2026, 8, 5, 9),
        venue: 'Greek Campus Cairo',
        ticketType: 'Early Bird',
        holderName: 'Mohamed Sabry',
        status: TicketStatus.expired,
      ),
    ];
  }
}
