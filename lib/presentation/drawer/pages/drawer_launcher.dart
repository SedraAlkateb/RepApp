import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/drawer_model.dart';
import 'package:domina_app/presentation/drawer/widget/custom_drawer_widget.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String type = UserInfo.repType;
    // منطق توزيع الأدوار
    if (type == "4") {
      return CustomAppDrawer(
        roleTitle: "Supervisor",
        menuItems: _getSupervisorItems(context),
        showStats: false,
      );
    } else if (type == "5") {
      return CustomAppDrawer(
        roleTitle: "TeamLeader",
        menuItems: _getTeamLeaderItems(context),
        showStats: false,
      );
    } else if (type == "6") {
      return CustomAppDrawer(
        roleTitle: "senior",
        menuItems: _getSeniorItems(context),
        showStats: false,
      );
    } else if (type == "7") {
      return CustomAppDrawer(
        roleTitle: "مندوب",
        menuItems: _getRepresentativeItems(context),
        showStats: true,
      );
    }
    // أضف بقية الأنواع هنا (5، 4...) بنفس الطريقة
    return const SizedBox();
  }

  List<DrawerMenuItem> _getRepresentativeItems(BuildContext context) {
    return [
      DrawerMenuItem(
          icon: Icons.location_city_outlined,
          title: "إجراء زيارة",
          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.places,
                  (route) => false,
                );
              })),
      DrawerMenuItem(
        icon: Icons.history_outlined,
        title: "سجل الزيارات",
        onTap: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(
              context,
              Routes.visits,
            );
            BlocProvider.of<VisitBloc>(context).add(VisitDoctorEvent());
          });
        },
      ),
      DrawerMenuItem(
          icon: Icons.edit_note_sharp,
          title: "إنشاء وصفة",
          onTap: () => Navigator.pushNamed(
                context,
                Routes.recipeDH,
              )),
      DrawerMenuItem(
          icon: Icons.assignment_outlined,
          title: "عرض الوصفات",
          onTap: () {
            // BlocProvider.of<RecipesBrandBloc>(context).add(AllReciEvent());
            Navigator.pushNamed(
              context,
              Routes.allRecip,
            );
          }),
      DrawerMenuItem(
          icon: Icons.inventory_2_outlined,
          title: "إنشاء طلبية",
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.createOrder,
            );
          }),
      DrawerMenuItem(
        icon: Icons.list_alt_outlined,
        title: "الخطط",
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.brandPlan,
          );
        },
      ),
      DrawerMenuItem(
          icon: Icons.grid_view_outlined,
          title: "الإختصاصات",
          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  Routes.spec,
                );
              })),
      DrawerMenuItem(
          icon: Icons.medication_outlined,
          title: "الأصناف الدوائية",
          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  Routes.brand,
                );
              })),
    ];
  }

  List<DrawerMenuItem> _getSeniorItems(BuildContext context) {
    return [
      DrawerMenuItem(
        icon: Icons.list_alt_outlined,
        title: "تقارير المندوبين",
        onTap: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(
              context,
              Routes.AllRepSenior,
            );
          });
        },
      ),
      DrawerMenuItem(
        icon: Icons.person_search_outlined,
        title: "البحث عن طبيب او مشفى",
        onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(
            context,
            Routes.searchdoctors,
          );
        }),
      ),
      DrawerMenuItem(
          icon: Icons.location_city_outlined,
          title: "ارشيف المناطق",
          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  Routes.placesArchive,
                );
              })),
      DrawerMenuItem(
          icon: Icons.edit_note_sharp,
          title: "إنشاء وصفة",
          onTap: () => Navigator.pushNamed(
                context,
                Routes.recipeDH,
              )),
      DrawerMenuItem(
          icon: Icons.assignment_outlined,
          title: "عرض الوصفات",
          onTap: () {
            // BlocProvider.of<RecipesBrandBloc>(context).add(AllReciEvent());
            Navigator.pushNamed(
              context,
              Routes.allRecip,
            );
          }),
      DrawerMenuItem(
          icon: Icons.inventory_2_outlined,
          title: "إنشاء طلبية",
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.createOrder,
            );
          }),
      DrawerMenuItem(
        icon: Icons.list_alt_outlined,
        title: "الخطط",
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.brandPlan,
          );
        },
      ),
      DrawerMenuItem(
          icon: Icons.grid_view_outlined,
          title: "الإختصاصات",
          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  Routes.spec,
                );
              })),
      DrawerMenuItem(
          icon: Icons.medication_outlined,
          title: "الأصناف الدوائية",
          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  Routes.brand,
                );
              })),
    ];
  }

  List<DrawerMenuItem> _getTeamLeaderItems(BuildContext context) {
    return [
      DrawerMenuItem(
        icon: Icons.list_alt_outlined,
        title: "لوحة التحكم",
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.adminControl,
          );
        },
      ),
      // DrawerMenuItem(
      //   icon: Icons.list_alt_outlined,
      //   title: "إدارة تقارير المندوبين",
      //   onTap:   () {
      //     WidgetsBinding.instance.addPostFrameCallback((_) {
      //       Navigator.pushNamed(
      //         context,
      //         Routes.AllRepSenior,
      //
      //       );
      //     });
      //   },
      // ),
      // DrawerMenuItem(
      //     icon:  Icons.assignment_outlined,
      //     title: "إدارة تقارير عامة",
      //     onTap:    () {
      //       // BlocProvider.of<RecipesBrandBloc>(context).add(AllReciEvent());
      //       Navigator.pushNamed(
      //         context,
      //         Routes.generalReports,
      //
      //       );
      //     }
      // ),
      // DrawerMenuItem(
      //   icon:  Icons.list_alt_outlined,
      //   title: "إدارة الخطة الحالية",
      //   onTap:       () {
      //     Navigator.pushNamed(
      //       context,
      //       Routes.allRepWithFuture,
      //     );
      //   },
      // ),
      // DrawerMenuItem(
      //     icon:  Icons.inventory_2_outlined,
      //     title: "ادارة الخطط المنتهية",
      //     onTap:        () {
      //
      //       Navigator.pushNamed(
      //         context,
      //         Routes.createOrder,
      //
      //       );
      //     }
      // ),

      DrawerMenuItem(
          icon: Icons.location_city_outlined,
          title: "ارشيف المناطق",
          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.places,
                  (route) => false,
                );
              })),
      DrawerMenuItem(
        icon: Icons.list_alt_outlined,
        title: "إنشاء خطة",
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.brandPlan,
          );
        },
      ),
      DrawerMenuItem(
          icon: Icons.edit_note_sharp,
          title: "إنشاء وصفة",
          onTap: () => Navigator.pushNamed(
                context,
                Routes.recipeDH,
              )),
      DrawerMenuItem(
          icon: Icons.assignment_outlined,
          title: "عرض الوصفات",
          onTap: () {
            // BlocProvider.of<RecipesBrandBloc>(context).add(AllReciEvent());
            Navigator.pushNamed(
              context,
              Routes.allRecip,
            );
          }),
      DrawerMenuItem(
          icon: Icons.inventory_2_outlined,
          title: "إنشاء طلبية",
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.createOrder,
            );
          }),
      DrawerMenuItem(
        icon: Icons.person_search_outlined,
        title: "البحث عن طبيب او مشفى",
        onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(
            context,
            Routes.searchdoctors,
          );
        }),
      ),
      ///////////
      DrawerMenuItem(
          icon: Icons.grid_view_outlined,
          title: "الإختصاصات",
          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  Routes.spec,
                );
              })),
      DrawerMenuItem(
          icon: Icons.medication_outlined,
          title: "الأصناف الدوائية",
          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  Routes.brand,
                );
              })),
    ];
  }

  List<DrawerMenuItem> _getSupervisorItems(BuildContext context) {
    return [
      DrawerMenuItem(
        icon: Icons.list_alt_outlined,
        title: "لوحة التحكم",
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.adminControl,
          );
        },
      ),
      DrawerMenuItem(
          icon: Icons.location_city_outlined,
          title: "ارشيف المناطق",
          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.places,
                  (route) => false,
                );
              })),
      DrawerMenuItem(
        icon: Icons.person_search_outlined,
        title: "البحث عن طبيب او مشفى",
        onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(
            context,
            Routes.searchdoctors,
          );
        }),
      ),
      DrawerMenuItem(
          icon: Icons.grid_view_outlined,
          title: "الإختصاصات",
          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  Routes.spec,
                );
              })),
      DrawerMenuItem(
          icon: Icons.medication_outlined,
          title: "الأصناف الدوائية",
          onTap: () => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(
                  context,
                  Routes.brand,
                );
              })),
    ];
  }

/*

السوبيرفايزر: (تقارير النمدوبين, بحث عن طبيب ومشفى,ارشيف المناطق ,  ادارة الخطط , مراقبة المندوبين , ادارة الخطط المنتهية,اختصاصات , ادوية ....)
 */
}

List<DrawerMenuItem> getLogoutItem(BuildContext context) {
  return [
    DrawerMenuItem(
        icon: Icons.sync_outlined,
        title: "مزامنة البيانات",
        color: Colors.red,
        onTap: () {
          initAsyncInModule();
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              Navigator.pushNamed(
                context,
                Routes.asyncIn,
              );
            },
          );
        }),
    DrawerMenuItem(
        icon: Icons.logout_outlined,
        title: "تسجيل خروج",
        color: Colors.red,
        onTap: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(context, Routes.logout);
          });
        }),
  ];
}
