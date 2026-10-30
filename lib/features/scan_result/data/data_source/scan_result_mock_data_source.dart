import 'package:injectable/injectable.dart';

import '../../domain/entities/scan_result.dart';

abstract class ScanResultDataSource {
  ScanResult getResult(ScanResultType type);
}

@LazySingleton(as: ScanResultDataSource)
class ScanResultMockDataSource implements ScanResultDataSource {
  @override
  ScanResult getResult(ScanResultType type) {
    switch (type) {
      case ScanResultType.valid:
        return const ScanResult(
          type: ScanResultType.valid,
          ticketHolderName: 'Mohamed Sabry',
          eventName: 'Cairo Jazz Festival',
          ticketTier: 'VIP',
        );

      case ScanResultType.alreadyUsed:
        return ScanResult(
          type: ScanResultType.alreadyUsed,
          ticketHolderName: 'Mohamed Sabry',
          eventName: 'Cairo Jazz Festival',
          ticketTier: 'VIP',
          checkedInAt: DateTime(2026, 11, 15, 20, 30),
        );

      case ScanResultType.invalid:
        return const ScanResult(
          type: ScanResultType.invalid,
          ticketHolderName: 'Mohamed Sabry',
          eventName: 'Cairo Jazz Festival',
          ticketTier: 'VIP',
          invalidReason: InvalidReason.wrongEvent,
        );
    }
  }
}
