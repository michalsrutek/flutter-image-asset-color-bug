import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Image Demo')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: DraggableWidget(
              frontBroken: ImageWidget(useColor: true),
              backBroken: ImageWidget(useColor: true),
              frontWorking: ImageWidget(useColor: false),
              backWorking: ImageWidget(useColor: false),
            ),
          ),
        ),
      ),
    );
  }
}

final class ImageWidget extends StatelessWidget {
  final bool useColor;

  const ImageWidget({super.key, required this.useColor});

  @override
  Widget build(BuildContext context) {
    const double outerCircleWidth = 210;
    const double innerCircleWidth = 170;

    return SizedBox(
      width: outerCircleWidth,
      child: Container(
        width: innerCircleWidth,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
        child: SizedBox(
          width: outerCircleWidth,
          height: outerCircleWidth,
          child: Center(
            child: Image.asset(
              'assets/img.png',
              width: innerCircleWidth,
              height: innerCircleWidth,
              // !!! Using a color does something weird
              color: useColor ? Colors.orange : null,
            ),
          ),
        ),
      ),
    );
  }
}

final class DraggableWidget extends StatefulWidget {
  final Widget frontBroken;
  final Widget backBroken;

  final Widget frontWorking;
  final Widget backWorking;

  const DraggableWidget({
    super.key,
    required this.frontBroken,
    required this.backBroken,
    required this.frontWorking,
    required this.backWorking,
  });

  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  double _horizontalDragInDegrees = 0;
  double get _horizontalDragInRadians =>
      (_horizontalDragInDegrees * math.pi) / 180;

  bool get _showingFront =>
      (_horizontalDragInDegrees <= 90 || _horizontalDragInDegrees >= 270);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _horizontalDragInDegrees += details.delta.dx * 1.618;
        });
      },
      child: Column(
        children: [
          Text('Drag degrees: ${-_horizontalDragInDegrees.toInt()}'),
          const SizedBox(height: 24),
          const Text("Incorrect ❌"),
          const SizedBox(height: 24),
          _buildFlippableWidget(
            front: widget.frontBroken,
            back: widget.backBroken,
          ),
          const SizedBox(height: 48),
          const Text("Correct ✅"),
          const SizedBox(height: 24),
          _buildFlippableWidget(
            front: widget.frontWorking,
            back: widget.backWorking,
          ),
        ],
      ),
    );
  }

  Widget _buildFlippableWidget({required Widget front, required Widget back}) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(-_horizontalDragInRadians),
      alignment: Alignment.center,
      child: _showingFront ? front : back,
    );
  }
}
