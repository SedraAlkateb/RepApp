import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/language_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/senior/plan_review/widget/card_hos_doc.dart';
import 'package:domina_app/presentation/senior/plan_review/widget/card_tar_ass.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepPlanBrandSpPage extends StatefulWidget {
  const RepPlanBrandSpPage({
    super.key,
    required this.title,
    this.flag,
    this.percent,
    this.isRep,
    this.sampleCount,
    this.repPlanId,
    this.spId,
  });

  final String title;
  final int? flag;
  final int? percent;
  final int? sampleCount;
  final bool? isRep;
  final int? spId;
  final int? repPlanId;
  @override
  State<RepPlanBrandSpPage> createState() => _RepPlanBrandSpPageState();
}

class _RepPlanBrandSpPageState extends State<RepPlanBrandSpPage>
    with AutomaticKeepAliveClientMixin {
  List<PlanBrandSp> planBrandsp = [];
  BrandAmountModel brandAmount = BrandAmountModel(0, 0, 0);
  SumBrandAmountModel sumTargetAss = SumBrandAmountModel(0, 0, 0);
  final TextEditingController searchController = TextEditingController();

  // الربط بواسطة item.id بدلاً من index لتفادي مشاكل الفلترة والبحث
  final Map<int, TextEditingController> amountControllers = {};

  @override
  void dispose() {
    searchController.dispose();
    for (final controller in amountControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ui = AppUi.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        BlocProvider.of<FutureRepBloc>(context).add(UpdateAmountEvent());
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                scrolledUnderElevation: 1,
                surfaceTintColor: Colors.transparent,
                title: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: const Color(0xFFF8FAFC),
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
                        child: SearchField(
                          searchController: searchController,
                          onPressed: (value) {
                            BlocProvider.of<FutureRepBloc>(context).add(
                              SearchPlanBrandsEvent(value),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ui.pageMaxWidth,
              ),
              child: BlocConsumer<FutureRepBloc, FutureRepState>(
                listener: (context, state) {
                  if (state is FutureRepPlanBrandSpErrorState) {
                    error(context, state.failure.massage, state.failure.code);
                  }
                  if (state is SumErrorState) {
                    error(context, state.failure.massage, state.failure.code);
                  }
                  if (state is FutureSpRepErrorState) {
                    error(context, state.failure.massage, state.failure.code);
                  }
                  if (state is UpdateAmountLoadingState) {
                    loading(context);
                  } else if (state is ISEmptyState) {
                    Navigator.pop(context);
                  } else if (state is UpdateAmountState) {

                    success(context);
                 Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is FutureRepPlanBrandSpState) {
                    planBrandsp = state.planBrandSp;
                    brandAmount = state.brandAmountModel;
                    sumTargetAss = state.sum;
                  }
                  if (state is AmountState) {
                    sumTargetAss = SumBrandAmountModel(
                      state.targetAmount,
                      state.assistantAmount,
                      state.totalAmount,
                    );
                  }
                  if (state is FutureRepPlanBrandSpLoadingState) {
                    return loadingFullScreen(context);
                  }
                  if (state is FutureRepPlanBrandSpEmptyState) {
                    return emptyFullScreen(context);
                  }

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.manual,
                    padding: EdgeInsets.fromLTRB(
                      ui.pagePadding,
                      ui.listTopPadding + 8,
                      ui.pagePadding,
                      ui.pageBottomPadding + 90,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        widget.isRep == true
                            ? buildSampleStatisticsSummaryCard(
                                brandAmount, widget.sampleCount ?? 1,
                                spId: widget.spId ?? 0,
                                repPlanId: widget.repPlanId ?? 0)
                            : const SizedBox(),
                        buildSampleStatisticsTypeSummaryCard(
                          sumTargetAss,
                          widget.sampleCount ?? 1,
                        ),
                        SizedBox(height: ui.sectionSpacing),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: planBrandsp.length,
                          itemBuilder: (context, index) {
                            return _buildModernCard(context, index, state);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernCard(
    BuildContext context,
    int index,
    FutureRepState state,
  ) {
    final ui = AppUi.of(context);
    final PlanBrandSp item = planBrandsp[index];

    // ✅ ربط الحقل بـ item.id لضمان بقاء النتيجة صحيحة حتى عند البحث والفلترة
    final TextEditingController amountController =
        amountControllers.putIfAbsent(
      item.id,
      () => TextEditingController(text: item.totalAmount.toString()),
    );

    // تحديث نص الحقل إذا تغيرت القيمة برمجياً
    if (amountController.text != item.totalAmount.toString()) {
      amountController.text = item.totalAmount.toString();
      amountController.selection = TextSelection.fromPosition(
        TextPosition(offset: amountController.text.length),
      );
    }

    final bool isEditable = widget.flag == UserInfo.statusPlan;

    return Padding(
      padding: EdgeInsets.only(bottom: ui.cardSpacing),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ui.cardRadius),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.025),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                ui.cardPadding,
                ui.cardPadding,
                ui.cardPadding + 5,
                ui.cardPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: ui.iconBoxSize,
                        height: ui.iconBoxSize,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: item.brandType.color.withOpacity(0.08),
                          borderRadius:
                              BorderRadius.circular(ui.smallRadius + 2),
                        ),
                        child: Icon(
                          Icons.medication_rounded,
                          color: item.brandType.color,
                          size: ui.iconSize,
                        ),
                      ),
                      SizedBox(width: ui.sectionSpacing),
                      Expanded(
                        child: Text(
                          item.titleAr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ui.cardTitleSize,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.secondaryColor1,
                            height: 1.3,
                          ),
                        ),
                      ),
                      SizedBox(width: ui.mediumSpacing),
                      Type.buildBadge(item.brandType),
                    ],
                  ),
                  SizedBox(height: ui.sectionSpacing),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ui.mediumSpacing,
                      vertical: ui.smallSpacing + 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(ui.smallRadius),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: ui.smallIconSize,
                          color: const Color(0xFF94A3B8),
                        ),
                        SizedBox(width: ui.smallSpacing),
                        Expanded(
                          child: Text(
                            "الشكل الصيدلاني: ${item.phTitle}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: const Color(0xFF64748B),
                              fontSize: ui.bodyTextSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ui.sectionSpacing),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF1F5F9),
                  ),
                  SizedBox(height: ui.sectionSpacing),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "العدد المطلوب",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: ui.bodyTextSize,
                                color: const Color(0xFF334155),
                              ),
                            ),
                            SizedBox(height: ui.smallSpacing),
                            Text(
                              isEditable
                                  ? "يمكن تعديل الكمية"
                                  : "الكمية للعرض فقط",
                              style: TextStyle(
                                fontSize: ui.smallTextSize,
                                color: const Color(0xFF94A3B8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: ui.sectionSpacing),
                      SizedBox(
                        width: ui.isMobile ? 92 : 110,
                        height: ui.isMobile ? 42 : 46,
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          enabled: isEditable,
                          onChanged: (value) {
                            // تحويل الأرقام العربية إلى إنجليزية، وإذا كان فارغاً نعتبره "0"
                            String v = value.isNotEmpty
                                ? convertArabicNumberToEnglish(value)
                                : "0";

                            int parsedValue = int.tryParse(v) ?? 0;

                            // ✅ إرسال القيمة (سواء رقم مدخل أو 0) للـ Bloc مباشرة
                            BlocProvider.of<FutureRepBloc>(context).add(
                              ChangeFieldEvent(
                                parsedValue,
                                item.id,
                              ),
                            );
                          },
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: ui.bodyTextSize + 1,
                            color: isEditable
                                ? item.brandType.color
                                : const Color(0xFF94A3B8),
                          ),
                          decoration: InputDecoration(
                            hintText: null,
                            filled: true,
                            fillColor: isEditable
                                ? item.brandType.color.withOpacity(0.055)
                                : const Color(0xFFF8FAFC),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: ui.smallSpacing,
                              vertical: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(ui.smallRadius),
                              borderSide: BorderSide(
                                color: item.brandType.color.withOpacity(0.22),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(ui.smallRadius),
                              borderSide: BorderSide(
                                color: item.brandType.color,
                                width: 1.5,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(ui.smallRadius),
                              borderSide: const BorderSide(
                                color: Color(0xFFE2E8F0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              child: Container(
                width: 5,
                color: item.brandType.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
