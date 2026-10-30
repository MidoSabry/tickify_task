enum ScanResultType { valid, alreadyUsed, invalid }

enum InvalidReason { wrongEvent, expired }

class ScanResult {
  const ScanResult({
    required this.type,
    required this.ticketHolderName,
    required this.eventName,
    required this.ticketTier,
    this.checkedInAt,
    this.invalidReason,
  });

  final ScanResultType type;
  final String ticketHolderName;
  final String eventName;
  final String ticketTier;
  final DateTime? checkedInAt;
  final InvalidReason? invalidReason;
}
