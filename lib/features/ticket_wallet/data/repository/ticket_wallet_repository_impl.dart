import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/repositories/ticket_wallet_repository.dart';
import '../data_source/ticket_wallet_mock_data_source.dart';

@LazySingleton(as: TicketWalletRepository)
class TicketWalletRepositoryImpl implements TicketWalletRepository {
  TicketWalletRepositoryImpl(this._dataSource);

  final TicketWalletDataSource _dataSource;

  @override
  Future<Either<Failure, List<Ticket>>> getTickets() async {
    try {
      final ticketModels = await _dataSource.getTickets();
      final tickets = ticketModels.map((model) => model.toDomain()).toList();

      return Right(tickets);
    } catch (error) {
      return Left(GeneralFailure(error.toString()));
    }
  }
}