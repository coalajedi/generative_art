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

class AnimatedDistortedPolygonSet extends StatefulWidget {
  const AnimatedDistortedPolygonSet({
    super.key,
    this.maxCornersOffset = 20,
    this.strokeWidth = 2,
    this.minSquareSideFraction = 0.8,
    this.enableRepetition = true,
    this.enableColors = false,
    this.minRepetition = 20,
    this.child,
  });

  final double maxCornersOffset;
  final double strokeWidth;
  final double minSquareSideFraction;
  final bool enableRepetition;
  final bool enableColors;
  final int minRepetition;
  final Widget? child;

  @override
  State<AnimatedDistortedPolygonSet> createState() =>
      _AnimatedDistortedPolygonSetState();
}

class _AnimatedDistortedPolygonSetState
    extends State<AnimatedDistortedPolygonSet>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  static final Random random = Random();
  late final int repetition;

  @override
  void initState() {
    super.initState();

    repetition =
        widget.enableRepetition ? random.nextInt(10) + widget.minRepetition : 1;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
    );

    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox.expand(
      child: ColoredBox(
        color: Colors.black,
        child: CustomPaint(
          painter: DistortedPolygonSetCustomPainter(
            polygons: generateDistortedPolygonsSet(
              random,
              enableColors: widget.enableColors,
              maxSideLength: size.shortestSide * widget.minSquareSideFraction,
              maxCornersOffset: widget.maxCornersOffset,
              repetition: repetition,
            ),
            strokeWidth: widget.strokeWidth,
            animationController: animationController,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class DistortedPolygonSetCustomPainter extends CustomPainter {
  DistortedPolygonSetCustomPainter({
    required this.polygons,
    this.strokeWidth = 2,
    required AnimationController animationController,
  }) : super(repaint: animationController) {
    polygonsAnimations = generatePolygonAnimations(
      polygons,
      animationController,
    );
  }

  late final List<Animation<double>> polygonsAnimations;
  final List<Polygon> polygons;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < polygons.length; i++) {
      paint.color = polygons[i].color.withOpacity(
            polygons[i].level * polygonsAnimations[i].value,
          );

      canvas.save();
      canvas.translate(
        center.dx - polygons[i].center.dx,
        center.dy - polygons[i].center.dy,
      );

      canvas.drawPoints(
        PointMode.polygon,
        polygons[i]
            .getLinearInterpolatedPoints(1 - polygonsAnimations[i].value),
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
