import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/plan_management/bloc/plan_management_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePlanBrandPage extends StatefulWidget {
  const CreatePlanBrandPage({
    super.key,
  });

  @override
  State<CreatePlanBrandPage> createState() =>
      _CreatePlanBrandPageState();
}

class _CreatePlanBrandPageState
    extends State<CreatePlanBrandPage> {
  final TextEditingController searchController =
  TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ===========================================================
  // Confirmation Dialog
  // ===========================================================

  void _showConfirmationDialog(
      BuildContext context,
      ) {
    final ui = AppUi.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: ui.pagePadding,
            vertical: ui.sectionSpacing,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ui.isMobile ? 420 : 500,
            ),
            child: Container(
              padding: EdgeInsets.all(
                ui.cardPadding,
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
                      0.06,
                    ),
                    blurRadius: 20,
                    offset: const Offset(
                      0,
                      8,
                    ),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: ui.iconBoxSize,
                        height: ui.iconBoxSize,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorManager
                              .medicalPrimary
                              .withOpacity(
                            0.08,
                          ),
                          borderRadius:
                          BorderRadius.circular(
                            ui.smallRadius + 2,
                          ),
                        ),
                        child: Icon(
                          Icons.help_outline_rounded,
                          size: ui.iconSize,
                          color: ColorManager
                              .medicalPrimary,
                        ),
                      ),
                      SizedBox(
                        width: ui.sectionSpacing,
                      ),
                      Expanded(
                        child: Text(
                          'تأكيد إرسال الخطة',
                          maxLines: 2,
                          overflow:
                          TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize:
                            ui.cardTitleSize,
                            fontWeight:
                            FontWeight.w700,
                            color: const Color(
                              0xFF1E293B,
                            ),
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ui.sectionSpacing,
                  ),
                  Text(
                    'هل أنت متأكد من حفظ التعديلات وإرسال الخطة المستقبلية؟',
                    style: TextStyle(
                      fontSize: ui.bodyTextSize,
                      color: const Color(
                        0xFF64748B,
                      ),
                      fontWeight:
                      FontWeight.w500,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(
                    height: ui.largeSpacing,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style:
                          OutlinedButton.styleFrom(
                            foregroundColor:
                            const Color(
                              0xFF64748B,
                            ),
                            side: const BorderSide(
                              color: Color(
                                0xFFE2E8F0,
                              ),
                            ),
                            padding:
                            EdgeInsets.symmetric(
                              vertical:
                              ui.mediumSpacing +
                                  3,
                            ),
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                ui.smallRadius + 2,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(
                              dialogContext,
                            ).pop();
                          },
                          child: Text(
                            'تراجع',
                            style: TextStyle(
                              fontSize:
                              ui.bodyTextSize,
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ui.mediumSpacing,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            ColorManager
                                .medicalPrimary,
                            foregroundColor:
                            Colors.white,
                            elevation: 0,
                            padding:
                            EdgeInsets.symmetric(
                              vertical:
                              ui.mediumSpacing +
                                  3,
                            ),
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                ui.smallRadius + 2,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(
                              dialogContext,
                            ).pop();

                            context
                                .read<
                                PlanManagementBloc>()
                                .add(
                              SubmitPlanEvent(),
                            );
                          },
                          child: Text(
                            'نعم، إرسال',
                            style: TextStyle(
                              fontSize:
                              ui.bodyTextSize,
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return BlocConsumer<
        PlanManagementBloc,
        PlanManagementState>(
      listener: (context, state) {
        if (state.futureStatus ==
            PlanStatus.submitSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                'تم حفظ الخطة والموافقة عليها بنجاح',
              ),
              backgroundColor: Colors.green,
            ),
          );

          context
              .read<PlanManagementBloc>()
              .add(
            GetRepInfoEvent(),
          );

          searchController.clear();
          FocusScope.of(context).unfocus();
        }
      },
      builder: (context, state) {
        if (state.futureStatus ==
            PlanStatus.loading) {
          return _buildLoadingState(
            context,
          );
        }

        if (state.futureStatus ==
            PlanStatus.error) {
          return _buildErrorState(
            context,
            state.futureFailure?.massage ??
                'حدث خطأ غير متوقع',
          );
        }

        final bool currentEnable =
            state.isEnable;

        final List<PlanBrandSp> displayBrands =
            state.searchFutureBrands;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ui.isTabletLandscape
                  ? ui.widePageMaxWidth
                  : ui.pageMaxWidth,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    ui.pagePadding,
                    ui.searchTopPadding,
                    ui.pagePadding,
                    ui.searchBottomPadding,
                  ),
                  child: SearchField(
                    searchController:
                    searchController,
                    onPressed: (value) {
                      context
                          .read<
                          PlanManagementBloc>()
                          .add(
                        SearchPlanBrandEvent(
                          value,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: displayBrands.isEmpty
                      ? emptyFullScreen(
                    context,
                    message:
                    'لا توجد نتائج مطابقة للبحث',
                  )
                      : ListView.separated(
                    physics:
                    const BouncingScrollPhysics(),
                    keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior
                        .onDrag,
                    padding:
                    EdgeInsets.fromLTRB(
                      ui.pagePadding,
                      ui.listTopPadding,
                      ui.pagePadding,
                      ui.listBottomPadding,
                    ),
                    itemCount:
                    displayBrands.length,
                    separatorBuilder:
                        (context, index) =>
                        SizedBox(
                          height:
                          ui.cardSpacing,
                        ),
                    itemBuilder:
                        (context, index) {
                      final brand =
                      displayBrands[index];

                      return _buildBrandCard(
                        context: context,
                        brand: brand,
                        index: index,
                        currentEnable:
                        currentEnable,
                      );
                    },
                  ),
                ),
                if (state.isEnable)
                  _buildSubmitArea(
                    context,
                    state,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ===========================================================
  // Brand Card
  // ===========================================================

  Widget _buildBrandCard({
    required BuildContext context,
    required PlanBrandSp brand,
    required int index,
    required bool currentEnable,
  }) {
    final ui = AppUi.of(context);

    return Container(
      padding: EdgeInsets.all(
        ui.cardPadding,
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
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: [
          Container(
            width: ui.iconBoxSize,
            height: ui.iconBoxSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: brand.brandType.color
                  .withOpacity(
                0.08,
              ),
              borderRadius:
              BorderRadius.circular(
                ui.smallRadius + 2,
              ),
            ),
            child: Icon(
              brand.brandType.i == 2
                  ? Icons.handshake_outlined
                  : Icons.ads_click_rounded,
              color: brand.brandType.color,
              size: ui.iconSize,
            ),
          ),
          SizedBox(
            width: ui.sectionSpacing,
          ),
          Expanded(
            child: Column(
              mainAxisSize:
              MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  brand.titleAr,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize:
                    ui.cardTitleSize,
                    fontWeight:
                    FontWeight.w700,
                    color: const Color(
                      0xFF1E293B,
                    ),
                    height: 1.3,
                  ),
                ),
                SizedBox(
                  height: ui.smallSpacing,
                ),
                Text(
                  brand.phTitle,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize:
                    ui.bodyTextSize,
                    color: const Color(
                      0xFF64748B,
                    ),
                    fontWeight:
                    FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                SizedBox(
                  height: ui.smallSpacing,
                ),
                Align(
                  alignment:
                  AlignmentDirectional
                      .centerStart,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(
                      horizontal:
                      ui.mediumSpacing,
                      vertical: 4,
                    ),
                    decoration:
                    BoxDecoration(
                      color: brand
                          .brandType.color
                          .withOpacity(
                        0.10,
                      ),
                      borderRadius:
                      BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Text(
                      brand.brandType.name,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: TextStyle(
                        color:
                        brand.brandType.color,
                        fontSize:
                        ui.smallTextSize,
                        fontWeight:
                        FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: ui.mediumSpacing,
          ),
          SizedBox(
            width: ui.isMobile ? 82 : 96,
            child: TextFormField(
              key: ValueKey(
                '${brand.id}_create',
              ),
              initialValue:
              brand.totalAmount == 0
                  ? ''
                  : brand.totalAmount
                  .toString(),
              enabled: currentEnable,
              keyboardType:
              TextInputType.number,
              textAlign:
              TextAlign.center,
              style: TextStyle(
                fontSize:
                ui.cardTitleSize,
                fontWeight:
                FontWeight.w700,
                color: const Color(
                  0xFF334155,
                ),
              ),
              decoration:
              InputDecoration(
                hintText: '0',
                isDense: true,
                contentPadding:
                EdgeInsets.symmetric(
                  horizontal:
                  ui.smallSpacing,
                  vertical:
                  ui.mediumSpacing + 2,
                ),
                filled: true,
                fillColor:
                currentEnable
                    ? const Color(
                  0xFFF8FAFC,
                )
                    : const Color(
                  0xFFF1F5F9,
                ),
                enabledBorder:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                    ui.smallRadius + 2,
                  ),
                  borderSide:
                  const BorderSide(
                    color: Color(
                      0xFFE2E8F0,
                    ),
                  ),
                ),
                disabledBorder:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                    ui.smallRadius + 2,
                  ),
                  borderSide:
                  const BorderSide(
                    color: Color(
                      0xFFE2E8F0,
                    ),
                  ),
                ),
                focusedBorder:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                    ui.smallRadius + 2,
                  ),
                  borderSide:
                  BorderSide(
                    color:
                    brand.brandType.color,
                    width: 1.5,
                  ),
                ),
              ),
              onChanged: (val) {
                final qty =
                    int.tryParse(val) ?? 0;

                context
                    .read<
                    PlanManagementBloc>()
                    .add(
                  UpdateBrandQuantityEvent(
                    index: index,
                    quantity: qty,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // Submit Area
  // ===========================================================

  Widget _buildSubmitArea(
      BuildContext context,
      PlanManagementState state,
      ) {
    final ui = AppUi.of(context);

    final bool isSubmitting =
        state.futureStatus ==
            PlanStatus.submitting;

    return Container(
      padding: EdgeInsets.fromLTRB(
        ui.pagePadding,
        ui.mediumSpacing,
        ui.pagePadding,
        ui.pageBottomPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(
            color: Color(
              0xFFE2E8F0,
            ),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.035,
            ),
            offset: const Offset(
              0,
              -4,
            ),
            blurRadius: 12,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style:
            ElevatedButton.styleFrom(
              backgroundColor:
              ColorManager.medicalPrimary,
              foregroundColor:
              Colors.white,
              elevation: 0,
              padding:
              EdgeInsets.symmetric(
                vertical:
                ui.mediumSpacing + 5,
              ),
              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                  ui.cardRadius - 4,
                ),
              ),
            ),
            onPressed: isSubmitting
                ? null
                : () {
              _showConfirmationDialog(
                context,
              );
            },
            child: isSubmitting
                ? SizedBox(
              width: ui.iconSize,
              height: ui.iconSize,
              child:
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.5,
              ),
            )
                : Text(
              'حفظ الخطة والموافقة النهائية',
              textAlign:
              TextAlign.center,
              style: TextStyle(
                fontSize:
                ui.isMobile
                    ? 15
                    : 17,
                fontWeight:
                FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Loading
  // ===========================================================

  Widget _buildLoadingState(
      BuildContext context,
      ) {
    final ui = AppUi.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(
          ui.pagePadding,
        ),
        child: Column(
          mainAxisSize:
          MainAxisSize.min,
          children: [
            SizedBox(
              width: ui.iconSize + 6,
              height: ui.iconSize + 6,
              child:
              CircularProgressIndicator(
                strokeWidth: 2.5,
                color: ColorManager
                    .medicalPrimary,
              ),
            ),
            SizedBox(
              height: ui.sectionSpacing,
            ),
            Text(
              'جاري تحميل الخطة...',
              textAlign:
              TextAlign.center,
              style: TextStyle(
                fontSize:
                ui.bodyTextSize,
                color: const Color(
                  0xFF64748B,
                ),
                fontWeight:
                FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // Error
  // ===========================================================

  Widget _buildErrorState(
      BuildContext context,
      String message,
      ) {
    final ui = AppUi.of(context);

    return Center(
      child: SingleChildScrollView(
        physics:
        const BouncingScrollPhysics(),
        padding: EdgeInsets.all(
          ui.pagePadding,
        ),
        child: ConstrainedBox(
          constraints:
          const BoxConstraints(
            maxWidth: 420,
          ),
          child: Column(
            mainAxisSize:
            MainAxisSize.min,
            children: [
              Container(
                width:
                ui.iconBoxSize + 16,
                height:
                ui.iconBoxSize + 16,
                alignment:
                Alignment.center,
                decoration:
                BoxDecoration(
                  color: const Color(
                    0xFFFEF2F2,
                  ),
                  borderRadius:
                  BorderRadius.circular(
                    ui.cardRadius,
                  ),
                ),
                child: Icon(
                  Icons
                      .error_outline_rounded,
                  size: ui.iconSize + 8,
                  color: const Color(
                    0xFFEF4444,
                  ),
                ),
              ),
              SizedBox(
                height:
                ui.sectionSpacing,
              ),
              Text(
                'حدث خطأ',
                textAlign:
                TextAlign.center,
                style: TextStyle(
                  fontSize:
                  ui.cardTitleSize,
                  fontWeight:
                  FontWeight.w700,
                  color: const Color(
                    0xFF334155,
                  ),
                ),
              ),
              SizedBox(
                height:
                ui.smallSpacing,
              ),
              Text(
                message,
                textAlign:
                TextAlign.center,
                style: TextStyle(
                  fontSize:
                  ui.bodyTextSize,
                  color: const Color(
                    0xFF64748B,
                  ),
                  fontWeight:
                  FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
