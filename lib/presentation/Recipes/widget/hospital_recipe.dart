// ✅ تصحيح حالة الأحرف للمجلد Recipes لتوافق Linux / CI

import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/presentation/Recipes/pages/recipes_hospital.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrescriptionHospitalMenuWidget
    extends StatelessWidget {
  const PrescriptionHospitalMenuWidget({
    super.key,
    required this.hospitalId,

  });

  final int hospitalId;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return BlocConsumer<
        DoctorsBloc,
        DoctorsState>(
      // =====================================================
      // Listener فقط للمشفى الحالي
      // نفس السلوك الأصلي
      // =====================================================
      listenWhen: (previous, current) {
        if (current is CheckRecipesState &&
            current.docId == hospitalId) {
          return true;
        }

        if (current is CheckRecipesErrorState &&
            current.docId == hospitalId) {
          return true;
        }

        return false;
      },

      listener: (context, state) {
        // =====================================================
        // Success
        // =====================================================
        if (state is CheckRecipesState) {
          if (state.isCheck == true) {
            initBrandRecModule();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RecipesHospital(
                      hospitalId: hospitalId,
                      st: state.st,
                    ),
              ),
            );
          }
          else {
            ScaffoldMessenger.of(context)
                .clearSnackBars();

            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content: Text(
                  'لقد تجاوزت الحد المسموح لعدد الوصفات',
                ),
              ),
            );
          }
        }

        // =====================================================
        // Error
        // =====================================================
        if (state
        is CheckRecipesErrorState) {
          error(
            context,
            state.failure.massage,
            state.failure.code,
          );
        }
      },

      // =====================================================
      // نفس buildWhen الأصلي
      // =====================================================
      buildWhen: (previous, current) {
        final bool isCurrentLoading =
            current
            is CheckRecipesLoadingState &&
                current.docId == hospitalId;

        final bool isPreviousLoading =
            previous
            is CheckRecipesLoadingState &&
                previous.docId == hospitalId;

        return isCurrentLoading ||
            isPreviousLoading ||
            current is AllHospitalsState;
      },

      builder: (context, state) {
        final bool isLoading =
            state is CheckRecipesLoadingState &&
                state.docId == hospitalId;

        return PopupMenuButton<int>(
          enabled: !isLoading,

          // ===================================================
          // نفس Event الأصلي
          // ===================================================
          onSelected: (value) {
            context
                .read<DoctorsBloc>()
                .add(
              CheckReciEvent(
                hospitalId,
                value,

              ),
            );
          },

          elevation: 4,

          color: Colors.white,

          surfaceTintColor:
          Colors.transparent,

          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
              ui.smallRadius + 4,
            ),

            side: const BorderSide(
              color: Color(
                0xFFE2E8F0,
              ),
            ),
          ),

          offset: Offset(
            0,
            ui.iconBoxSize,
          ),

          // ===================================================
          // Button
          // ===================================================
          child: Padding(
            padding:
            EdgeInsets.symmetric(
              vertical:
              ui.smallSpacing,
            ),

            child: Row(
              mainAxisSize:
              MainAxisSize.min,

              children: [
                if (isLoading)
                  SizedBox(
                    width:
                    ui.smallIconSize,
                    height:
                    ui.smallIconSize,

                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,

                      color: ColorManager
                          .medicalPrimary,
                    ),
                  )
                else ...[
                  Flexible(
                    child: Text(
                      'إدارة الوصفة',

                      maxLines: 1,

                      overflow:
                      TextOverflow.ellipsis,

                      style: TextStyle(
                        color: ColorManager
                            .medicalPrimary,

                        fontWeight:
                        FontWeight.w700,

                        fontSize:
                        ui.isMobile
                            ? 14
                            : 16,
                      ),
                    ),
                  ),

                  SizedBox(
                    width:
                    ui.smallSpacing,
                  ),

                  Icon(
                    Icons
                        .keyboard_arrow_down_rounded,

                    color: ColorManager
                        .medicalPrimary,

                    size:
                    ui.smallIconSize + 2,
                  ),
                ],
              ],
            ),
          ),

          // ===================================================
          // Menu Items
          // ===================================================
          itemBuilder: (context) => [
            _buildPopupItem(
              ui: ui,
              value: 0,
              label: 'إنشاء وصفة',
              icon:
              Icons.add_box_outlined,
            ),

            _buildPopupItem(
              ui: ui,
              value: 1,
              label: 'تكرار وصفة',
              icon:
              Icons.history_rounded,
            ),
          ],
        );
      },
    );
  }

  // ===========================================================
  // Popup Item
  // ===========================================================

  PopupMenuItem<int> _buildPopupItem({
    required AppUi ui,
    required int value,
    required String label,
    required IconData icon,
  }) {
    return PopupMenuItem<int>(
      value: value,

      child: Row(
        children: [
          Icon(
            icon,

            color: ColorManager
                .medicalPrimary,

            size:
            ui.smallIconSize + 3,
          ),

          SizedBox(
            width:
            ui.mediumSpacing,
          ),

          Expanded(
            child: Text(
              label,

              maxLines: 1,

              overflow:
              TextOverflow.ellipsis,

              style: TextStyle(
                fontSize:
                ui.isMobile
                    ? 13
                    : 15,

                fontWeight:
                FontWeight.w600,

                color: const Color(
                  0xFF334155,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}