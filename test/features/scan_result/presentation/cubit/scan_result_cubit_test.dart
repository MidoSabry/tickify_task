import 'package:flutter_test/flutter_test.dart';
import 'package:tickify_task/core/base/base_state.dart';
import 'package:tickify_task/features/scan_result/domain/entities/scan_result.dart';
import 'package:tickify_task/features/scan_result/domain/repositories/scan_result_repository.dart';
import 'package:tickify_task/features/scan_result/domain/use_cases/get_scan_result_use_case.dart';
import 'package:tickify_task/features/scan_result/presentation/cubit/scan_result_cubit.dart';

class FakeScanResultRepository implements ScanResultRepository {
  FakeScanResultRepository(this.result);

  final ScanResult result;
  ScanResultType? requestedType;

  @override
  ScanResult getResult(ScanResultType type) {
    requestedType = type;
    return result;
  }
}

void _testScanOutcome({
  required String testDescription,
  required ScanResultType type,
  DateTime? checkedInAt,
  InvalidReason? invalidReason,
}) {
  test(testDescription, () async {
    final expectedResult = ScanResult(
      type: type,
      ticketHolderName: 'Mohamed Sabry',
      eventName: 'Cairo Jazz Festival',
      ticketTier: 'VIP',
      checkedInAt: checkedInAt,
      invalidReason: invalidReason,
    );

    final repository = FakeScanResultRepository(expectedResult);
    final useCase = GetScanResultUseCase(repository);
    final cubit = ScanResultCubit(getScanResultUseCase: useCase);

    cubit.showResult(type);

    expect(repository.requestedType, type);
    expect(cubit.state, isA<LoadedState<ScanResult>>());

    final state = cubit.state as LoadedState<ScanResult>;
    expect(state.data, same(expectedResult));

    await cubit.close();
  });
}

void main() {
  _testScanOutcome(
    testDescription: 'emits a loaded state for a valid ticket',
    type: ScanResultType.valid,
  );

  _testScanOutcome(
    testDescription: 'emits a loaded state for an already-used ticket',
    type: ScanResultType.alreadyUsed,
    checkedInAt: DateTime(2026, 11, 15, 20),
  );

  _testScanOutcome(
    testDescription: 'emits a loaded state for an invalid ticket',
    type: ScanResultType.invalid,
    invalidReason: InvalidReason.wrongEvent,
  );
}
