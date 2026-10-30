import 'package:injectable/injectable.dart';

import '../entities/scan_result.dart';
import '../repositories/scan_result_repository.dart';

@lazySingleton
class GetScanResultUseCase {
  const GetScanResultUseCase(this._repository);

  final ScanResultRepository _repository;

  ScanResult call(ScanResultType type) {
    return _repository.getResult(type);
  }
}
