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

import 'package:flutter/material.dart';

class SquaresGridWidget extends StatelessWidget {
  const SquaresGridWidget({
    super.key,
    this.sideLength = 80,
    this.strokeWidth = 3,
    this.gap = 30,
  });

  final double sideLength;
  final double strokeWidth;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.black,
        child: SizedBox.expand(
          child: CustomPaint(
            painter: SquaresCustomPainter(
              sideLength: sideLength,
              strokeWidth: strokeWidth,
              gap: gap,
            ),
          ),
        ),
      ),
    );
  }
}

class SquaresCustomPainter extends CustomPainter {
  SquaresCustomPainter({
    this.sideLength = 80,
    this.strokeWidth = 3,
    this.gap = 30,
  });

  final double sideLength;
  final double strokeWidth;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple
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
    for (int index = 0; index < totalCount; index++) {
      int i = index ~/ yCount;
      int j = index % yCount;

      canvas.drawRect(
        Rect.fromLTWH(
          (i * (sideLength + gap)),
          (j * (sideLength + gap)),
          sideLength,
          sideLength,
        ),
        paint,
      );
    }

    /// Reset the canvas
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
