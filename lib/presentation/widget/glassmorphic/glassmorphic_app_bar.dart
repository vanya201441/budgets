import 'package:byte_budget/presentation/widget/widgets.dart';
import 'package:flutter/material.dart';

@Deprecated('Not ready for use')
class GlassmorphicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassmorphicAppBar({
    required this.title,
    super.key,
  }) : preferredSize = const Size.fromHeight(toolbarHeight);

  static const toolbarHeight = kToolbarHeight + 16;

  final String title;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return Glassmorphic(
      blur: 7,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
