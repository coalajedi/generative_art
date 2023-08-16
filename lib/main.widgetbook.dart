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
import 'package:widgetbook/widgetbook.dart';

import 'themes.dart';
import 'tools/tools.dart';

void main() {
  runApp(const WidgetBookApp());
}

class WidgetBookApp extends StatelessWidget {
  const WidgetBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      appBuilder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.darkTheme,
        title: 'Flutter Generative Art',
        home: Material(
          child: child,
        ),
      ),
      directories: [
        WidgetbookFolder(
          name: 'Generative Art Tools',
          children: [
            WidgetbookCategory(
              name: 'Widgets',
              children: [
                WidgetbookComponent(
                  name: 'Squares Grid',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Playground',
                      builder: (context) => SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: SquaresGridWidget(
                          sideLength: context.knobs.double.slider(
                            label: 'Side Length',
                            initialValue: 80,
                            min: 30,
                            max: 200,
                          ),
                          strokeWidth: context.knobs.double.slider(
                            label: 'Stroke Width',
                            initialValue: 1.5,
                            min: 0.5,
                            max: 3.5,
                            divisions: 6,
                          ),
                          gap: context.knobs.double.slider(
                            label: 'Gap',
                            initialValue: 5,
                            min: 0,
                            max: 50,
                            divisions: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'Recursive Squares Grid',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Raw',
                      builder: (context) => SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: RawRecursiveSquaresGrid(
                          sideLength: context.knobs.double.slider(
                            label: 'Side Length',
                            initialValue: 80,
                            min: 30,
                            max: 200,
                          ),
                          strokeWidth: context.knobs.double.slider(
                            label: 'Stroke Width',
                            initialValue: 1.5,
                            min: 0.5,
                            max: 3.5,
                            divisions: 6,
                          ),
                          gap: context.knobs.double.slider(
                            label: 'Gap',
                            initialValue: 5,
                            min: 0,
                            max: 50,
                            divisions: 50,
                          ),
                          minSquareSideFraction: context.knobs.double.slider(
                            label: 'Minimum Square Side Fraction',
                            initialValue: 0.2,
                            min: 0.1,
                            max: 0.7,
                            divisions: 6,
                          ),
                        ),
                      ),
                    ),
                    WidgetbookUseCase(
                      name: 'Randomized',
                      builder: (context) => SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: RandomizedRecursiveSquaresGrid(
                          sideLength: context.knobs.double.slider(
                            label: 'Side Length',
                            initialValue: 80,
                            min: 30,
                            max: 200,
                          ),
                          strokeWidth: context.knobs.double.slider(
                            label: 'Stroke Width',
                            initialValue: 1.5,
                            min: 0.5,
                            max: 3.5,
                            divisions: 6,
                          ),
                          gap: context.knobs.double.slider(
                            label: 'Gap',
                            initialValue: 5,
                            min: 0,
                            max: 50,
                            divisions: 50,
                          ),
                        ),
                      ),
                    ),
                    WidgetbookUseCase(
                      name: 'Playground',
                      builder: (context) => SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: RecursiveSquareGrid(
                          sideLength: context.knobs.double.slider(
                            label: 'Side Length',
                            initialValue: 80,
                            min: 30,
                            max: 200,
                          ),
                          strokeWidth: context.knobs.double.slider(
                            label: 'Stroke Width',
                            initialValue: 1.5,
                            min: 0.5,
                            max: 3.5,
                            divisions: 6,
                          ),
                          gap: context.knobs.double.slider(
                            label: 'Gap',
                            initialValue: 5,
                            min: 0,
                            max: 50,
                            divisions: 50,
                          ),
                          minSquareSideFraction: context.knobs.double.slider(
                            label: 'Minimum Square Side Fraction',
                            initialValue: 0.2,
                            min: 0.1,
                            max: 0.7,
                            divisions: 6,
                          ),
                          saturation: context.knobs.double.slider(
                            label: 'Saturation',
                            min: 0,
                            max: 1.0,
                            divisions: 10,
                            initialValue: 0.7,
                          ),
                          lightness: context.knobs.double.slider(
                            label: 'Lightness',
                            min: 0,
                            max: 1.0,
                            divisions: 10,
                            initialValue: 0.5,
                          ),
                          enableColors: context.knobs.boolean(
                            label: 'Enable Colors',
                            initialValue: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'Distorted Polygon',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Raw',
                      builder: (context) => RawDistortedPolygon(
                        strokeWidth: context.knobs.double.slider(
                          label: 'Stroke Width',
                          initialValue: 5,
                          divisions: 9,
                          min: 0.5,
                          max: 5,
                        ),
                        maxCornersOffset: context.knobs.double.slider(
                          label: 'Maximum Corner Offset',
                          initialValue: 20,
                          divisions: 100,
                          min: 0,
                          max: 100,
                        ),
                        maxSideLength: context.knobs.double.slider(
                          label: 'Maximum Side Length',
                          initialValue: 250,
                          divisions: 220,
                          min: 30,
                          max: 250,
                        ),
                        minRepetition: context.knobs.double
                            .slider(
                              label: 'Minimum Repetition',
                              initialValue: 30,
                              divisions: 99,
                              min: 1,
                              max: 100,
                            )
                            .toInt(),
                        maxRepetition: context.knobs.double
                            .slider(
                              label: 'Maximum Repetition',
                              initialValue: 100,
                              divisions: 99,
                              min: 1,
                              max: 100,
                            )
                            .toInt(),
                      ),
                    ),
                    WidgetbookUseCase(
                      name: 'Playground',
                      builder: (context) => DistortedPolygon(
                        strokeWidth: context.knobs.double.slider(
                          label: 'Stroke Width',
                          initialValue: 5,
                          divisions: 9,
                          min: 0.5,
                          max: 5,
                        ),
                        maxCornersOffset: context.knobs.double.slider(
                          label: 'Maximum Corner Offset',
                          initialValue: 20,
                          divisions: 100,
                          min: 0,
                          max: 100,
                        ),
                        minSquareSideFraction: context.knobs.double.slider(
                          label: 'Minimum Square Side Fraction',
                          initialValue: 0.5,
                          min: 0.1,
                          max: 0.7,
                          divisions: 6,
                        ),
                      ),
                    ),
                  ],
                ),
                WidgetbookComponent(
                  name: 'Distorted Polygon Set',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Playground',
                      builder: (context) => DistortedPolygonSet(
                        minRepetition: context.knobs.double
                            .slider(
                              label: 'Minimum Repetition',
                              initialValue: 20,
                              divisions: 99,
                              min: 1,
                              max: 100,
                            )
                            .toInt(),
                        strokeWidth: context.knobs.double.slider(
                          label: 'Stroke Width',
                          initialValue: 5,
                          divisions: 9,
                          min: 0.5,
                          max: 5,
                        ),
                        maxCornersOffset: context.knobs.double.slider(
                          label: 'Maximum Corner Offset',
                          initialValue: 20,
                          divisions: 100,
                          min: 0,
                          max: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
