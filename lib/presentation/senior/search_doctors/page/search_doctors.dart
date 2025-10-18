import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/doctor_details.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchDoctors extends StatelessWidget {
  SearchDoctors({
    super.key,
  });

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String name = context.watch<SearchDoctorsBloc>().name;
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return Center(
              child: IconButton(
                icon: Icon(
                  size: AppSize.s30,
                  Icons.menu,
                  color: ColorManager.secondaryColor,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            );
          },
        ),
        title: Text(
          'البحث عن طبيب',
          style: TextStyle(),
        ),
      ),
      floatingActionButton: AnimatedButton(
        isSelected: searchController.text.isEmpty,
        animatedOn: AnimatedOn.onTap,
        borderRadius: AppSize.s60,
        backgroundColor: ColorManager.secondaryColor1,
        isReverse: true,
        animationDuration: Duration(seconds: 3),
        onPress: () {
          BlocProvider.of<SearchDoctorsBloc>(context)
              .add(FutureSearchDocEvent(searchController.text));
        },
        width: 100,
        text: 'ابحث',
        selectedTextColor: ColorManager.secondaryColor1,
        transitionType: TransitionType.RIGHT_BOTTOM_ROUNDER,
        textStyle: TextStyle(
            fontSize: 20.sp,
            color: ColorManager.white,
            fontWeight: FontWeight.w300),
      )
      // FloatingActionButton(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(50),
      //   ),
      //   onPressed: () {
      //     BlocProvider.of<SearchDoctorsBloc>(context)
      //         .add(FutureSearchDocEvent(state.name));
      //   },
      //   backgroundColor: ColorManager.secondaryColor1,
      //   child: Icon(
      //     Icons.search_sharp,
      //     color: ColorManager.white,
      //   ),
      // )
      ,
      body: Stack(
        children: [
          Image.asset(
            ImageAssets.doctor2,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: ColorManager.secondaryColor4.withOpacity(0.07),
            colorBlendMode: BlendMode.modulate,
          ),
          SingleChildScrollView(
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
                  //,
                ),
                BlocBuilder<SearchDoctorsBloc, SearchDoctorsState>(
                  buildWhen: (previous, current) =>
                      current is FutureFutureSearchDoctorsErrorState ||
                      current is FutureSearchDoctorsLoadingState ||
                      current is FutureSearchDoctorsState ||
                      current is FutureSearchDoctorsEmptyState,
                  builder: (context, state) {
                    if (state is FutureFutureSearchDoctorsErrorState) {
                      return   errorFullScreen(
                          context,mes:  state.failure.massage,func:()  =>
                      BlocProvider.of<SearchDoctorsBloc>(context).add(FutureSearchDocEvent(searchController.text))
                      );
                    }
                    if (state is FutureSearchDoctorsLoadingState) {
                      return loadingFullScreen(context);
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
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return DoctorDetails(
                                          doctorModel:
                                              state.Representative[index],
                                        );
                                      },
                                    ));
                                    BlocProvider.of<SearchDoctorsBloc>(context)
                                        .add(FutureDocDoctorsEvent(
                                            state.Representative[index].id));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(AppPaddingH.p8),
                                    padding: EdgeInsets.all(AppPaddingH.p16),
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      border: Border.all(
                                          color: ColorManager.hintGrey),
                                      borderRadius:  BorderRadius.all(
                                          Radius.circular(AppSize.s8)),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          state.Representative[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        TextRach(
                                            s1: "العنوان: ",
                                            s2: state.Representative[index]
                                                .placeTitle),
                                        TextRach(
                                            s1: "الاختصاص: ",
                                            s2: state
                                                .Representative[index].spTitle
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: state.Representative.length,
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
        ],
      ),
    );
  }
}
