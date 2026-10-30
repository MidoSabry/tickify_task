import 'package:flutter_test/flutter_test.dart';
import 'package:tickify_task/features/scan_result/domain/entities/scan_result.dart';
import 'package:tickify_task/features/scan_result/domain/repositories/scan_result_repository.dart';
import 'package:tickify_task/features/scan_result/domain/use_cases/get_scan_result_use_case.dart';

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

void _testUseCase({
  required String description,
  required ScanResultType type,
  DateTime? checkedInAt,
  InvalidReason? invalidReason,
}) {
  test(description, () {
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

    final result = useCase(type);

    expect(repository.requestedType, type);
    expect(result, same(expectedResult));
  });
}

void main() {
  _testUseCase(
    description: 'returns a valid ticket result',
    type: ScanResultType.valid,
  );

  _testUseCase(
    description: 'returns an already-used ticket result',
    type: ScanResultType.alreadyUsed,
    checkedInAt: DateTime(2026, 11, 15, 20),
  );

  _testUseCase(
    description: 'returns an invalid ticket result',
    type: ScanResultType.invalid,
    invalidReason: InvalidReason.wrongEvent,
  );
}