import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/specialization/pages/spec_d_h.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/basic/spec_grid_widget.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecializationsPage extends StatelessWidget {
  SpecializationsPage({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(

        title: Text(
          'الإختصاصات',
          style: TextStyle(fontSize: isTablet ? 28.sp : 20.sp),
        ),
      ),
      body: OrientationBuilder(

        builder: (context, orientation) {
          // 🔹 إذا كانت الشاشة أفقية (landscape) على التابلت → 4 أعمدة
          // 🔹 إذا كانت عمودية (portrait) → 2 أو 3 حسب نوع الجهاز
          int crossAxisCount;
          if (isTablet) {
            crossAxisCount = orientation == Orientation.landscape ? 4 : 3;
          } else {
            crossAxisCount = orientation == Orientation.landscape ? 3 : 2;
          }

          return SingleChildScrollView(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: isTablet ? 30.w : 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h,),
                  SearchField(
                    searchController: searchController,
                    onPressed: (value) {
                      BlocProvider.of<SpecializationBloc>(context)
                          .add(SearchSpecEvent(value));
                    },
                  ),
                  BlocConsumer<SpecializationBloc, SpecializationState>(
                    listener: (context, state) {
                      if (state is AllSpecErrorState) {
                        error(context, state.failure.massage,
                            state.failure.code);
                      }
                    },
                    builder: (context, state) {
                      List<SpecDModel> placeModel =
                          context.watch<SpecializationBloc>().specialization;
                      if (state is AllSpecState) {
                        placeModel = state.Specs;
                      }

                      return Padding(
                        padding:  EdgeInsets.symmetric(vertical: 12,horizontal: 8),
                        child: SpecGridWidget(items: placeModel, crossAxisCount: crossAxisCount,      onTap: (model) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SpecDH(spId: model.id),
                            ),
                          );
                          BlocProvider.of<SpecializationBloc>(context)
                              .add(
                              DoctorSpEvent(model.id));
                        },),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
