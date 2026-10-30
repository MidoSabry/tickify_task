import 'package:dartz/dartz.dart';
import 'package:tickify_task/features/ticket_wallet/domain/entities/ticket.dart';

import '../../../../core/error/failure.dart';

abstract class TicketWalletRepository {
  Future<Either<Failure, List<Ticket>>> getTickets();
}
