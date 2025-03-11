import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/future_rep/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuditingPlan extends StatelessWidget {
  AuditingPlan({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تدقيق خطة المندوب"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(
              searchController: searchController,
              //          onPressed: (value) {
              //   BlocProvider.of<VisitPlaceBloc>(context)
              //       .add(SearchDoctorVisitEvent(value: value));
              // },
            ),
            BlocConsumer<FutureRepBloc, FutureRepState>(
              listener: (context, state) {
                // if (state is AllDoctorByPlaceErrorState) {
                //   WidgetsBinding.instance.addPostFrameCallback((_) {
                //     error(context, state.failure.massage, state.failure.code);
                //   });
                // }
              },
              builder: (context, state) {
                List<BrandFlag> doctors =
                    context.watch<FutureRepBloc>().brandFlag;
                // if (state is SearchVisitDoctorState) {
                //   doctors = state.doctorVisit;
                // }
                // if (state is AllDoctorByPlaceState) {
                //   doctors = state.data;
                // }
                // if (state is EmptyState) {
                //   return emptyFullScreen(context);
                // }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(AppPadding.p8),
                        padding: EdgeInsets.all(AppPadding.p16),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          border: Border.all(color: ColorManager.hintGrey),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppSize.s8)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              doctors[index].brand,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            TextRach(
                                s1: "العنوان: ", s2: doctors[index].flag.toString()),
                          ],
                        ),
                      );
                    },
                    itemCount: doctors.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
