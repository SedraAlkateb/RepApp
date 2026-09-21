import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CustomWavyBackground extends StatelessWidget {
  const CustomWavyBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 0.9,
          child: WavyHeader3(),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 0.7,
          child: WavyHeader2(),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Wavybottum2(),
        ),
      ],
    );
  }
}

class WavyHeader2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RPSCustomPainter(),
      size: Size(double.infinity, (double.infinity * 0.5).toDouble()),
    );
  }
}

class WavyHeader3 extends StatelessWidget {
  const WavyHeader3({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RPSCustomPainter2(),
      size: Size(double.infinity, (double.infinity * 0.5).toDouble()),
    );
  }
}


class Wavybottum2 extends StatelessWidget {
  const Wavybottum2({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RPSCustomPainter4(),
      size: Size(double.infinity, double.infinity),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = ColorManager.secondaryColor1
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0024306, size.height * 0.2613144);
    path_0.quadraticBezierTo(size.width * 0.1074306, size.height * 0.3263465,
        size.width * 0.3436806, size.height * 0.3682588);
    path_0.cubicTo(
        size.width * 0.5692361,
        size.height * 0.3964770,
        size.width * 0.5809028,
        size.height * 0.3163279,
        size.width * 0.6236806,
        size.height * 0.2553862);
    path_0.quadraticBezierTo(size.width * 0.7198090, size.height * 0.1113313,
        size.width * 0.9965278, size.height * -0.0021341);
    path_0.lineTo(size.width * 0.0048611, size.height * -0.0035569);

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = ColorManager.secondaryColor1
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = ColorManager.secondaryColor4
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4909722, size.height * 0.1802168);
    path_0.quadraticBezierTo(size.width * 0.6410590, size.height * 0.2948086,
        size.width * 0.7947917, size.height * 0.2975949);
    path_0.quadraticBezierTo(size.width * 0.8898264, size.height * 0.3005589,
        size.width * 1.0038194, size.height * 0.2335705);
    path_0.lineTo(size.width * 1.0004167, size.height * -0.0002371);
    path_0.lineTo(size.width * 0.4666667, size.height * -0.0023713);

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = ColorManager.secondaryColor4
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class RPSCustomPainter4 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = ColorManager.secondaryColor2
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0077778, size.height * 0.0984079);
    path_0.quadraticBezierTo(size.width * 0.1050000, size.height * 0.1286416,
        size.width * 0.1788889, size.height * 0.1045732);
    path_0.quadraticBezierTo(size.width * 0.2635938, size.height * 0.0803862,
        size.width * 0.3077083, size.height * 0.0002371);
    path_0.lineTo(size.width * -0.0072917, 0);

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = ColorManager.secondaryColor2
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
