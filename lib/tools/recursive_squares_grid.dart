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

import 'package:flutter/material.dart';

class RecursiveSquareGrid extends StatelessWidget {
  const RecursiveSquareGrid({
    super.key,
    this.sideLength = 80,
    this.strokeWidth = 2,
    this.gap = 5,
    this.minSquareSideFraction = 0.2,
    this.saturation = 0.7,
    this.lightness = 0.5,
    this.enableColors = true,
  });

  final double sideLength;
  final double strokeWidth;
  final double gap;
  final double minSquareSideFraction;
  final double lightness;
  final double saturation;
  final bool enableColors;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _RecursiveSquaresCustomPainter(
            sideLength: sideLength,
            strokeWidth: strokeWidth,
            gap: gap,
            minSquareSideFraction: minSquareSideFraction,
            saturation: saturation,
            lightness: lightness,
            enableColors: enableColors,
          ),
        ),
      ),
    );
  }
}

class _RecursiveSquaresCustomPainter extends CustomPainter {
  _RecursiveSquaresCustomPainter({
    this.sideLength = 80,
    this.strokeWidth = 2,
    this.gap = 5,
    this.minSquareSideFraction = 0.2,
    this.saturation = 0.7,
    this.lightness = 0.5,
    this.enableColors = true,
  }) : minSideLength = sideLength * minSquareSideFraction;

  final double sideLength;
  final double strokeWidth;
  final double gap;
  final double minSquareSideFraction;
  final double lightness;
  final double saturation;
  final bool enableColors;
  final double minSideLength;

  static final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    /// Calculate the number of squares that can fit on the horizontal axis
    final xCount = ((size.width + gap) / (sideLength + gap)).floor();

    /// Calculate the number of squares that can fit on the vertical axis
    final yCount = ((size.height + gap) / (sideLength + gap)).floor();

    /// Calculate the size of the grid of squares
    final contentSize = Size(
      (xCount * sideLength) + ((xCount - 1) * gap),
      (yCount * sideLength) + ((yCount - 1) * gap),
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

    final depth = random.nextInt(5) + 5;

    for (int index = 0; index < totalCount; index++) {
      int i = index ~/ yCount;
      int j = index % yCount;

      /// Recursively draw squares
      drawNestedSquares(
        canvas: canvas,
        start: Offset(
          i * (sideLength + gap),
          j * (sideLength + gap),
        ),
        sideLength: sideLength,
        paint: paint,
        depth: depth,
      );
    }

    /// Reset the canvas
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void drawNestedSquares({
    required Canvas canvas,
    required Offset start,
    required double sideLength,
    required Paint paint,
    required int depth,
  }) {
    /// Recursively draw squares until the side of the square reaches the
    /// minimum defined by the [minSideLength] input.
    /// Or until the [depth] reaches 0
    if (sideLength < minSideLength || depth <= 0) return;

    if (enableColors) {
      paint.color = HSLColor.fromAHSL(
        1,
        random.nextInt(360).toDouble(),
        saturation,
        lightness,
      ).toColor();
    }

    final rect = Rect.fromLTWH(
      start.dx, // left
      start.dy, // top
      sideLength, // width
      sideLength, // height
    );

    canvas.drawRect(
      rect,
      paint,
    );

    final nextSideLength = sideLength * (random.nextDouble() * 0.5 + 0.5);

    final nextStart = Offset(
      start.dx + sideLength / 2 - nextSideLength / 2,
      start.dy + sideLength / 2 - nextSideLength / 2,
    );

    /// Recursive call with the next side length and starting point
    drawNestedSquares(
      canvas: canvas,
      start: nextStart,
      sideLength: nextSideLength,
      paint: paint,
      depth: depth - 1,
    );
  }
}
