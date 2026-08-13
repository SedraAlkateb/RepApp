import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/search_doctors.dart';
import 'package:domina_app/presentation/senior/search_doctors/page/search_hospital.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainSearchPage extends StatelessWidget {
  const MainSearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    // =====================================================
    // TabBar-specific height
    //
    // قيمة خاصة بهذا العنصر فقط،
    // أما باقي المقاسات فمن AppUi.
    // =====================================================
    final double tabBarHeight = ui.isMobile
        ? 52
        : ui.isTabletPortrait
        ? 58
        : 54;

    return DefaultTabController(
      length: 2,

      child: Scaffold(
        backgroundColor: const Color(
          0xFFF8FAFC,
        ),

        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),

          headerSliverBuilder: (
              context,
              innerBoxIsScrolled,
              ) {
            return [
              // =================================================
              // AppBar
              // =================================================
              SliverAppBar(
                elevation: 0,
                scrolledUnderElevation: 0,

                pinned: true,
                floating: true,
                snap: true,

                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,

                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ColorManager.medicalPrimary,
                    size: ui.iconSize,
                  ),

                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                ),

                title: Text(
                  "البحث عن طبيب أو مشفى",

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    color: ColorManager.medicalPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: ui.cardTitleSize,
                  ),
                ),
              ),

              // =================================================
              // TabBar
              // =================================================
              SliverToBoxAdapter(
                child: ColoredBox(
                  color: const Color(
                    0xFFF8FAFC,
                  ),

                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: ui.pageMaxWidth,
                      ),

                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          ui.pagePadding,
                          ui.searchTopPadding,
                          ui.pagePadding,
                          ui.searchBottomPadding,
                        ),

                        child: Container(
                          height: tabBarHeight,

                          padding: const EdgeInsets.all(
                            4,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(
                              ui.cardRadius,
                            ),

                            border: Border.all(
                              color: const Color(
                                0xFFE2E8F0,
                              ),
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.025,
                                ),
                                blurRadius: 12,
                                offset: const Offset(
                                  0,
                                  4,
                                ),
                              ),
                            ],
                          ),

                          child: TabBar(
                            padding: EdgeInsets.zero,

                            dividerColor: Colors.transparent,

                            indicatorSize: TabBarIndicatorSize.tab,

                            labelColor: Colors.white,

                            unselectedLabelColor: const Color(
                              0xFF94A3B8,
                            ),

                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: ui.bodyTextSize,
                            ),

                            unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: ui.bodyTextSize,
                            ),

                            indicator: BoxDecoration(
                              color: ColorManager.medicalPrimary,

                              borderRadius: BorderRadius.circular(
                                ui.cardRadius - 5,
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: ColorManager.medicalPrimary.withOpacity(
                                    0.12,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(
                                    0,
                                    3,
                                  ),
                                ),
                              ],
                            ),

                            // =========================================
                            // نفس السلوك الأصلي تماماً
                            // =========================================
                            onTap: (value) {
                              BlocProvider.of<SearchDoctorsBloc>(
                                context,
                              ).value = value;
                            },

                            tabs: [
                              // =====================================
                              // Doctors
                              // =====================================
                              Tab(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,

                                  children: [
                                    Icon(
                                      Icons.groups_outlined,
                                      size: ui.smallIconSize + 2,
                                    ),

                                    SizedBox(
                                      width: ui.smallSpacing,
                                    ),

                                    const Flexible(
                                      child: Text(
                                        'الأطباء',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // =====================================
                              // Hospitals
                              // =====================================
                              Tab(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,

                                  children: [
                                    Icon(
                                      Icons.local_hospital_outlined,
                                      size: ui.smallIconSize + 2,
                                    ),

                                    SizedBox(
                                      width: ui.smallSpacing,
                                    ),

                                    const Flexible(
                                      child: Text(
                                        'المشافي',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },

          // =====================================================
          // Pages
          // =====================================================
          body: const TabBarView(
            // نفس السلوك الأصلي:
            // التغيير فقط من TabBar وليس بالسحب
            physics: NeverScrollableScrollPhysics(),

            children: [
              SearchDoctors(),
              SearchHospital(),
            ],
          ),
        ),
      ),
    );
  }
}