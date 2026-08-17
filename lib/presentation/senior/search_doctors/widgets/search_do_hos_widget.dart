import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildHeaderSection(
    TextEditingController searchController,
    BuildContext context,
    ) {
  final ui = AppUi.of(context);

  // =====================================================
  // Search Button Size
  //
  // قيمة خاصة بهذا العنصر فقط.
  // باقي المقاسات من AppUi.
  // =====================================================

  final double buttonSize = ui.isMobile
      ? 48
      : ui.isTabletPortrait
      ? 54
      : 50;

  return Container(
    width: double.infinity,

    padding: EdgeInsets.fromLTRB(
      ui.pagePadding,
      ui.searchTopPadding,
      ui.pagePadding,
      ui.searchBottomPadding,
    ),


    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // =================================================
        // Search Field
        // =================================================
        Expanded(
          child: SearchField(
            searchController: searchController,

            // نفس السلوك الأصلي
            isIcon: false,
          ),
        ),

        SizedBox(
          width: ui.mediumSpacing,
        ),

        // =================================================
        // Search Button
        // =================================================
        Material(
          color: Colors.transparent,

          child: InkWell(
            borderRadius: BorderRadius.circular(
              ui.smallRadius + 3,
            ),

            onTap: () {
              // =============================================
              // نفس الشرط الأصلي تماماً
              // =============================================
              if (searchController.text.isNotEmpty) {
                if (BlocProvider.of<SearchDoctorsBloc>(
                  context,
                ).value ==
                    0) {
                  // =========================================
                  // Doctors Search
                  // =========================================
                  BlocProvider.of<SearchDoctorsBloc>(
                    context,
                  ).add(
                    FutureSearchDocEvent(

                      searchController
                          .text,
                      UserInfo.repId
                    ),
                  );
                } else {
                  // =========================================
                  // Hospitals Search
                  // =========================================
                  BlocProvider.of<SearchDoctorsBloc>(
                    context,
                  ).add(
                    FutureSearchHosEvent(
                        UserInfo.cityId  ,
                        searchController
                            .text,
                        UserInfo.repId
                    ),
                  );
                }
              }
            },

            child: Container(
              width: buttonSize,
              height: buttonSize,

              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: ColorManager.medicalPrimary,

                borderRadius: BorderRadius.circular(
                  ui.smallRadius + 3,
                ),

                boxShadow: [
                  BoxShadow(
                    color: ColorManager.medicalPrimary.withOpacity(
                      0.16,
                    ),
                    blurRadius: 8,
                    offset: const Offset(
                      0,
                      3,
                    ),
                  ),
                ],
              ),

              child: Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: ui.iconSize,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}