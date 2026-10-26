import 'package:flutter/material.dart';
import 'package:mediconnect/core/theme/app_colors.dart';

class MedicalNetworkMeshPainter extends CustomPainter {
  const MedicalNetworkMeshPainter();

  @override
  void paint(Canvas canvas, Size size) {
    _drawTopRightMesh(canvas, size);
    _drawBottomLeftMesh(canvas, size);
  }

  void _drawTopRightMesh(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.12)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    final glowPaint = Paint()
      ..color = AppColors.secondary.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    // Top-Right Node Coordinates
    final nodes = [
      Offset(size.width - 20, 40),
      Offset(size.width - 70, 30),
      Offset(size.width - 130, 60),
      Offset(size.width - 40, 110),
      Offset(size.width - 100, 130),
      Offset(size.width - 160, 110),
      Offset(size.width - 60, 180),
      Offset(size.width - 130, 200),
      Offset(size.width - 200, 170),
    ];

    // Interconnecting Network Lines
    final connections = [
      [0, 1],
      [1, 2],
      [0, 3],
      [1, 3],
      [1, 4],
      [2, 4],
      [2, 5],
      [3, 4],
      [3, 6],
      [4, 6],
      [4, 7],
      [5, 7],
      [5, 8],
      [6, 7],
      [7, 8],
    ];

    for (final conn in connections) {
      canvas.drawLine(nodes[conn[0]], nodes[conn[1]], linePaint);
    }

    // Outer Glow Halos & Inner Nodes
    for (int i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      final radius = (i % 3 == 0) ? 4.0 : 2.5;

      // Glow halo on key nodes
      if (i % 2 == 0) {
        canvas.drawCircle(node, radius * 3.5, glowPaint);
      }
      canvas.drawCircle(node, radius, nodePaint);
    }

    // Decorative Medical Cross marker in top corner
    _drawMedicalCross(
      canvas,
      Offset(size.width - 170, 50),
      size: 14.0,
      color: AppColors.primary.withValues(alpha: 0.15),
    );
  }

  void _drawBottomLeftMesh(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.secondary.withValues(alpha: 0.10)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = AppColors.secondary.withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;

    final glowPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.06)
      ..style = PaintingStyle.fill;

    // Bottom-Left Node Coordinates
    final nodes = [
      Offset(30, size.height - 40),
      Offset(80, size.height - 50),
      Offset(140, size.height - 30),
      Offset(40, size.height - 110),
      Offset(100, size.height - 120),
      Offset(160, size.height - 100),
      Offset(60, size.height - 180),
      Offset(120, size.height - 180),
      Offset(190, size.height - 160),
    ];

    // Interconnecting Network Lines
    final connections = [
      [0, 1],
      [1, 2],
      [0, 3],
      [1, 3],
      [1, 4],
      [2, 4],
      [2, 5],
      [3, 4],
      [3, 6],
      [4, 6],
      [4, 7],
      [5, 7],
      [5, 8],
      [6, 7],
      [7, 8],
    ];

    for (final conn in connections) {
      canvas.drawLine(nodes[conn[0]], nodes[conn[1]], linePaint);
    }

    for (int i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      final radius = (i % 2 == 0) ? 3.5 : 2.2;

      if (i % 3 == 0) {
        canvas.drawCircle(node, radius * 3.0, glowPaint);
      }
      canvas.drawCircle(node, radius, nodePaint);
    }

    // Decorative Medical Cross marker in bottom corner
    _drawMedicalCross(
      canvas,
      Offset(170, size.height - 60),
      size: 12.0,
      color: AppColors.secondary.withValues(alpha: 0.14),
    );
  }

  void _drawMedicalCross(Canvas canvas, Offset center,
      {required double size, required Color color}) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final barThickness = size * 0.32;

    // Horizontal bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: size, height: barThickness),
        Radius.circular(barThickness / 2),
      ),
      paint,
    );

    // Vertical bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: barThickness, height: size),
        Radius.circular(barThickness / 2),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
