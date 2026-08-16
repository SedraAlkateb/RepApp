import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/uniti/basic/doctor.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Doctors extends StatefulWidget {
  const Doctors({
    super.key,
  });

  @override
  State<Doctors> createState() =>
      _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  final TextEditingController searchDocController =
  TextEditingController();

  @override
  void dispose() {
    searchDocController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),

      body: BlocBuilder<
          DoctorsBloc,
          DoctorsState>(
        // =====================================================
        // نفس buildWhen الأصلي تماماً
        // =====================================================
        buildWhen: (previous, current) =>
        current is AllDoctorState ||
            current is AllDoctorEmptyState ||
            current is AllDoctorErrorState ||
            current is AllDoctorLoadingState,

        builder: (context, state) {
          // =====================================================
          // نفس مصدر البيانات الأصلي
          // =====================================================
          List<DoctorModel> doctorModel =
              context
                  .read<DoctorsBloc>()
                  .doctor;

          // =====================================================
          // Loading
          // =====================================================
          if (state
          is AllDoctorLoadingState) {
            return loadingFullScreen(
              context,
            );
          }

          // =====================================================
          // Error
          // =====================================================
          if (state
          is AllDoctorErrorState) {
            return errorFullScreen(
              context,
              mes: state.failure.massage,
              func: () {},
            );
          }

          // =====================================================
          // Empty
          // =====================================================
          if (state
          is AllDoctorEmptyState ||
              doctorModel.isEmpty) {
            return emptyFullScreen(
              context,
            );
          }

          // =====================================================
          // Loaded
          // =====================================================
          if (state
          is AllDoctorState) {
            doctorModel =
                state.doctor;
          }

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ui.pageMaxWidth,
              ),

              child: CustomScrollView(
                physics:
                const BouncingScrollPhysics(),

                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior
                    .onDrag,

                slivers: [
                  // =================================================
                  // Search + Header
                  // =================================================
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                      EdgeInsets.fromLTRB(
                        ui.pagePadding,
                        ui.searchTopPadding,
                        ui.pagePadding,
                        ui.searchBottomPadding,
                      ),

                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [
                          // =========================================
                          // Search
                          // =========================================
                          SearchField(
                            searchController:
                            searchDocController,

                            onPressed: (value) {
                              // =====================================
                              // نفس Event البحث الأصلي
                              // =====================================
                              context
                                  .read<
                                  DoctorsBloc>()
                                  .add(
                                SearchDocEvent(
                                  value,
                                ),
                              );
                            },
                          ),

                          SizedBox(
                            height:
                            ui.sectionSpacing,
                          ),

                          // =========================================
                          // Section Header
                          // =========================================
                          buildTotalReportsCard(
                            doctorModel.length,
                            'قائمة الأطباء المسجلة',
                            'لهذا الشهر',
                          )
                        ],
                      ),
                    ),
                  ),

                  // =================================================
                  // Doctors List
                  // =================================================
                  SliverPadding(
                    padding:
                    EdgeInsets.fromLTRB(
                      ui.pagePadding,
                      ui.listTopPadding,
                      ui.pagePadding,
                      ui.listBottomPadding,
                    ),

                    sliver:
                    SliverList.builder(
                      itemCount:
                      doctorModel.length,

                      itemBuilder:
                          (
                          context,
                          index,
                          ) {
                        return Padding(
                          padding:
                          EdgeInsets.only(
                            bottom:
                            ui.cardSpacing,
                          ),

                          child:
                          DoctorCardItem(
                            doctor:
                            doctorModel[
                            index],
                          ),
                        );
                      },
                    ),
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