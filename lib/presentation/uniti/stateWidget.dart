import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/uniti/common/state_renderer/state_renderer.dart';
import 'package:domina_app/presentation/uniti/common/state_renderer/state_renderer_imp.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
Widget loadingFullScreen(BuildContext context) {
  return LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState)
      .getScreenWidget(context, SizedBox(), () {});
}

Widget errorFullScreen(BuildContext context, {Function? func, String? mes}) {
  return ErrorState(StateRendererType.fullScreenErrorState, mes ?? "")
      .getScreenWidget(context, SizedBox(), func ?? () {});
}

Widget emptyFullScreen(BuildContext context, {String? message, IconData? icon}) {
  return EmptyDataWidget(message:message ,icon: icon,);
}
class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
    this.title = "لا يوجد بيانات",
    this.message,
    this.icon,
  });

  final String? title;
  final String? message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    final keyboardInset =
        MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      duration: const Duration(
        milliseconds: 180,
      ),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: keyboardInset,
      ),
      child: Center(
        child: SingleChildScrollView(
          physics:
          const BouncingScrollPhysics(),

          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,

          padding: EdgeInsets.symmetric(
            horizontal: ui.pagePadding,
            vertical: ui.sectionSpacing,
          ),

          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 420,
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ============================================
                // Icon Area
                // ============================================
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // دائرة خلفية ناعمة
                    Container(
                      width: ui.iconBoxSize + 48,
                      height: ui.iconBoxSize + 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager
                            .secondaryColor1
                            .withOpacity(
                          0.035,
                        ),
                      ),
                    ),

                    // الدائرة الأساسية
                    Container(
                      width: ui.iconBoxSize + 18,
                      height: ui.iconBoxSize + 18,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager
                            .secondaryColor1
                            .withOpacity(
                          0.08,
                        ),
                        border: Border.all(
                          color: ColorManager
                              .secondaryColor1
                              .withOpacity(
                            0.10,
                          ),
                        ),
                      ),
                      child: Icon(
                        icon ??
                            Icons
                                .inventory_2_outlined,
                        size: ui.iconSize + 8,
                        color: ColorManager
                            .secondaryColor1
                            .withOpacity(
                          0.8,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: ui.sectionSpacing + 8,
                ),

                // ============================================
                // Small Accent
                // ============================================
                Container(
                  width: 34,
                  height: 4,
                  decoration: BoxDecoration(
                    color: ColorManager
                        .secondaryColor1
                        .withOpacity(
                      0.65,
                    ),
                    borderRadius:
                    BorderRadius.circular(
                      20,
                    ),
                  ),
                ),

                SizedBox(
                  height: ui.sectionSpacing,
                ),

                // ============================================
                // Title
                // ============================================
                Text(
                  title ?? "لا يوجد بيانات",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ui.cardTitleSize,
                    fontWeight: FontWeight.w700,
                    color: const Color(
                      0xFF334155,
                    ),
                    height: 1.35,
                  ),
                ),

                // ============================================
                // Message
                // ============================================
                if (message != null &&
                    message!.trim().isNotEmpty) ...[
                  SizedBox(
                    height: ui.smallSpacing + 2,
                  ),

                  Text(
                    message!,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow:
                    TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ui.bodyTextSize,
                      fontWeight: FontWeight.w500,
                      color: const Color(
                        0xFF94A3B8,
                      ),
                      height: 1.55,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Widget loadingShimmer(
    BuildContext context,
    int count,
    double? width,
    double? height,
    BorderRadiusGeometry? borderRadius,
    ) {
  final deviceType =
  AppResponsive.deviceType(context);

  // =====================================================
  // Responsive Values
  // =====================================================

  double horizontalMargin;
  double verticalMargin;

  double cardPadding;
  double cardRadius;

  double iconBoxSize;
  double iconRadius;

  double titleHeight;
  double titleMaxWidth;

  double subtitleHeight;
  double subtitleMaxWidth;

  double trailingWidth;
  double trailingHeight;
  double trailingRadius;

  switch (deviceType) {
  // =================================================
  // Mobile
  // =================================================
    case AppDeviceType.mobilePortrait:
      horizontalMargin = 4;
      verticalMargin = 6;

      cardPadding = 14;
      cardRadius = 18;

      iconBoxSize = 44;
      iconRadius = 12;

      titleHeight = 13;
      titleMaxWidth = 150;

      subtitleHeight = 10;
      subtitleMaxWidth = 105;

      trailingWidth = 42;
      trailingHeight = 30;
      trailingRadius = 9;
      break;

  // =================================================
  // Tablet Portrait
  // =================================================
    case AppDeviceType.tabletPortrait:
      horizontalMargin = 6;
      verticalMargin = 7;

      cardPadding = 18;
      cardRadius = 20;

      iconBoxSize = 52;
      iconRadius = 14;

      titleHeight = 15;
      titleMaxWidth = 210;

      subtitleHeight = 11;
      subtitleMaxWidth = 150;

      trailingWidth = 52;
      trailingHeight = 36;
      trailingRadius = 11;
      break;

  // =================================================
  // Tablet Landscape
  // =================================================
    case AppDeviceType.tabletLandscape:
      horizontalMargin = 6;
      verticalMargin = 6;

      cardPadding = 16;
      cardRadius = 18;

      iconBoxSize = 48;
      iconRadius = 13;

      titleHeight = 14;
      titleMaxWidth = 190;

      subtitleHeight = 10;
      subtitleMaxWidth = 135;

      trailingWidth = 48;
      trailingHeight = 32;
      trailingRadius = 10;
      break;
  }

  // =====================================================
  // نحافظ على البراميتر القديم borderRadius
  // إذا انبعت نستخدمه، وإلا responsive radius
  // =====================================================

  final BorderRadiusGeometry effectiveBorderRadius =
      borderRadius ??
          BorderRadius.circular(
            cardRadius,
          );

  // =====================================================
  // count Safety
  //
  // ما في داعي نرسم عدد سكيليتون سلبي
  // =====================================================

  final int safeCount =
  count < 0 ? 0 : count;

  return ListView.builder(
    shrinkWrap: true,

    physics:
    const NeverScrollableScrollPhysics(),

    padding:
    EdgeInsets.zero,

    itemCount:
    safeCount,

    itemBuilder:
        (context, index) {
      return Shimmer.fromColors(
        baseColor:
        const Color(
          0xFFE2E8F0,
        ),

        highlightColor:
        const Color(
          0xFFF8FAFC,
        ),

        child: Container(
          margin:
          EdgeInsets.symmetric(
            horizontal:
            horizontalMargin,

            vertical:
            verticalMargin,
          ),

          padding:
          EdgeInsets.all(
            cardPadding,
          ),

          decoration:
          BoxDecoration(
            color:
            Colors.white,

            borderRadius:
            effectiveBorderRadius,

            border:
            Border.all(
              color: ColorManager
                  .secondaryColor22
                  .withOpacity(
                0.45,
              ),
            ),

            boxShadow: [
              BoxShadow(
                color:
                Colors.black
                    .withOpacity(
                  0.02,
                ),

                blurRadius: 10,

                offset:
                const Offset(
                  0,
                  4,
                ),
              ),
            ],
          ),

          child: Row(
            children: [
              // =================================================
              // Icon / Image Placeholder
              // =================================================
              Container(
                width:
                iconBoxSize,

                height:
                iconBoxSize,

                decoration:
                BoxDecoration(
                  color:
                  Colors.white,

                  borderRadius:
                  BorderRadius
                      .circular(
                    iconRadius,
                  ),
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              // =================================================
              // Text Placeholders
              // =================================================
              Expanded(
                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,

                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  children: [
                    // =============================================
                    // Title
                    // =============================================
                    FractionallySizedBox(
                      widthFactor:
                      deviceType ==
                          AppDeviceType
                              .mobilePortrait
                          ? 0.72
                          : 0.62,

                      alignment:
                      Alignment
                          .centerRight,

                      child:
                      Container(
                        constraints:
                        BoxConstraints(
                          maxWidth:
                          titleMaxWidth,
                        ),

                        height:
                        titleHeight,

                        decoration:
                        BoxDecoration(
                          color:
                          Colors.white,

                          borderRadius:
                          BorderRadius
                              .circular(
                            6,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 9,
                    ),

                    // =============================================
                    // Subtitle
                    // =============================================
                    FractionallySizedBox(
                      widthFactor:
                      deviceType ==
                          AppDeviceType
                              .mobilePortrait
                          ? 0.52
                          : 0.42,

                      alignment:
                      Alignment
                          .centerRight,

                      child:
                      Container(
                        constraints:
                        BoxConstraints(
                          maxWidth:
                          subtitleMaxWidth,
                        ),

                        height:
                        subtitleHeight,

                        decoration:
                        BoxDecoration(
                          color:
                          Colors.white,

                          borderRadius:
                          BorderRadius
                              .circular(
                            5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              // =================================================
              // Trailing Placeholder
              // =================================================
              Container(
                width:
                trailingWidth,

                height:
                trailingHeight,

                decoration:
                BoxDecoration(
                  color:
                  Colors.white,

                  borderRadius:
                  BorderRadius
                      .circular(
                    trailingRadius,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
void error(BuildContext context, String massage, int code) async {
  await dismissDialog(context);
  ErrorState(StateRendererType.popupErrorState, massage)
      .showPopup(context, StateRendererType.popupErrorState, massage);
}

void loading(BuildContext context, {String? text}) {
  LoadingState(stateRendererType: StateRendererType.popupLoadingState)
      .showPopup(context, StateRendererType.popupLoadingState, "loading $text");
}

Future<bool> success(BuildContext context) async {
  try {
    dismissDialog(context);
    return true;
  } catch (e) {
    print("ssssssssssssssssss: $e");
    return false;
  }
}

void successWithMessage(BuildContext context, String message) {
  SuccessState(message) //
      .showPopup(context, StateRendererType.popupSuccess, message);
}

Future<bool> dismissDialog(BuildContext context) async {
  try {
    // نتحقق مباشرة من الـ rootNavigator إذا كان لديه أي Dialog مفتوح يمكن إغلاقه
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(true);
      print("Dialog dismissed successfully33.");

      // نمنح المعالج 50 ملي ثانية لإنهاء حركة الإغلاق والتأكد من استقرار الـ Context
      await Future.delayed(const Duration(milliseconds: 50));
      return true;
    }
    print("No dialog found to dismiss.");
    return false;
  } catch (e) {
    print("Error during dismissDialog: $e");
    return false;
  }
}
