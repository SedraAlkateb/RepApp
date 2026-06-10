import 'package:domina_app/presentation/doctors/widget/doctor_widget.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/doctor_details.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDoctors extends StatefulWidget {
  const SearchDoctors({
    super.key,
  });

  @override
  State<SearchDoctors> createState() => _SearchDoctorsState();
}

class _SearchDoctorsState extends State<SearchDoctors>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // String name = context.watch<SearchDoctorsBloc>().name;
    return Scaffold(
      floatingActionButton: AnimatedButton(
        isSelected: searchController.text.isEmpty,
        animatedOn: AnimatedOn.onTap,
        borderRadius: AppSize.s60,
        backgroundColor: ColorManager.secondaryColor1,
        isReverse: true,
        animationDuration: const Duration(seconds: 3),
        onPress: () {
          BlocProvider.of<SearchDoctorsBloc>(context)
              .add(FutureSearchDocEvent(searchController.text));
        },
        width: 100,
        text: 'ابحث',
        selectedTextColor: ColorManager.secondaryColor1,
        transitionType: TransitionType.RIGHT_BOTTOM_ROUNDER,
        textStyle: TextStyle(
            fontSize: 20,
            color: ColorManager.white,
            fontWeight: FontWeight.w300),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 40,
            // ),
            SearchField(
              searchController: searchController,
              // onPressed: (value) {
              //   BlocProvider.of<SearchDoctorsBloc>(context)
              //       .add(FutureSaveValueSearchEvent(value));
              // }
              //  ,
            ),
            BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
              buildWhen: (previous, current) =>
                  current is FutureSearchDoctorsErrorState ||
                  current is FutureSearchDoctorsLoadingState ||
                  current is FutureSearchDoctorsState ||
                  current is FutureSearchDoctorsEmptyState,
              builder: (context, state) {
                if (state is FutureSearchDoctorsErrorState) {
                  return errorFullScreen(context, func: () {
                    BlocProvider.of<SearchDoctorsBloc>(context)
                        .add(FutureSearchDocEvent(searchController.text));
                  }, mes: state.failure.massage);
                }
                if (state is FutureSearchDoctorsLoadingState) {
                  return loadingShimmer(
                    context,
                    20,
                    100,
                    100,
                    BorderRadius.all(Radius.circular(AppSize.s8)),
                  );
                }
                if (state is FutureSearchDoctorsEmptyState) {
                  return emptyFullScreen(context);
                }
                if (state is FutureSearchDoctorsState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return   doctorWidget(
                              text: "عرض التقارير",
                              spTitle:
                              state.representative[index].spTitle,
                              title: state.representative[index].name,
                              placeTitle: state
                                  .representative[index].placeTitle,
                              id: state.representative[index].id,
                              context: context,
                              function: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DoctorDetails(
                                          doctorModel:
                                          state.representative[index],
                                        );
                                      },
                                    ));
                                BlocProvider.of<SearchDoctorsBloc>(
                                    context)
                                    .add(FutureDocDoctorsEvent(state
                                    .representative[index].id));
                              },
                            );
                          },
                          itemCount: state.representative.length,
                        ),
                      ),
                    ],
                  );
                }
                return emptyFullScreen(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
