import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/widget/visit_st_widget.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SenVisitDoctor extends StatelessWidget {
  SenVisitDoctor({
    super.key,
  });

  final TextEditingController searchteDoctorController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;

    double horizontalPadding;
    double searchTopPadding;
    double searchBottomPadding;

    double listTopPadding;
    double listBottomPadding;

    switch (deviceType) {
      // =================================================
      // Mobile
      // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;

        searchTopPadding = 14;
        searchBottomPadding = 8;

        listTopPadding = 6;
        listBottomPadding = 24;
        break;

      // =================================================
      // Tablet Portrait
      // =================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        horizontalPadding = 28;

        searchTopPadding = 18;
        searchBottomPadding = 10;

        listTopPadding = 8;
        listBottomPadding = 30;
        break;

      // =================================================
      // Tablet Landscape
      // =================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        horizontalPadding = 32;

        searchTopPadding = 14;
        searchBottomPadding = 8;

        listTopPadding = 6;
        listBottomPadding = 28;
        break;
    }

    // =====================================================
    // لا يوجد Scaffold
    // لأن الصفحة مستخدمة داخل TabBarView
    // =====================================================
    return ColoredBox(
      color: const Color(
        0xFFF8FAFC,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: pageMaxWidth,
          ),
          child: Column(
            children: [
              // =================================================
              // Search
              // =================================================
              Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  searchTopPadding,
                  horizontalPadding,
                  searchBottomPadding,
                ),
                child: SearchField(
                  searchController: searchteDoctorController,
                  onPressed: (value) {
                    BlocProvider.of<SeniorProfBloc>(
                      context,
                    ).add(
                      SenSearchVisitDoctorEvent(
                        value,
                      ),
                    );
                  },
                ),
              ),

              // =================================================
              // List
              // =================================================
              Expanded(
                child: BlocBuilder<SeniorProfBloc, SeniorProfState>(
                  builder: (context, state) {
                    List<NoVisitDocModel> visitDoc =
                        context.watch<SeniorProfBloc>().visitDoc;

                    // ===========================================
                    // Loading
                    // ===========================================
                    if (state is SenVisitDocLoadingState) {
                      return loadingFullScreen(
                        context,
                      );
                    }
                    if (state is SenVisitDocsState) {
                      visitDoc = state.visitDoc;
                    }

                    // ===========================================
                    // Empty
                    // ===========================================
                    if (state is SenVisitDocEmptyState || visitDoc.isEmpty) {
                      return emptyFullScreen(
                        context,
                      );
                    }

                    // ===========================================
                    // Error
                    // نفس السلوك الأصلي
                    // ===========================================
                    if (state is SenVisitDocErrorState) {
                      return errorFullScreen(
                        context,
                        func: () {
                          BlocProvider.of<SeniorProfBloc>(
                            context,
                          ).add(
                            VisitDocEvent(
                              156,
                              state.planId,
                            ),
                          );
                        },
                      );
                    }

                    // ===========================================
                    // Data
                    // ===========================================
                    return ListView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        listTopPadding,
                        horizontalPadding,
                        listBottomPadding,
                      ),
                      itemCount: visitDoc.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child: buildTotalReportsCard(
                              visitDoc.length,
                              'إجمالي الزيارات الناجحة',
                              'لهذا الشهر',
                            ),
                          );
                        }

                        return VisitedDoctorCard(
                          data: visitDoc[index - 1],
                        );
                      },
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
}

// =======================================================
// Visited Doctor Card
// =======================================================

class VisitedDoctorCard extends StatelessWidget {
  final NoVisitDocModel data;

  const VisitedDoctorCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    // =====================================================
    // Visits calculation
    // =====================================================
    final int total = int.tryParse(
          data.visits ?? '0',
        ) ??
        0;

    final int remaining = data.remainingVisits ?? 0;

    final int done = (total - remaining).clamp(0, total);

    // =====================================================
    // Responsive Values
    // =====================================================

    double rateHorizontalPadding;
    double rateVerticalPadding;
    double rateRadius;
    double rateFontSize;

    double cardBottomSpacing;

    double cardRadius;
    double cardPadding;

    double sideBarWidth;

    double profileBoxSize;
    double profileIconSize;
    double profileRadius;
    double profileSpacing;

    double nameFontSize;
    double specializationFontSize;

    double visitLabelFontSize;
    double visitNumberFontSize;
    double visitTotalFontSize;

    double sectionSpacing;

    double addressIconSize;
    double addressFontSize;
    double addressSpacing;

    double progressHeight;

    switch (deviceType) {
      // =================================================
      // Mobile
      // =================================================
      case AppDeviceType.mobilePortrait:
        rateHorizontalPadding = 7;
        rateVerticalPadding = 3;
        rateRadius = 7;
        rateFontSize = 10;

        cardBottomSpacing = 12;

        cardRadius = 18;
        cardPadding = 15;

        sideBarWidth = 4;

        profileBoxSize = 44;
        profileIconSize = 22;
        profileRadius = 12;
        profileSpacing = 12;

        nameFontSize = 16;
        specializationFontSize = 12;

        visitLabelFontSize = 10;
        visitNumberFontSize = 22;
        visitTotalFontSize = 9.5;

        sectionSpacing = 12;

        addressIconSize = 15;
        addressFontSize = 11.5;
        addressSpacing = 6;

        progressHeight = 7;
        break;

      // =================================================
      // Tablet Portrait
      // =================================================
      case AppDeviceType.tabletPortrait:
        rateHorizontalPadding = 9;
        rateVerticalPadding = 4;
        rateRadius = 8;
        rateFontSize = 12;
        cardBottomSpacing = 14;

        cardRadius = 20;
        cardPadding = 20;

        sideBarWidth = 5;

        profileBoxSize = 52;
        profileIconSize = 26;
        profileRadius = 14;
        profileSpacing = 16;

        nameFontSize = 19;
        specializationFontSize = 14;

        visitLabelFontSize = 12;
        visitNumberFontSize = 27;
        visitTotalFontSize = 11;

        sectionSpacing = 16;

        addressIconSize = 18;
        addressFontSize = 13;
        addressSpacing = 8;

        progressHeight = 8;
        break;

      // =================================================
      // Tablet Landscape
      // =================================================
      case AppDeviceType.tabletLandscape:
        cardBottomSpacing = 12;

        cardRadius = 18;
        cardPadding = 17;

        sideBarWidth = 5;
        rateHorizontalPadding = 8;
        rateVerticalPadding = 3;
        rateRadius = 8;
        rateFontSize = 11;
        profileBoxSize = 48;
        profileIconSize = 24;
        profileRadius = 13;
        profileSpacing = 14;

        nameFontSize = 18;
        specializationFontSize = 13;

        visitLabelFontSize = 11;
        visitNumberFontSize = 24;
        visitTotalFontSize = 10;

        sectionSpacing = 13;

        addressIconSize = 16;
        addressFontSize = 12;
        addressSpacing = 7;

        progressHeight = 7;
        break;
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.only(
          bottom: cardBottomSpacing,
        ),

        // =================================================
        // Outer Card
        //
        // Border صار موحد اللون
        // لذلك ما عاد في مشكلة borderRadius
        // =================================================
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            cardRadius,
          ),
          border: Border.all(
            color: const Color(
              0xFFE9EEF3,
            ),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.03,
              ),
              blurRadius: 12,
              offset: const Offset(
                0,
                4,
              ),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            cardRadius - 1,
          ),

          // =================================================
          // Stack بدل Row + stretch
          //
          // هيك الشريط الأخضر يأخذ ارتفاع الكرت تلقائياً
          // بدون infinite height
          // =================================================
          child: Stack(
            children: [
              // ===============================================
              // Card Content
              // ===============================================
              Padding(
                padding: EdgeInsets.fromLTRB(
                  cardPadding,
                  cardPadding,

                  // زيادة بسيطة من اليمين
                  // حتى ما يلزق المحتوى بالشريط
                  cardPadding + sideBarWidth,

                  cardPadding,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // =========================================
                    // Header
                    // =========================================
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // =====================================
                        // Doctor Icon
                        // =====================================
                        Container(
                          width: profileBoxSize,
                          height: profileBoxSize,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFE8F5E9,
                            ),
                            borderRadius: BorderRadius.circular(
                              profileRadius,
                            ),
                          ),
                          child: Icon(
                            Icons.check_circle_outline_rounded,
                            color: const Color(
                              0xFF43A047,
                            ),
                            size: profileIconSize,
                          ),
                        ),

                        SizedBox(
                          width: profileSpacing,
                        ),

                        // =====================================
                        // Doctor Information
                        // =====================================
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.docTitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: nameFontSize,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(
                                    0xFF0D47A1,
                                  ),
                                  height: 1.25,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 8,
                                runSpacing: 5,
                                children: [
                                  Text(
                                    data.spTitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: specializationFontSize,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  buildRateBadge(
                                    data.rate,
                                    horizontalPadding: rateHorizontalPadding,
                                    verticalPadding: rateVerticalPadding,
                                    radius: rateRadius,
                                    fontSize: rateFontSize,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        // =====================================
                        // Visits Counter
                        // =====================================
                        buildVisitCounter(
                          done: done,
                          total: total,
                          labelFontSize: visitLabelFontSize,
                          numberFontSize: visitNumberFontSize,
                          totalFontSize: visitTotalFontSize,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: sectionSpacing,
                    ),

                    // =========================================
                    // Separator
                    // =========================================
                    Container(
                      height: 1,
                      color: const Color(
                        0xFFF1F5F9,
                      ),
                    ),

                    SizedBox(
                      height: sectionSpacing,
                    ),

                    // =========================================
                    // Address
                    // =========================================
                    _buildAddressRow(
                      iconSize: addressIconSize,
                      fontSize: addressFontSize,
                      spacing: addressSpacing,
                    ),

                    SizedBox(
                      height: sectionSpacing,
                    ),

                    // =========================================
                    // Progress
                    // =========================================
                    buildProgressBar(
                      done,
                      total,
                      Color(0xFF2E7D32),
                      height: progressHeight,
                    ),
                  ],
                ),
              ),

              // =================================================
              // Success Side Bar
              //
              // Positioned بياخد ارتفاع الـ Stack نفسه
              // لذلك لا Infinity ولا IntrinsicHeight
              // =================================================
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  width: sideBarWidth,
                  color: const Color(
                    0xFF43A047,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Visit Counter
  // =====================================================

  Widget buildVisitCounter({
    required int done,
    required int total,
    required double labelFontSize,
    required double numberFontSize,
    required double totalFontSize,
  }) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 58,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(
          0xFFF0FDF4,
        ),
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(
          color: const Color(
            0xFFDCFCE7,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "تمت زيارته",
            maxLines: 1,
            style: TextStyle(
              fontSize: labelFontSize,
              color: const Color(
                0xFF2E7D32,
              ),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            "$done",
            style: TextStyle(
              fontSize: numberFontSize,
              height: 1,
              fontWeight: FontWeight.w800,
              color: const Color(
                0xFF2E7D32,
              ),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "من أصل $total",
            maxLines: 1,
            style: TextStyle(
              fontSize: totalFontSize,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // Progress
  // =====================================================

  // =====================================================
  // Address
  // =====================================================

  Widget _buildAddressRow({
    required double iconSize,
    required double fontSize,
    required double spacing,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: iconSize + 12,
          height: iconSize + 12,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(
              0xFFEFF6FF,
            ),
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          child: Icon(
            Icons.location_on_outlined,
            size: iconSize,
            color: const Color(
              0xFF64B5F6,
            ),
          ),
        ),
        SizedBox(
          width: spacing,
        ),
        Expanded(
          child: Text(
            data.address.isEmpty ? "العنوان غير محدد" : data.address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.grey.shade700,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
