import '../entities/scan_result.dart';

abstract class ScanResultRepository {
  ScanResult getResult(ScanResultType type);
}
