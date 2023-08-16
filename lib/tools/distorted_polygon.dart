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

import '../models/polygon.dart';
import '../utils.dart';

class DistortedPolygon extends StatelessWidget {
  const DistortedPolygon({
    super.key,
    this.maxCornersOffset = 20,
    this.strokeWidth = 2,
    this.minSquareSideFraction = 0.5,
    this.child,
    this.color = Colors.lightBlue,
  });

  final double maxCornersOffset;
  final double strokeWidth;
  final double minSquareSideFraction;
  final Widget? child;
  final Color color;

  static final Random random = Random();

  Polygon _createPolygon(BuildContext context, double maxSideLength) {
    Offset topLeft = Offset.zero;
    Offset topRight = topLeft + Offset(maxSideLength, 0);
    Offset bottomRight = topLeft + Offset(maxSideLength, maxSideLength);
    Offset bottomLeft = topLeft + Offset(0, maxSideLength);

    topLeft +=
        randomOffsetFromRange(random: random, maxOffset: maxCornersOffset);
    topRight +=
        randomOffsetFromRange(random: random, maxOffset: maxCornersOffset);
    bottomRight +=
        randomOffsetFromRange(random: random, maxOffset: maxCornersOffset);
    bottomLeft +=
        randomOffsetFromRange(random: random, maxOffset: maxCornersOffset);

    return Polygon(
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ColoredBox(
      color: Colors.black,
      child: SizedBox.expand(
        child: CustomPaint(
          painter: DistortedPolygonCustomPainter(
            polygon: _createPolygon(
              context,
              size.shortestSide * minSquareSideFraction,
            ),
            strokeWidth: strokeWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}

class DistortedPolygonCustomPainter extends CustomPainter {
  const DistortedPolygonCustomPainter({
    required this.polygon,
    this.strokeWidth = 2,
  });

  final Polygon polygon;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = polygon.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);

    canvas.save();
    canvas.translate(
      center.dx - polygon.center.dx,
      center.dy - polygon.center.dy,
    );

    canvas.drawPoints(
      PointMode.polygon,
      polygon.points,
      paint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
