import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../entities/ticket.dart';
import '../repositories/ticket_wallet_repository.dart';

@lazySingleton
class GetTicketsUseCase {
  const GetTicketsUseCase(this._repository);

  final TicketWalletRepository _repository;

  Future<Either<Failure, List<Ticket>>> call() {
    return _repository.getTickets();
  }
}
