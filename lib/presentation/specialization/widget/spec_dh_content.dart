import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/specialization/pages/doctor_sp.dart';
import 'package:domina_app/presentation/specialization/pages/hospital_sp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecDHContent extends StatelessWidget {
  const SpecDHContent({
    super.key,
    required this.spId,
    required this.pageMaxWidth,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.tabBarHeight,
    required this.tabRadius,
    required this.indicatorRadius,
    required this.titleFontSize,
    required this.tabFontSize,
    required this.tabIconSize,
    required this.tabIconSpacing,
  });

  final int spId;

  final double pageMaxWidth;

  final double horizontalPadding;
  final double verticalPadding;

  final double tabBarHeight;
  final double tabRadius;
  final double indicatorRadius;

  final double titleFontSize;
  final double tabFontSize;
  final double tabIconSize;
  final double tabIconSpacing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: NestedScrollView(
        headerSliverBuilder: (
            context,
            innerBoxIsScrolled,
            ) {
          return [
            // ==========================================
            // AppBar
            // ==========================================
            SliverAppBar(
              elevation: 0,
              pinned: true,
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,

              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF0D47A1),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              title: Text(
                'قائمة الاختصاصات',
                style: TextStyle(
                  color: const Color(0xFF0D47A1),
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
            ),

            // ==========================================
            // Responsive TabBar
            // ==========================================
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: pageMaxWidth,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    child: Container(
                      height: tabBarHeight,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          tabRadius,
                        ),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(
                              0,
                              4,
                            ),
                          ),
                        ],
                      ),
                      child: TabBar(
                        padding: const EdgeInsets.all(4),

                        dividerColor: Colors.transparent,

                        labelColor: Colors.white,

                        unselectedLabelColor:
                        Colors.grey.shade400,

                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: tabFontSize,
                        ),

                        unselectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: tabFontSize,
                        ),

                        indicatorSize:
                        TabBarIndicatorSize.tab,

                        indicator: BoxDecoration(
                          color:
                          ColorManager.medicalPrimary,
                          borderRadius:
                          BorderRadius.circular(
                            indicatorRadius,
                          ),
                        ),

                        // ==================================
                        // نفس السلوك الأصلي تماماً
                        // ==================================
                        onTap: (value) {
                          if (value == 0) {
                            context
                                .read<SpecializationBloc>()
                                .add(
                              DoctorSpEvent(
                                spId,
                              ),
                            );
                          } else {
                            context
                                .read<SpecializationBloc>()
                                .add(
                              HospitalSpEvent(
                                spId,
                              ),
                            );
                          }
                        },

                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.groups_outlined,
                                  size: tabIconSize,
                                ),

                                SizedBox(
                                  width: tabIconSpacing,
                                ),

                                const Text(
                                  'الأطباء',
                                ),
                              ],
                            ),
                          ),

                          Tab(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons
                                      .local_hospital_outlined,
                                  size: tabIconSize,
                                ),

                                SizedBox(
                                  width: tabIconSpacing,
                                ),

                                const Text(
                                  'المشافي',
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
          ];
        },

        // ==============================================
        // نفس TabBarView القديم
        // ==============================================
        body:  TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            DoctorSp(),
            HospitalSp(),
          ],
        ),
      ),
    );
  }
}