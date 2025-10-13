// ignore_for_file: file_names

import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const CustomShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15))
  );

  const CustomShimmerWidget.circular(
      {super.key,
        required this.width,
        required this.height,
        this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.grey[350] as Color,
    highlightColor: ColorManager.grey,
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        
        shape: shapeBorder,
        color: ColorManager.grey,
      ),
    ),
  );
}
