import 'package:domina_app/app/constants.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewRecipePage extends StatelessWidget {
  const ViewRecipePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ),

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: ColorManager.secondaryColor7,

        leading: IconButton(
          tooltip: 'رجوع',
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: ColorManager.white,
          ),
        ),

        title: Text(
          'تفاصيل الوصفة',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: ColorManager.white,
            fontSize: ui.isMobile ? 18 : 21,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: BlocBuilder<
          SeniorProfBloc,
          SeniorProfState>(
        builder: (context, state) {
          // =====================================================
          // Loading
          // =====================================================
          if (state is ViewRecipeLoadingState) {
            return loadingFullScreen(
              context,
            );
          }

          // =====================================================
          // Error
          // =====================================================
          if (state is ViewRecipeErrorState) {
            return Center(
              child: errorFullScreen(
                context,
              ),
            );
          }

          // =====================================================
          // Data
          // =====================================================
          if (state is ViewRecipeState) {
            final bool isDoctor =
                state.isDoctor;

            final recipe =
                state.copyRecipeRequest;

            // نفس النمط القديم:
            // لا نخلي صفحة التفاصيل تتمدد كثير بالتابلت الأفقي.
            final double contentMaxWidth =
            ui.isTabletLandscape
                ? 760
                : ui.pageMaxWidth;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: contentMaxWidth,
                ),

                child: SingleChildScrollView(
                  physics:
                  const BouncingScrollPhysics(),

                  padding: EdgeInsets.fromLTRB(
                    ui.pagePadding,
                    ui.pageTopPadding,
                    ui.pagePadding,
                    ui.pageBottomPadding,
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.stretch,

                    children: [
                      // =================================================
                      // Name
                      // =================================================
                      _buildCardContent(
                        ui: ui,
                        content: state.name,
                      ),

                      SizedBox(
                        height: ui.largeSpacing,
                      ),

                      // =================================================
                      // Recipe Details
                      // =================================================
                      _buildRecipeDetail(
                        ui: ui,
                        label: isDoctor
                            ? 'اختصاص الطبيب'
                            : 'الإختصاص',
                        value: recipe.spName,
                      ),

                      _buildRecipeDetail(
                        ui: ui,
                        label: 'المستحضر الأول',
                        value:
                        recipe.brand_1.title_en,
                      ),

                      _buildRecipeDetail(
                        ui: ui,
                        label: 'المستحضر الثاني',
                        value:
                        recipe.brand_2?.title_en,
                      ),

                      _buildRecipeDetail(
                        ui: ui,
                        label: 'المستحضر الثالث',
                        value:
                        recipe.brand_3?.title_en,
                      ),

                      _buildRecipeDetail(
                        ui: ui,
                        label: 'المستحضر الرابع',
                        value:
                        recipe.brand_4?.title_en,
                      ),

                      SizedBox(
                        height: ui.smallSpacing,
                      ),

                      _buildRecipeDetail(
                        ui: ui,
                        label: 'الملاحظة الأولى',
                        value: recipe.note1 ??
                            'يرجى عدم تبديل الدواء',
                      ),

                      _buildRecipeDetail(
                        ui: ui,
                        label: 'الملاحظة الثانية',
                        value:
                        recipe.note2 ?? '',
                      ),

                      _buildRecipeDetail(
                        ui: ui,
                        label: 'العنوان',
                        value: recipe.address,
                      ),

                      _buildRecipeDetail(
                        ui: ui,
                        label: 'التواصل',
                        value: recipe.phone,
                      ),

                      _buildRecipeDetail(
                        ui: ui,
                        label:
                        'عدد الوصفات المطبوعة',
                        value: recipe.total,
                      ),

                      _buildRecipeDetail(
                        ui: ui,
                        label:
                        'ملاحظات خاصة للمندوب',
                        value:
                        recipe.note_emp ?? '',
                      ),

                      SizedBox(
                        height: ui.sectionSpacing,
                      ),

                      Divider(
                        height: 1,
                        thickness: 1,
                        color: ColorManager
                            .secondaryColor
                            .withOpacity(0.20),
                      ),

                      SizedBox(
                        height: ui.sectionSpacing,
                      ),

                      // =================================================
                      // Images
                      // =================================================
                      if ((recipe.image1 != null &&
                          recipe.image1!
                              .isNotEmpty) ||
                          (recipe.image2 != null &&
                              recipe.image2!
                                  .isNotEmpty))
                        _buildImagesSection(
                          context: context,
                          ui: ui,
                          image1: recipe.image1,
                          image2: recipe.image2,
                        ),

                      SizedBox(
                        height: ui.mediumSpacing,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  // ===========================================================
  // Header Card
  // ===========================================================

  Widget _buildCardContent({
    required AppUi ui,
    required String? content,
  }) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(
        ui.cardPadding,
      ),

      decoration: BoxDecoration(
        color: ColorManager.secondaryColor1,

        borderRadius: BorderRadius.circular(
          ui.cardRadius,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.04,
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: Text(
        content ?? 'غير متوفر',

        textAlign: TextAlign.center,

        maxLines: 2,
        overflow: TextOverflow.ellipsis,

        style: TextStyle(
          fontSize:
          ui.isMobile ? 18 : 20,
          fontWeight: FontWeight.w700,
          color: ColorManager.white,
          height: 1.4,
        ),
      ),
    );
  }

  // ===========================================================
  // Recipe Detail
  // ===========================================================

  Widget _buildRecipeDetail({
    required AppUi ui,
    required String label,
    required String? value,
  }) {
    final String displayValue =
    value?.trim().isNotEmpty == true
        ? value!.trim()
        : 'غير متوفر';

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ui.smallSpacing,
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,

        children: [
          // =================================================
          // Label
          // =================================================
          SizedBox(
            width: ui.isMobile
                ? 120
                : 150,

            child: Text(
              label,

              maxLines: 2,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                fontSize:
                ui.isMobile ? 14 : 16,
                fontWeight:
                FontWeight.w600,
                color:
                ColorManager.secondaryColor1,
                height: 1.35,
              ),
            ),
          ),

          SizedBox(
            width: ui.mediumSpacing,
          ),

          // =================================================
          // Value
          // =================================================
          Expanded(
            child: Container(
              padding: EdgeInsets.all(
                ui.cardPadding,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(
                  ui.smallRadius + 2,
                ),

                border: Border.all(
                  color: const Color(
                    0xFFE2E8F0,
                  ),
                ),

                boxShadow: [
                  BoxShadow(
                    color:
                    Colors.black.withOpacity(
                      0.025,
                    ),
                    blurRadius: 8,
                    offset: const Offset(
                      0,
                      2,
                    ),
                  ),
                ],
              ),

              child: Text(
                displayValue,

                maxLines: 3,
                overflow:
                TextOverflow.ellipsis,

                style: TextStyle(
                  fontSize:
                  ui.bodyTextSize,
                  color: const Color(
                    0xFF475569,
                  ),
                  fontWeight:
                  FontWeight.w500,
                  height: 1.45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // Images Section
  // ===========================================================

  Widget _buildImagesSection({
    required BuildContext context,
    required AppUi ui,
    required String? image1,
    required String? image2,
  }) {
    final List<Widget> images = [];

    if (image1 != null &&
        image1.isNotEmpty) {
      images.add(
        _buildRecipeImage(
          ui: ui,
          label: 'صورة الوصفة 1',
          value: image1,
        ),
      );
    }

    if (image2 != null &&
        image2.isNotEmpty) {
      images.add(
        _buildRecipeImage(
          ui: ui,
          label: 'صورة الوصفة 2',
          value: image2,
        ),
      );
    }

    return LayoutBuilder(
      builder: (
          context,
          constraints,
          ) {
        // موبايل ضيق:
        // الصور تحت بعض حتى لا تعمل overflow.
        final bool showVertically =
            constraints.maxWidth < 600;

        if (showVertically) {
          return Column(
            children: [
              for (int i = 0;
              i < images.length;
              i++) ...[
                images[i],

                if (i != images.length - 1)
                  SizedBox(
                    height:
                    ui.sectionSpacing,
                  ),
              ],
            ],
          );
        }

        return Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            for (int i = 0;
            i < images.length;
            i++) ...[
              Expanded(
                child: images[i],
              ),

              if (i != images.length - 1)
                SizedBox(
                  width: ui.sectionSpacing,
                ),
            ],
          ],
        );
      },
    );
  }

  // ===========================================================
  // Recipe Image
  // ===========================================================

  Widget _buildRecipeImage({
    required AppUi ui,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.stretch,

      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            ui.cardRadius,
          ),

          child: AspectRatio(
            aspectRatio: 16 / 10,

            child: Image.network(
              '${Constants.imageUrl}$value',

              fit: BoxFit.cover,

              errorBuilder: (
                  context,
                  error,
                  stackTrace,
                  ) {
                return Container(
                  color: const Color(
                    0xFFF1F5F9,
                  ),

                  alignment:
                  Alignment.center,

                  child: Icon(
                    Icons.broken_image_outlined,
                    color: const Color(
                      0xFF94A3B8,
                    ),
                    size: ui.iconSize + 8,
                  ),
                );
              },
            ),
          ),
        ),

        SizedBox(
          height: ui.smallSpacing,
        ),

        Text(
          label,

          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize:
            ui.isMobile ? 14 : 16,
            fontWeight: FontWeight.w600,
            color:
            ColorManager.secondaryColor1,
          ),
        ),
      ],
    );
  }
}