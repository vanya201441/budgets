import 'package:flutter/material.dart';

class SwipeCardWidget extends StatefulWidget {
  final Widget content;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const SwipeCardWidget({
    super.key,
    required this.content,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<SwipeCardWidget> createState() => _SwipeCardWidgetState();
}

class _SwipeCardWidgetState extends State<SwipeCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  double _offset = 0.0;
  static const double freezeThreshold = 0.4;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween(begin: 0, end: 0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details, double width) {
    setState(() {
      _offset += details.delta.dx;
      if (_offset > 0) _offset = 0;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details, double width) {
    final freezePoint = -width * freezeThreshold;
    if (_offset <= freezePoint) {
      _offset = freezePoint;
    } else {
      _animation = Tween<double>(begin: _offset, end: 0).animate(_controller)
        ..addListener(() {
          setState(() {});
        });
      _controller.forward(from: 0);
    }
    setState(() {});
  }

  void _resetOffset() {
    setState(() {
      _offset = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final freezePoint = -screenWidth * freezeThreshold;
    return Stack(
      children: [
        if (_offset <= freezePoint)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: widget.onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    widget.onDelete();
                    _resetOffset();
                  },
                ),
              ],
            ),
          ),
        GestureDetector(
          onHorizontalDragUpdate: (details) =>
              _onHorizontalDragUpdate(details, screenWidth),
          onHorizontalDragEnd: (details) =>
              _onHorizontalDragEnd(details, screenWidth),
          child: Transform.translate(
            offset: Offset(_offset, 0),
            child: widget.content,
          ),
        ),
      ],
    );
  }
}
