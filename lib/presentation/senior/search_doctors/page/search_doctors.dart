import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/doctors/widget/doctor_widget.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/doctor_details.dart';
import 'package:domina_app/presentation/senior/search_doctors/widgets/search_do_hos_widget.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDoctors extends StatefulWidget {
  const SearchDoctors({
    super.key,
  });

  @override
  State<SearchDoctors> createState() =>
      _SearchDoctorsState();
}

class _SearchDoctorsState
    extends State<SearchDoctors>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController =
  TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ui = AppUi.of(context);

    return Scaffold(
      // =====================================================
      // نحافظ على نفس سلوك الكيبورد الأصلي
      // =====================================================
      resizeToAvoidBottomInset: false,

      backgroundColor: Colors.transparent,

      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ui.pageMaxWidth,
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,

            children: [
              // =================================================
              // Search Header
              //
              // نفس Widget الموجود عندك
              // بدون تغيير الـLogic الخاص فيه
              // =================================================
              buildHeaderSection(
                searchController,
                context,
              ),

              // =================================================
              // Content
              // =================================================
              Expanded(
                child: BlocBuilder<
                    SearchDoctorsBloc,
                    SearchDoctorsState>(
                  // =================================================
                  // نفس buildWhen الأصلي تماماً
                  // =================================================
                  buildWhen: (
                      previous,
                      current,
                      ) {
                    return current
                    is FutureSearchDoctorsErrorState ||
                        current
                        is FutureSearchDoctorsLoadingState ||
                        current
                        is FutureSearchDoctorsState ||
                        current
                        is FutureSearchDoctorsEmptyState;
                  },

                  builder: (
                      context,
                      state,
                      ) {
                    // =============================================
                    // Error
                    // =============================================
                    if (state
                    is FutureSearchDoctorsErrorState) {
                      return CustomScrollView(
                        physics:
                        const BouncingScrollPhysics(),

                        keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior
                            .onDrag,

                        slivers: [
                          SliverPadding(
                            padding:
                            EdgeInsets.symmetric(
                              horizontal:
                              ui.pagePadding,
                            ),

                            sliver:
                            SliverToBoxAdapter(
                              child:
                              errorFullScreen(
                                context,

                                mes:
                                state
                                    .failure
                                    .massage,

                                func: () {
                                  // =================================
                                  // نفس Retry Event الأصلي
                                  // =================================
                                  BlocProvider.of<
                                      SearchDoctorsBloc>(
                                    context,
                                  ).add(
                                    FutureSearchDocEvent(

                                      searchController
                                          .text,
                                      UserInfo.repId
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    // =============================================
                    // Loading
                    // =============================================
                    if (state
                    is FutureSearchDoctorsLoadingState) {
                      return CustomScrollView(
                        physics:
                        const NeverScrollableScrollPhysics(),

                        slivers: [
                          SliverPadding(
                            padding:
                            EdgeInsets.fromLTRB(
                              ui.pagePadding,
                              ui.listTopPadding,
                              ui.pagePadding,
                              ui.listBottomPadding,
                            ),

                            sliver:
                            SliverToBoxAdapter(
                              child:
                              loadingShimmer(
                                context,

                                // نفس عدد العناصر الأصلي
                                20,

                                // نفس قياسات الـShimmer الأصلية
                                100,
                                100,

                                BorderRadius.circular(
                                  ui.cardRadius,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    // =============================================
                    // Empty
                    // =============================================
                    if (state
                    is FutureSearchDoctorsEmptyState) {
                      return CustomScrollView(
                        physics:
                        const BouncingScrollPhysics(),

                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody:
                            false,

                            child:
                            Padding(
                              padding:
                              EdgeInsets.all(
                                ui.pagePadding,
                              ),

                              child:
                              emptyFullScreen(
                                context,
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    // =============================================
                    // Success
                    // =============================================
                    if (state
                    is FutureSearchDoctorsState) {
                      return CustomScrollView(
                        physics:
                        const BouncingScrollPhysics(),

                        keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior
                            .onDrag,

                        slivers: [
                          // =========================================
                          // Doctors List
                          // =========================================
                          SliverPadding(
                            padding:
                            EdgeInsets.fromLTRB(
                              ui.pagePadding,
                              ui.listTopPadding,
                              ui.pagePadding,
                              ui.listBottomPadding,
                            ),

                            sliver:
                            SliverList(
                              delegate:
                              SliverChildBuilderDelegate(
                                    (
                                    context,
                                    index,
                                    ) {
                                  final doctor =
                                  state
                                      .representative[
                                  index];

                                  // =================================
                                  // نفس Widget الأصلي
                                  // =================================
                                  return doctorWidget(
                                    text:
                                    "عرض التقارير",

                                    spTitle:
                                    doctor.spTitle,

                                    title:
                                    doctor.name,

                                    placeTitle:
                                    doctor
                                        .placeTitle,

                                    id:
                                    doctor.id,

                                    context:
                                    context,

                                    function:
                                        () {
                                      // =================================
                                      // مهم:
                                      // نحافظ على نفس الترتيب الأصلي:
                                      //
                                      // 1. Navigation
                                      // 2. Bloc Event
                                      // =================================

                                      Navigator.push(
                                        context,

                                        MaterialPageRoute(
                                          builder:
                                              (
                                              context,
                                              ) {
                                            return DoctorDetails(
                                              doctorModel:
                                              doctor,
                                            );
                                          },
                                        ),
                                      );

                                      BlocProvider.of<
                                          SearchDoctorsBloc>(
                                        context,
                                      ).add(
                                        FutureDocDoctorsEvent(
                                          doctor.id,
                                        ),
                                      );
                                    },
                                  );
                                },

                                childCount:
                                state
                                    .representative
                                    .length,
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    // =============================================
                    // Default
                    // =============================================
                    return CustomScrollView(
                      physics:
                      const BouncingScrollPhysics(),

                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody:
                          false,

                          child:
                          Padding(
                            padding:
                            EdgeInsets.all(
                              ui.pagePadding,
                            ),

                            child:
                            emptyFullScreen(
                              context,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}