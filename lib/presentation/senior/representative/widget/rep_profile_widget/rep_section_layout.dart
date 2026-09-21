import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';


// =====================================================
// Unified Section Layout
// =====================================================

Widget buildSectionLayout(
    BuildContext context,
    String title,
    List<Widget> items,
    ) {
  final ui =
  AppUi.of(context);

  return Column(
    crossAxisAlignment:
    CrossAxisAlignment.start,

    children: [
      // =================================================
      // Section Title
      // =================================================
      buildSectionTitle(
        context,
        title:
        title,
      ),

      SizedBox(
        height:
        ui.sectionSpacing,
      ),

      // =================================================
      // Tablet Landscape
      //
      // 2 Columns
      // =================================================
      if (ui
          .isTabletLandscape) ...[
        for (
        int i = 0;
        i < items.length;
        i += 2
        ) ...[
          Row(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,

            children: [
              Expanded(
                child:
                items[i],
              ),

              SizedBox(
                width:
                ui.sectionSpacing,
              ),

              Expanded(
                child: i + 1 <
                    items.length
                    ? items[
                i + 1]
                    : const SizedBox
                    .shrink(),
              ),
            ],
          ),

          if (i + 2 <
              items.length)
            SizedBox(
              height:
              ui.sectionSpacing,
            ),
        ],
      ] else ...[
        // =================================================
        // Mobile + Tablet Portrait
        // =================================================
        ...items,
      ],
    ],
  );
}


// =====================================================
// Section Title
// =====================================================

Widget buildSectionTitle(
    BuildContext context, {
      required String title,
    }) {
  final ui =
  AppUi.of(context);

  return Row(
    children: [
      Container(
        width: 4,

        height:
        ui.isMobile
            ? 20
            : 22,

        decoration:
        BoxDecoration(
          color:
          const Color(
            0xFF1F4E79,
          ),

          borderRadius:
          BorderRadius.circular(
            10,
          ),
        ),
      ),

      SizedBox(
        width:
        ui.mediumSpacing,
      ),

      Expanded(
        child: Text(
          title,

          maxLines:
          2,

          overflow:
          TextOverflow
              .ellipsis,

          style:
          TextStyle(
            fontSize:
            ui.cardTitleSize,

            fontWeight:
            FontWeight.w700,

            color:
            const Color(
              0xFF2C3E50,
            ),

            height:
            1.3,
          ),
        ),
      ),
    ],
  );
}
