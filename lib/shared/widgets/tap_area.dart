// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';

class TapArea extends StatefulWidget {
  const TapArea({
    required this.child,
    required this.onTap,
    super.key,
    this.onLongPress,
    this.padding,
    this.borderRadius = 0,
  });
  final Widget child;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final double borderRadius;
  final EdgeInsets? padding;

  @override
  State<TapArea> createState() => _TapAreaIosState();
}

class _TapAreaIosState extends State<TapArea> {
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: widget.child,
    );

    if (widget.onTap == null && widget.onLongPress == null) return content;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isDown = true;
        });
      },
      onTapCancel: () {
        setState(() {
          _isDown = false;
        });
      },
      onTap: () {
        setState(() {
          _isDown = false;
        });
        widget.onTap!();
      },
      onLongPress: widget.onLongPress,
      child: Focus(
        child: Opacity(
          opacity: _isDown ? 0.7 : 1.0,
          child: content,
        ),
      ),
    );
  }
}
