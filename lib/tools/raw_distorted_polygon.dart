/*
 * MIT License
 *
 * Copyright (c) 2023 Felipe D. Silva (a.k.a Coala Jedi)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class RawDistortedPolygon extends StatelessWidget {
  const RawDistortedPolygon({
    super.key,
    this.maxCornersOffset = 20,
    this.maxSideLength = 250,
    this.strokeWidth = 5,
    this.minRepetition = 2,
    this.maxRepetition = 5,
  });

  final double maxCornersOffset;
  final double maxSideLength;
  final double strokeWidth;
  final int minRepetition;
  final int maxRepetition;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _RawDistortedPolygonCustomPainter(
            strokeWidth: strokeWidth,
            maxSideLength: maxSideLength,
            maxCornersOffset: maxCornersOffset,
            maxRepetition: maxRepetition,
            minRepetition: minRepetition,
          ),
        ),
      ),
    );
  }
}

class _RawDistortedPolygonCustomPainter extends CustomPainter {
  _RawDistortedPolygonCustomPainter({
    this.maxCornersOffset = 20,
    this.maxSideLength = 250,
    this.strokeWidth = 5,
    this.minRepetition = 5,
    this.maxRepetition = 2,
  });

  final double maxCornersOffset;
  final double maxSideLength;
  final double strokeWidth;
  final int minRepetition;
  final int maxRepetition;

  static final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth;

    Offset topLeft = Offset.zero;
    Offset topRight = topLeft + Offset(maxSideLength, 0);
    Offset bottomRight = topLeft + Offset(maxSideLength, maxSideLength);
    Offset bottomLeft = topLeft + Offset(0, maxSideLength);

    final canvasCenter = Offset(size.width / 2, size.height / 2);

    final polygonCenter = Offset(
      (topLeft.dx + topRight.dx + bottomRight.dx + bottomLeft.dx) / 4,
      (topLeft.dy + topRight.dy + bottomRight.dy + bottomLeft.dy) / 4,
    );

    canvas.save();
    canvas.translate(
      canvasCenter.dx - polygonCenter.dx,
      canvasCenter.dy - polygonCenter.dy,
    );

    for (int i = 0;
        i <
            random.nextInt(maxRepetition > minRepetition
                    ? maxRepetition - minRepetition
                    : maxRepetition + minRepetition) +
                minRepetition;
        i++) {
      topLeft += Offset(
        maxCornersOffset * 2 * (random.nextDouble() - 0.5),
        maxCornersOffset * 2 * (random.nextDouble() - 0.5),
      );
      topRight += Offset(
        maxCornersOffset * 2 * (random.nextDouble() - 0.5),
        maxCornersOffset * 2 * (random.nextDouble() - 0.5),
      );
      bottomRight += Offset(
        maxCornersOffset * 2 * (random.nextDouble() - 0.5),
        maxCornersOffset * 2 * (random.nextDouble() - 0.5),
      );
      bottomLeft += Offset(
        maxCornersOffset * 2 * (random.nextDouble() - 0.5),
        maxCornersOffset * 2 * (random.nextDouble() - 0.5),
      );
      canvas.drawPoints(
        PointMode.polygon,
        [
          topLeft,
          topRight,
          bottomRight,
          bottomLeft,
          topLeft,
        ],
        paint,
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
