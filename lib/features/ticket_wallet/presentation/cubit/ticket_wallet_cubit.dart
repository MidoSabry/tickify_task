import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_state.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/use_cases/get_tickets_use_case.dart';

@injectable
class TicketWalletCubit extends Cubit<BaseState> {
  TicketWalletCubit({required this.getTicketsUseCase})
    : super(const InitialState());

  final GetTicketsUseCase getTicketsUseCase;

  Future<void> getTickets() async {
    emit(LoadingState());

    final result = await getTicketsUseCase();

    result.fold(
      (failure) {
        emit(ErrorState(failure.message));
      },
      (tickets) {
        emit(LoadedState<List<Ticket>>(tickets));
      },
    );
  }

  void clearTicketsForDemo() {
    emit(const LoadedState<List<Ticket>>([]));
  }

  void showErrorForDemo() {
    emit(const ErrorState('This is a demo error.'));
  }
}
