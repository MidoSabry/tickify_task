import 'package:flutter/material.dart';

class ScannerCorners extends StatelessWidget {
  const ScannerCorners({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ScannerCornerPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _ScannerCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const inset = 18.0;
    const cornerLength = 48.0;

    final outlinePaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.35)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final cornerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final corners = <Path>[
      Path()
        ..moveTo(inset, inset + cornerLength)
        ..lineTo(inset, inset)
        ..lineTo(inset + cornerLength, inset),
      Path()
        ..moveTo(size.width - inset - cornerLength, inset)
        ..lineTo(size.width - inset, inset)
        ..lineTo(size.width - inset, inset + cornerLength),
      Path()
        ..moveTo(inset, size.height - inset - cornerLength)
        ..lineTo(inset, size.height - inset)
        ..lineTo(inset + cornerLength, size.height - inset),
      Path()
        ..moveTo(size.width - inset - cornerLength, size.height - inset)
        ..lineTo(size.width - inset, size.height - inset)
        ..lineTo(size.width - inset, size.height - inset - cornerLength),
    ];

    for (final path in corners) {
      canvas.drawPath(path, outlinePaint);
      canvas.drawPath(path, cornerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
