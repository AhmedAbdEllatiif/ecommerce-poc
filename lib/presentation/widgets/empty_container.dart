import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxConstraints? constraints;

  const EmptyContainer({
    super.key,
    this.padding,
    this.margin,
    this.constraints,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(10),
      margin: margin ?? EdgeInsets.zero,
      constraints: constraints,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: child,
    );
  }
}
