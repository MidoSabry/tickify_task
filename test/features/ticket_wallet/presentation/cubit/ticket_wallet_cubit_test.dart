import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tickify_task/core/base/base_state.dart';
import 'package:tickify_task/core/error/failure.dart';
import 'package:tickify_task/features/ticket_wallet/domain/entities/ticket.dart';
import 'package:tickify_task/features/ticket_wallet/domain/repositories/ticket_wallet_repository.dart';
import 'package:tickify_task/features/ticket_wallet/domain/use_cases/get_tickets_use_case.dart';
import 'package:tickify_task/features/ticket_wallet/presentation/cubit/ticket_wallet_cubit.dart';

class FakeTicketWalletRepository implements TicketWalletRepository {
  FakeTicketWalletRepository(this.result);

  final Either<Failure, List<Ticket>> result;

  @override
  Future<Either<Failure, List<Ticket>>> getTickets() async => result;
}

TicketWalletCubit _createCubit(Either<Failure, List<Ticket>> result) {
  final repository = FakeTicketWalletRepository(result);
  final useCase = GetTicketsUseCase(repository);

  return TicketWalletCubit(getTicketsUseCase: useCase);
}

void main() {
  final ticket = Ticket(
    id: 'TICK-1001',
    eventName: 'Cairo Jazz Festival',
    eventDate: DateTime(2026, 11, 15, 20),
    venue: 'Cairo Opera House',
    ticketType: 'VIP',
    holderName: 'Mohamed Sabry',
    status: TicketStatus.active,
  );

  test('emits loading then loaded when tickets are returned', () async {
    final cubit = _createCubit(Right<Failure, List<Ticket>>([ticket]));

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<LoadingState>(),
        isA<LoadedState<List<Ticket>>>().having(
          (state) => state.data,
          'tickets',
          [ticket],
        ),
      ]),
    );

    await cubit.getTickets();
    await cubit.close();
    await expectation;
  });

  test('emits loading then error when repository fails', () async {
    final cubit = _createCubit(
      const Left<Failure, List<Ticket>>(GeneralFailure('Network error')),
    );

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<LoadingState>(),
        isA<ErrorState>().having(
          (state) => state.data,
          'error message',
          'Network error',
        ),
      ]),
    );

    await cubit.getTickets();
    await cubit.close();
    await expectation;
  });

  test(
    'emits an empty loaded state when repository returns no tickets',
    () async {
      final cubit = _createCubit(const Right<Failure, List<Ticket>>([]));

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          isA<LoadingState>(),
          isA<LoadedState<List<Ticket>>>().having(
            (state) => state.data,
            'tickets',
            isEmpty,
          ),
        ]),
      );

      await cubit.getTickets();
      await cubit.close();
      await expectation;
    },
  );
}
