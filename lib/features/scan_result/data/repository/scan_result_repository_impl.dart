import 'package:injectable/injectable.dart';

import '../../domain/entities/scan_result.dart';
import '../../domain/repositories/scan_result_repository.dart';
import '../data_source/scan_result_mock_data_source.dart';

@LazySingleton(as: ScanResultRepository)
class ScanResultRepositoryImpl implements ScanResultRepository {
  ScanResultRepositoryImpl(this._dataSource);

  final ScanResultDataSource _dataSource;

  @override
  ScanResult getResult(ScanResultType type) {
    return _dataSource.getResult(type);
  }
}
