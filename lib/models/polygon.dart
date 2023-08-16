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

import 'location.dart';

class Polygon {
  const Polygon({
    this.topLeft = Offset.zero,
    this.topRight = Offset.zero,
    this.bottomLeft = Offset.zero,
    this.bottomRight = Offset.zero,
    this.topLeftOrigin = Offset.zero,
    this.topRightOrigin = Offset.zero,
    this.bottomLeftOrigin = Offset.zero,
    this.bottomRightOrigin = Offset.zero,
    this.color = Colors.white,
    this.level = 0.0,
    this.location = const Location.zero(),
    this.image,
  });

  final Offset topLeft;
  final Offset topRight;
  final Offset bottomLeft;
  final Offset bottomRight;
  final Offset topLeftOrigin;
  final Offset topRightOrigin;
  final Offset bottomLeftOrigin;
  final Offset bottomRightOrigin;
  final Color color;
  final double level;
  final Location location;
  final Image? image;

  bool get animationEnabled => true;

  /// The entire animation is between 0 and 1, and we need to implement 2
  /// separate animations that have delays.
  /// The first is the delay between the painting of each polygon in a single
  /// polygon set and the second is the delay between entire polygon sets
  /// starting to paint
  static const animationDurationFraction = 0.5;

  double get animationStart => location.x * level;

  double get animationEnd =>
      (animationStart + 0.2) >= 1.0 ? 1.0 : (animationStart + 0.2);

  Offset get center {
    double centerX =
        (topLeft.dx + topRight.dx + bottomRight.dx + bottomLeft.dx) / 4;
    double centerY =
        (topLeft.dy + topRight.dy + bottomRight.dy + bottomLeft.dy) / 4;

    return Offset(centerX, centerY);
  }

  List<Offset> get points => [
        topLeft,
        topRight,
        bottomRight,
        bottomLeft,
        topLeft,
      ];

  List<Offset> get originPoints => [
        topLeftOrigin,
        topRightOrigin,
        bottomRightOrigin,
        bottomLeftOrigin,
        topLeftOrigin,
      ];

  List<Offset> getLinearInterpolatedPoints(double value) => [
        Offset.lerp(topLeft, topLeftOrigin, value)!,
        Offset.lerp(topRight, topRightOrigin, value)!,
        Offset.lerp(bottomRight, bottomRightOrigin, value)!,
        Offset.lerp(bottomLeft, bottomLeftOrigin, value)!,
        Offset.lerp(topLeft, topLeftOrigin, value)!,
      ];
}
