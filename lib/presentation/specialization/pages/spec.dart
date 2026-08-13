import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/specialization/pages/spec_d_h.dart';
import 'package:domina_app/presentation/uniti/basic/spec_grid_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecializationsPage extends StatelessWidget {
  SpecializationsPage({
    super.key,
  });

  final TextEditingController searchController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

    double pageMaxWidth;

    double horizontalPadding;

    double searchTopPadding;
    double searchBottomPadding;

    double gridHorizontalPadding;
    double gridBottomPadding;

    double appBarTitleFontSize;

    int crossAxisCount;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;

        searchTopPadding = 14;
        searchBottomPadding = 8;

        gridHorizontalPadding = 0;
        gridBottomPadding = 24;

        appBarTitleFontSize = 18;

        crossAxisCount = 2;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 800;

        horizontalPadding = 28;

        searchTopPadding = 20;
        searchBottomPadding = 12;

        gridHorizontalPadding = 4;
        gridBottomPadding = 30;

        appBarTitleFontSize = 20;

        crossAxisCount = 3;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 1100;

        horizontalPadding = 32;

        searchTopPadding = 16;
        searchBottomPadding = 10;

        gridHorizontalPadding = 8;
        gridBottomPadding = 28;

        appBarTitleFontSize = 20;

        crossAxisCount = 4;
        break;
    }

    return Scaffold(
      backgroundColor:
      ColorManager.background,

      appBar: AppBar(
        elevation: 0,

        scrolledUnderElevation: 0,

        surfaceTintColor:
        Colors.transparent,

        title: Text(
          'الإختصاصات',

          style: TextStyle(
            fontSize:
            appBarTitleFontSize,

            fontWeight:
            FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        top: false,

        child: Center(
          child: ConstrainedBox(
            constraints:
            BoxConstraints(
              maxWidth:
              pageMaxWidth,
            ),

            child:
            SingleChildScrollView(
              keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior
                  .onDrag,

              child: Padding(
                padding:
                EdgeInsets.symmetric(
                  horizontal:
                  horizontalPadding,
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,

                  children: [
                    // =================================================
                    // Search
                    // =================================================
                    Padding(
                      padding:
                      EdgeInsets.only(
                        top:
                        searchTopPadding,

                        bottom:
                        searchBottomPadding,
                      ),

                      child:
                      SearchField(
                        searchController:
                        searchController,

                        onPressed:
                            (value) {
                          BlocProvider.of<
                              SpecializationBloc>(
                            context,
                          ).add(
                            SearchSpecEvent(
                              value,
                            ),
                          );
                        },
                      ),
                    ),

                    // =================================================
                    // Specializations
                    // =================================================
                    BlocConsumer<
                        SpecializationBloc,
                        SpecializationState>(
                      listener:
                          (context, state) {
                        if (state
                        is AllSpecErrorState) {
                          error(
                            context,
                            state.failure.massage,
                            state.failure.code,
                          );
                        }
                      },

                      builder:
                          (context, state) {
                        List<SpecDModel>
                        placeModel =
                            context
                                .watch<
                                SpecializationBloc>()
                                .specialization;

                        if (state
                        is AllSpecState) {
                          placeModel =
                              state.Specs;
                        }

                        return Padding(
                          padding:
                          EdgeInsets.fromLTRB(
                            gridHorizontalPadding,
                            4,
                            gridHorizontalPadding,
                            gridBottomPadding,
                          ),

                          child:
                          SpecGridWidget(
                            items:
                            placeModel,

                            crossAxisCount:
                            crossAxisCount,

                            onTap:
                                (model) {
                              // =======================================
                              // نفس ترتيب المنطق الموجود عندك
                              // =======================================
                              initDoctorAndHospitalModule();

                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                      SpecDH(
                                        spId:
                                        model.id,
                                      ),
                                ),
                              );

                              BlocProvider.of<
                                  SpecializationBloc>(
                                context,
                              ).add(
                                DoctorSpEvent(
                                  model.id,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}