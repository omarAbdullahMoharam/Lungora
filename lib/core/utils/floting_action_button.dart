import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlotingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? backgroundColor;

  const FlotingActionButton({
    super.key,
    this.onPressed,
    this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // الزر الرئيسي
        Container(
          margin: const EdgeInsets.only(right: 16, bottom: 20),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xFFDEF3FF),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            onPressed: onPressed ?? () {},
            icon: child ??
                SvgPicture.asset(
                  'assets/icon/message.svg',
                  width: 24,
                  height: 24,
                ),
          ),
        ),

        // اللسان اللي تحت الزر
        Positioned(
          bottom: 16,
          right: 20,
          child: CustomPaint(
            size: const Size(22, 18),
            painter: _TrianglePainter(
              color: backgroundColor ?? const Color(0xFFDEF3FF),
            ),
          ),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
