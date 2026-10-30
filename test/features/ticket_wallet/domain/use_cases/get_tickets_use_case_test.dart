import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tickify_task/core/error/failure.dart';
import 'package:tickify_task/features/ticket_wallet/domain/entities/ticket.dart';
import 'package:tickify_task/features/ticket_wallet/domain/repositories/ticket_wallet_repository.dart';
import 'package:tickify_task/features/ticket_wallet/domain/use_cases/get_tickets_use_case.dart';

class FakeTicketWalletRepository implements TicketWalletRepository {
  FakeTicketWalletRepository(this.tickets);

  final List<Ticket> tickets;

  @override
  Future<Either<Failure, List<Ticket>>> getTickets() async {
    return Right(tickets);
  }
}

void main() {
  test('returns tickets from the repository', () async {
    final expectedTickets = [
      Ticket(
        id: 'TICK-1001',
        eventName: 'Cairo Jazz Festival',
        eventDate: DateTime(2026, 11, 15, 20),
        venue: 'Cairo Opera House',
        ticketType: 'VIP',
        holderName: 'Mohamed Sabry',
        status: TicketStatus.active,
      ),
    ];

    final repository = FakeTicketWalletRepository(expectedTickets);
    final useCase = GetTicketsUseCase(repository);

    final result = await useCase();

    final actualTickets = result.fold(
      (failure) => throw Exception(failure.message),
      (tickets) => tickets,
    );

    expect(actualTickets, expectedTickets);
  });
}