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

class Wavybottum extends StatelessWidget {
  const Wavybottum({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RPSCustomPainter3(),
      size: const Size(double.infinity, double.infinity),
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

class RPSCustomPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color(0xFF3A434D)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0771333, size.height * 0.6668000);
    path_0.quadraticBezierTo(size.width * 0.0833167, size.height * 0.8995667,
        size.width * 0.1280917, size.height * 0.9168000);
    path_0.cubicTo(
        size.width * 0.1665250,
        size.height * 0.9538000,
        size.width * 0.2268167,
        size.height * 0.9382667,
        size.width * 0.2739000,
        size.height * 0.9096667);
    path_0.cubicTo(
        size.width * 0.3469083,
        size.height * 0.8539833,
        size.width * 0.3914833,
        size.height * 0.8100167,
        size.width * 0.4591667,
        size.height * 0.7601167);
    path_0.cubicTo(
        size.width * 0.5069417,
        size.height * 0.7238833,
        size.width * 0.5312167,
        size.height * 0.7049167,
        size.width * 0.5825000,
        size.height * 0.6633333);
    path_0.cubicTo(
        size.width * 0.6223333,
        size.height * 0.6313667,
        size.width * 0.6753500,
        size.height * 0.5955667,
        size.width * 0.7525000,
        size.height * 0.5866667);
    path_0.cubicTo(
        size.width * 0.8005250,
        size.height * 0.5795333,
        size.width * 0.8564500,
        size.height * 0.5777500,
        size.width * 0.9125000,
        size.height * 0.5866667);
    path_0.quadraticBezierTo(size.width * 0.9804250, size.height * 0.5968167,
        size.width * 1.0700000, size.height * 0.6416667);
    path_0.lineTo(size.width * 1.0658333, size.height * 1.1966667);
    path_0.lineTo(size.width * -0.0675000, size.height * 1.2216667);

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color(0xFFF4AC47)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
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
