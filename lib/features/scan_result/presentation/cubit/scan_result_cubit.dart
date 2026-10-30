import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_state.dart';
import '../../domain/entities/scan_result.dart';
import '../../domain/use_cases/get_scan_result_use_case.dart';

@injectable
class ScanResultCubit extends Cubit<BaseState> {
  ScanResultCubit({required this.getScanResultUseCase})
    : super(const InitialState());

  final GetScanResultUseCase getScanResultUseCase;

  void showResult(ScanResultType type) {
    final result = getScanResultUseCase(type);
    emit(LoadedState<ScanResult>(result));
  }
}
