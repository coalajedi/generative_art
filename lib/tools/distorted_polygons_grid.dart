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

class DistortedPolygonGrid extends StatelessWidget {
  const DistortedPolygonGrid({
    super.key,
    this.maxSideLength = 80,
    this.strokeWidth = 1,
    this.gap = 30,
    this.maxCornersOffset = 20,
    this.saturation = 0.7,
    this.lightness = 0.5,
    this.enableRepetition = true,
    this.enableColors = false,
    this.minRepetition = 10,
  });

  final double maxSideLength;
  final double strokeWidth;
  final double gap;
  final double maxCornersOffset;
  final double saturation;
  final double lightness;
  final bool enableRepetition;
  final bool enableColors;
  final int minRepetition;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _DistortedPolygonGrid(
            maxSideLength: maxSideLength,
            strokeWidth: strokeWidth,
            gap: gap,
            maxCornersOffset: maxCornersOffset,
            saturation: saturation,
            lightness: lightness,
            enableRepetition: enableRepetition,
            enableColors: enableColors,
            minRepetition: minRepetition,
          ),
        ),
      ),
    );
  }
}

class _DistortedPolygonGrid extends CustomPainter {
  const _DistortedPolygonGrid({
    this.maxSideLength = 80,
    this.strokeWidth = 2,
    this.gap = 10,
    this.maxCornersOffset = 20,
    this.saturation = 0.7,
    this.lightness = 0.5,
    this.enableRepetition = true,
    this.enableColors = false,
    this.minRepetition = 10,
  });

  final double maxSideLength;
  final double strokeWidth;
  final double gap;
  final double maxCornersOffset;
  final double saturation;
  final double lightness;
  final bool enableRepetition;
  final bool enableColors;
  final int minRepetition;

  static final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    /// Calculate the number of squares that can fit on the horizontal axis
    final xCount = ((size.width + gap) / (maxSideLength + gap)).floor();

    /// Calculate the number of squares that can fit on the vertical axis
    final yCount = ((size.height + gap) / (maxSideLength + gap)).floor();

    /// Calculate the size of the grid of squares
    final contentSize = Size(
      (xCount * maxSideLength) + ((xCount - 1) * gap),
      (yCount * maxSideLength) + ((yCount - 1) * gap),
    );

    /// Calculate the offset from which we should start painting the grid so
    /// that it is eventually centered
    final offset = Offset(
      (size.width - contentSize.width) / 2,
      (size.height - contentSize.height) / 2,
    );

    final totalCount = xCount * yCount;

    /// Save the current status of the canvas
    canvas.save();

    /// Translate the canvas to it's center offset
    canvas.translate(
      offset.dx,
      offset.dy,
    );

    for (int index = 0; index < totalCount; index++) {
      int i = index ~/ yCount;
      int j = index % yCount;

      Offset topLeft = Offset(
        i * (maxSideLength + gap),
        j * (maxSideLength + gap),
      );
      Offset topRight = topLeft + Offset(maxSideLength, 0);
      Offset bottomRight = topLeft + Offset(maxSideLength, maxSideLength);
      Offset bottomLeft = topLeft + Offset(0, maxSideLength);

      final repetition =
          enableRepetition ? random.nextInt(10) + minRepetition : 1;

      for (int count = 0; count < repetition; count++) {
        if (enableColors) {
          paint.color = HSLColor.fromAHSL(
            1,
            random.nextInt(360).toDouble(),
            saturation,
            lightness,
          ).toColor();
        }

        topLeft += randomOffsetFromRange(
          random: random,
          maxOffset: maxCornersOffset,
        );
        topRight += randomOffsetFromRange(
          random: random,
          maxOffset: maxCornersOffset,
        );
        bottomRight += randomOffsetFromRange(
          random: random,
          maxOffset: maxCornersOffset,
        );
        bottomLeft += randomOffsetFromRange(
          random: random,
          maxOffset: maxCornersOffset,
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
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
