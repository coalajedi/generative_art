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

import '../utils.dart';

class DistortedPolygonSet extends StatelessWidget {
  const DistortedPolygonSet({
    super.key,
    this.maxCornersOffset = 20,
    this.minRepetition = 20,
    this.strokeWidth = 2,
    this.child,
  });

  final double maxCornersOffset;
  final double strokeWidth;
  final int minRepetition;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ColoredBox(
        color: Colors.black,
        child: CustomPaint(
          painter: _DistortedPolygonSetCustomPainter(
            maxCornersOffset: maxCornersOffset,
            strokeWidth: strokeWidth,
            minRepetition: minRepetition,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _DistortedPolygonSetCustomPainter extends CustomPainter {
  _DistortedPolygonSetCustomPainter({
    this.strokeWidth = 2,
    this.maxCornersOffset = 20,
    this.minRepetition = 20,
  });

  final double strokeWidth;
  final double maxCornersOffset;
  final int minRepetition;

  static final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.deepOrange
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);

    final side = size.shortestSide * 0.7;

    final repetition = random.nextInt(10) + minRepetition;

    for (int i = 0; i < repetition; i++) {
      Offset topLeft = Offset.zero;
      Offset topRight = topLeft + Offset(side, 0);
      Offset bottomRight = topLeft + Offset(side, side);
      Offset bottomLeft = topLeft + Offset(0, side);

      topLeft +=
          randomOffsetFromRange(random: random, maxOffset: maxCornersOffset);
      topRight +=
          randomOffsetFromRange(random: random, maxOffset: maxCornersOffset);
      bottomRight +=
          randomOffsetFromRange(random: random, maxOffset: maxCornersOffset);
      bottomLeft +=
          randomOffsetFromRange(random: random, maxOffset: maxCornersOffset);

      Offset polygonCenter = Offset(
        (topLeft.dx + topRight.dx + bottomRight.dx + bottomLeft.dx) / 4,
        (topLeft.dy + topRight.dy + bottomRight.dy + bottomLeft.dy) / 4,
      );

      canvas.save();
      canvas.translate(
        center.dx - polygonCenter.dx,
        center.dy - polygonCenter.dy,
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
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
