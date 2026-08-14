import 'package:domina_app/presentation/Recipes/widget/doctor_recipe.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorSp extends StatefulWidget {
  const DoctorSp({
    super.key,
  });

  @override
  State<DoctorSp> createState() => _DoctorSpState();
}

class _DoctorSpState extends State<DoctorSp> {
  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;

    double horizontalPadding;
    double titleHorizontalPadding;

    double cardPadding;
    double cardMarginHorizontal;
    double cardMarginBottom;

    double titleFontSize;
    double countFontSize;

    double infoFontSize;
    double infoIconSize;
    double infoSpacing;

    double cardRadius;

    double emptyHorizontalPadding;
    double emptyVerticalPadding;
    double emptyIconSize;
    double emptyFontSize;

    double sectionSpacing;
    double cardSectionSpacing;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 5;
        titleHorizontalPadding = 20;

        cardPadding = 16;
        cardMarginHorizontal = 8;
        cardMarginBottom = 16;

        titleFontSize = 18;
        countFontSize = 11;

        infoFontSize = 15;
        infoIconSize = 22;
        infoSpacing = 8;

        cardRadius = 15;

        emptyHorizontalPadding = 20;
        emptyVerticalPadding = 90;
        emptyIconSize = 60;
        emptyFontSize = 20;

        sectionSpacing = 12;
        cardSectionSpacing = 10;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        horizontalPadding = 16;
        titleHorizontalPadding = 24;

        cardPadding = 20;
        cardMarginHorizontal = 10;
        cardMarginBottom = 18;

        titleFontSize = 20;
        countFontSize = 13;

        infoFontSize = 16;
        infoIconSize = 24;
        infoSpacing = 10;

        cardRadius = 17;

        emptyHorizontalPadding = 30;
        emptyVerticalPadding = 100;
        emptyIconSize = 70;
        emptyFontSize = 22;

        sectionSpacing = 16;
        cardSectionSpacing = 12;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        horizontalPadding = 24;
        titleHorizontalPadding = 28;

        cardPadding = 22;
        cardMarginHorizontal = 12;
        cardMarginBottom = 20;

        titleFontSize = 21;
        countFontSize = 13;

        infoFontSize = 17;
        infoIconSize = 25;
        infoSpacing = 10;

        cardRadius = 18;

        emptyHorizontalPadding = 40;
        emptyVerticalPadding = 100;
        emptyIconSize = 72;
        emptyFontSize = 22;

        sectionSpacing = 18;
        cardSectionSpacing = 12;
        break;
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: pageMaxWidth,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<SpecializationBloc, SpecializationState>(
                  // ============================================
                  // نفس الـlistener الأصلي تماماً
                  // ============================================
                  listener: (context, state) {
                    if (state is AllSpecDoctorErrorState) {
                      WidgetsBinding.instance.addPostFrameCallback(
                            (_) {
                          error(
                            context,
                            state.failure.massage,
                            state.failure.code,
                          );
                        },
                      );
                    }
                  },

                  builder: (context, state) {
                    // ============================================
                    // نفس الشرط الأصلي
                    // ============================================
                    if (state is AllDoctorSpState) {
                      return Column(
                        children: [
                          SizedBox(
                            height: sectionSpacing,
                          ),

                          // =====================================
                          // Header
                          // =====================================
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: titleHorizontalPadding,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "قائمة الاطباء المسجين",
                                    style: TextStyle(
                                      color: ColorManager.medicalText
                                          .withOpacity(0.8),
                                      fontWeight: FontWeight.bold,
                                      fontSize: titleFontSize,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  width: 12,
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: deviceType ==
                                        AppDeviceType.mobilePortrait
                                        ? 12
                                        : 16,
                                    vertical: deviceType ==
                                        AppDeviceType.mobilePortrait
                                        ? 4
                                        : 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorManager.medicalPrimary
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(
                                      deviceType ==
                                          AppDeviceType.mobilePortrait
                                          ? 8
                                          : 10,
                                    ),
                                  ),
                                  child: Text(
                                    " ${state.doctors.length} طبيب",
                                    style: TextStyle(
                                      color:
                                      ColorManager.medicalPrimary,
                                      fontSize: countFontSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: sectionSpacing,
                          ),

                          // =====================================
                          // Empty State
                          // نفس الشرط الأصلي
                          // =====================================
                          state.doctors.length == 0
                              ? Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              horizontal:
                              emptyHorizontalPadding,
                              vertical:
                              emptyVerticalPadding,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal:
                              titleHorizontalPadding,
                            ),
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius:
                              BorderRadius.circular(
                                cardRadius,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  color:
                                  ColorManager.medicalMuted,
                                  size: emptyIconSize,
                                  weight: 100,
                                ),

                                SizedBox(
                                  height: sectionSpacing,
                                ),

                                Text(
                                  "لا يوجد أطباء مسجلين في هذا الاختصاص",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                    color: ColorManager
                                        .medicalPrimary,
                                    fontSize:
                                    emptyFontSize,
                                  ),
                                ),
                              ],
                            ),
                          )

                          // =================================
                          // Doctors List
                          // =================================
                              : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                              horizontalPadding,
                            ),
                            child: ListView.builder(
                              physics:
                              const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,

                              itemCount:
                              state.doctors.length,

                              itemBuilder:
                                  (context, index) {
                                return Container(
                                  margin:
                                  EdgeInsets.only(
                                    bottom:
                                    cardMarginBottom,
                                    right:
                                    cardMarginHorizontal,
                                    left:
                                    cardMarginHorizontal,
                                  ),
                                  padding:
                                  EdgeInsets.all(
                                    cardPadding,
                                  ),
                                  decoration:
                                  BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(
                                      cardRadius,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(
                                          0.08,
                                        ),
                                        blurRadius: 15,
                                        spreadRadius: 0,
                                        offset:
                                        const Offset(
                                          0,
                                          6,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      // =========================
                                      // Doctor name
                                      // =========================
                                      Text(
                                        state
                                            .doctors[index]
                                            .title,
                                        textAlign:
                                        TextAlign.end,
                                        style:
                                        TextStyle(
                                          fontSize:
                                          titleFontSize,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          color: ColorManager
                                              .medicalPrimary,
                                        ),
                                      ),

                                      SizedBox(
                                        height:
                                        cardSectionSpacing,
                                      ),

                                      // =========================
                                      // Address
                                      // =========================
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,
                                        children: [
                                          Icon(
                                            Icons
                                                .location_on_outlined,
                                            size:
                                            infoIconSize,
                                            color:
                                            Colors.grey,
                                          ),

                                          SizedBox(
                                            width:
                                            infoSpacing,
                                          ),

                                          Expanded(
                                            child: Text(
                                              state
                                                  .doctors[
                                              index]
                                                  .address,
                                              style:
                                              TextStyle(
                                                color:
                                                Colors.grey,
                                                fontSize:
                                                infoFontSize,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height:
                                        cardSectionSpacing,
                                      ),

                                      // =========================
                                      // Visits
                                      // =========================
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,
                                        children: [
                                          Icon(
                                            Icons.numbers,
                                            size:
                                            infoIconSize,
                                            color:
                                            Colors.grey,
                                          ),

                                          SizedBox(
                                            width:
                                            infoSpacing,
                                          ),

                                          Expanded(
                                            child: Text(
                                              "عدد الزيارات : ${state.doctors[index].visits}",
                                              style:
                                              TextStyle(
                                                color:
                                                Colors.grey,
                                                fontSize:
                                                infoFontSize,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height:
                                        sectionSpacing,
                                      ),

                                      const Divider(
                                        color:
                                        Colors.grey,
                                        thickness: 0.1,
                                      ),

                                      SizedBox(
                                        height:
                                        infoSpacing,
                                      ),

                                      // =========================
                                      // Actions
                                      // نفس السلوك
                                      // =========================
                                      Row(
                                        children: [
                                          PrescriptionMenuWidget(
                                            doctorId: state
                                                .doctors[
                                            index]
                                                .id,
                                          ),

                                          const Spacer(),

                                          /*
                                                InkWell(
                                                  onTap: () =>
                                                      Navigator.pushNamed(
                                                    context,
                                                    Routes.doctorDetails,
                                                    arguments:
                                                        state.doctors[index],
                                                  ),
                                                  child:
                                                      buildCardButton(
                                                    "عرض التفاصيل",
                                                    ColorManager.medicalPrimary,
                                                    Colors.white,
                                                    Icons.directions_run,
                                                  ),
                                                ),
                                                */
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    // نفس السلوك السابق
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}