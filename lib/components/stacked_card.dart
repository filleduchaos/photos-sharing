import 'dart:math' as math;
import 'package:flutter/material.dart';

class StackedCard extends StatelessWidget {
  const StackedCard({ this.onTap, this.background, this.child });

  final VoidCallback onTap;
  final Widget background;
  final Widget child;

  static const _kMaxCardWidth = 350.0;
  static const _kCardMargin = 36.0;

  @override
  Widget build(BuildContext context) {
    final width = math.min(
      MediaQuery.of(context).size.width - (_kCardMargin * 2),
      _kMaxCardWidth,
    );
    final height = width / 1.4;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: _kCardMargin,
      ),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Positioned.fill(child: background),
              Padding(
                padding: const EdgeInsets.all(16),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
