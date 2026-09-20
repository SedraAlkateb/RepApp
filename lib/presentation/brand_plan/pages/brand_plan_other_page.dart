// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/uniti/type_style.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/language_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/plan_review/widget/card_hos_doc.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandPlanOtherPage extends StatefulWidget {
  final OtherBrandSpPlanModel otherBrandSpPlanModel;
  final int index1;

  const BrandPlanOtherPage({
    super.key,
    required this.otherBrandSpPlanModel,
    required this.index1,
  });

  @override
  State<BrandPlanOtherPage> createState() =>
      _BrandPlanOtherPageState();
}

class _BrandPlanOtherPageState extends State<BrandPlanOtherPage>
    with AutomaticKeepAliveClientMixin {
  int summ = 0;

  // قائمة مرتبة وقابلة للتعديل للـ brands
  late List<dynamic> _sortedBrands;

  final List<TextEditingController> _controllers = [];
  final TextEditingController _searchController =
  TextEditingController();

  final Map<int, int> _typingVersions = {};
  final Map<int, int> _lastSentAmounts = {};

  String _searchText = '';

  static const Duration _typingDelay =
  Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();

    final brandsList = widget.otherBrandSpPlanModel.brands;
    List<dynamic> targetBrands = [];
    List<dynamic> assistantBrands = [];

    int firstAssistantIndex = brandsList.length;

    // 1. المرور على العناصر، وبما أن الأهداف أولاً، فعند إيجاد أول مساعد نتوقف عن الفحص الفردي
    for (int i = 0; i < brandsList.length; i++) {
      final brand = brandsList[i];
      final type = brand.brandType.name.toString();
      if (type.contains('مساعد')) {
        firstAssistantIndex = i;
        break; // تم العثور على نقطة البداية للمساعدين، لا داعي لإكمال الفحص
      } else {
        targetBrands.add(brand);
      }
    }

    // إضافة باقي العناصر مباشرة كمساعدين دون الحاجة للفحص
    for (int i = firstAssistantIndex; i < brandsList.length; i++) {
      assistantBrands.add(brandsList[i]);
    }

    // دالة مقارنة للترتيب حسب الكمية (amount) تنازلياً، ثم حسب العنوان
    int compareBrands(a, b) {
      int amountComparison = (b.amount as num).compareTo(a.amount as num);
      if (amountComparison != 0) {
        return amountComparison;
      }
      return (a.title ?? '').compareTo(b.title ?? '');
    }

    // 2. ترتيب كل مصفوفة على حدة حسب الكمية
    targetBrands.sort(compareBrands);
    assistantBrands.sort(compareBrands);

    // 3. دمج المصفوفتين بحيث تأتي مصفوفة الهدف أولاً ثم مصفوفة المساعد
    _sortedBrands = [...targetBrands, ...assistantBrands];

    for (int index = 0;
    index < _sortedBrands.length;
    index++) {
      final brand = _sortedBrands[index];

      summ += (brand.amount as num).toInt();

      _controllers.add(
        TextEditingController(
          text: brand.amount == 0
              ? ''
              : brand.amount.toString(),
        ),
      );

      _lastSentAmounts[index] = brand.amount;
    }

    context.read<BrandPlanBloc>().sumS = summ;
  }

  List<int> get _filteredBrandIndexes {
    final query = normalizeText(_searchText.trim());

    if (query.isEmpty) {
      return List<int>.generate(
        _sortedBrands.length,
            (index) => index,
      );
    }

    return [
      for (int index = 0; index < _sortedBrands.length; index++)
        if (normalizeText(_sortedBrands[index].title).contains(query))
          index,
    ];
  }

  int _parseAmount(String value) {
    final cleanValue = value.trim();

    if (cleanValue.isEmpty) {
      return 0;
    }

    final englishValue =
    convertArabicNumberToEnglish(cleanValue);

    return int.tryParse(englishValue) ?? 0;
  }

  void _sendAmountOnce(int index, int amount) {
    if (!mounted) return;

    if (_lastSentAmounts[index] == amount) {
      return;
    }

    _lastSentAmounts[index] = amount;

    context.read<BrandPlanBloc>().add(
      ChangeFieldEvent(
        amount,
        widget.index1,
        index,
        widget.otherBrandSpPlanModel.brandm,
      ),
    );
  }

  void _sendAfterTypingStops(
      int index,
      String value,
      ) async {
    final currentVersion =
        (_typingVersions[index] ?? 0) + 1;

    _typingVersions[index] = currentVersion;

    await Future<void>.delayed(_typingDelay);

    if (!mounted) return;

    if (_typingVersions[index] != currentVersion) {
      return;
    }

    _sendAmountOnce(
      index,
      _parseAmount(value),
    );
  }

  void _finishEditing(int index) {
    if (!mounted) return;

    _typingVersions[index] =
        (_typingVersions[index] ?? 0) + 1;

    final controller = _controllers[index];

    if (controller.text.trim().isEmpty) {
      controller.value = const TextEditingValue(
        text: '0',
        selection: TextSelection.collapsed(offset: 1),
      );
    }

    _sendAmountOnce(
      index,
      _parseAmount(controller.text),
    );
  }

  void _clearSearch() {
    _searchController.clear();

    setState(() {
      _searchText = '';
    });
  }

  @override
  void dispose() {
    _searchController.dispose();

    for (final controller in _controllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ui = AppUi.of(context);

    final double contentMaxWidth =
    ui.isTabletLandscape
        ? 760
        : ui.pageMaxWidth;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.otherBrandSpPlanModel.specModel.title,
          style: TextStyle(
            fontSize: ui.isMobile ? 18 : 20,
          ),
        ),
      ),
      body: BlocConsumer<BrandPlanBloc, BrandPlanState>(
        listenWhen: (previous, current) {
          return current is SumErrorState;
        },
        listener: (context, state) {
          if (state is SumErrorState) {
            errorWithoutPop(
              context,
              state.failure.massage,
              state.failure.code,
            );

            context.read<BrandPlanBloc>().add(
              UpdateEvent(),
            );
          }
        },
        buildWhen: (previous, current) => false,
        builder: (context, state) {
          final brands = _sortedBrands;

          if (brands.isEmpty) {
            return emptyFullScreen(context);
          }

          final filteredIndexes =
              _filteredBrandIndexes;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth:
                contentMaxWidth,
              ),
              child: CustomScrollView(
                physics:
                const BouncingScrollPhysics(),
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior
                    .onDrag,
                slivers: [
                  // ===============================
                  // Summary
                  // ===============================
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                      EdgeInsets.all(
                        ui.pagePadding,
                      ),
                      child:
                      buildSampleStatisticsSummaryCard(
                        BrandAmountModel(
                          widget.otherBrandSpPlanModel
                              .specModel.sumDoctor,
                          widget.otherBrandSpPlanModel
                              .specModel.sumHospital,
                          widget.otherBrandSpPlanModel
                              .specModel.sumDoctor +
                              widget.otherBrandSpPlanModel
                                  .specModel.sumHospital,
                        ),
                        UserInfo.samplesCount,
                        repPlanId:
                        UserInfo.activePlanId,
                        spId:
                        widget.otherBrandSpPlanModel
                            .specModel.id,
                      ),
                    ),
                  ),

                  // ===============================
                  // Search
                  // ===============================
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(
                        horizontal:
                        ui.pagePadding,
                      ),
                      child: TextField(
                        controller:
                        _searchController,
                        decoration:
                        InputDecoration(
                          hintText:
                          'البحث باسم العينة',
                          prefixIcon:
                          const Icon(
                            Icons.search,
                          ),
                          suffixIcon:
                          _searchText.isEmpty
                              ? null
                              : IconButton(
                            onPressed:
                            _clearSearch,
                            icon:
                            const Icon(
                              Icons.close,
                            ),
                          ),
                          border:
                          const OutlineInputBorder(),
                          contentPadding:
                          EdgeInsets.symmetric(
                            vertical: ui.isMobile ? 10 : 12,
                            horizontal:
                            ui.mediumSpacing,
                          ),
                        ),
                        onChanged:
                            (value) {
                          setState(() {
                            _searchText =
                                value;
                          });
                        },
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height:
                      ui.sectionSpacing,
                    ),
                  ),

                  // ===============================
                  // Empty Search
                  // ===============================
                  if (filteredIndexes.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child:
                      emptyFullScreen(
                        context,
                      ),
                    )
                  else
                  // ===============================
                  // Brands
                  // ===============================
                    SliverPadding(
                      padding:
                      EdgeInsets.symmetric(
                        horizontal:
                        ui.pagePadding,
                      ),
                      sliver:
                      SliverList.builder(
                        itemCount:
                        filteredIndexes.length,
                        itemBuilder:
                            (context, index) {
                          final realIndex =
                          filteredIndexes[index];
                          final brandItem =
                          brands[realIndex];

                          return _buildBrandOtherCard(
                            context,
                            ui,
                            brandItem,
                            realIndex,
                          );
                        },
                      ),
                    ),

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height:
                      ui.listBottomPadding,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBrandOtherCard(
      BuildContext context,
      AppUi ui,
      dynamic brandItem,
      int index,
      ) {
    return Container(
      margin: EdgeInsets.all(
        ui.smallSpacing,
      ),
      padding: EdgeInsets.all(
        ui.cardPadding,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorManager
                .secondaryColor
                .withOpacity(0.05),
            blurRadius: 4,
          ),
        ],
        color: ColorManager.white,
        border: Border.all(
          color: ColorManager
              .secondaryColor7,
        ),
        borderRadius:
        BorderRadius.circular(
          ui.smallRadius,
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment
            .start,
        children: [
          Row(
            children: [
              Icon(
                Icons
                    .medication_outlined,
                color: ColorManager
                    .secondaryColor4,
                size: ui.smallIconSize + 3,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  'العينة : ${brandItem.title}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: ui.bodyTextSize) ??
                      TextStyle(fontSize: ui.bodyTextSize),
                  overflow:
                  TextOverflow
                      .ellipsis,
                ),
              ),
              TypeBadge(
                brandItem.brandType,
              ),
            ],
          ),
          Divider(
            color: ColorManager
                .secondaryColor7,
          ),
          Row(
            children: [
              Icon(
                Icons
                    .medical_information_outlined,
                color: ColorManager
                    .secondaryColor4,
                size: ui.smallIconSize + 3,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  'الشكل الصيدلاني: ${brandItem.phTitle}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: ui.bodyTextSize) ??
                      TextStyle(fontSize: ui.bodyTextSize),
                ),
              ),
            ],
          ),
          Divider(
            color: ColorManager
                .secondaryColor7,
          ),
          Row(
            children: [
              Text(
                'العدد ',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: ui.bodyTextSize) ??
                    TextStyle(fontSize: ui.bodyTextSize),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Focus(
                  onFocusChange:
                      (hasFocus) {
                    if (!hasFocus) {
                      _finishEditing(
                        index,
                      );
                    }
                  },
                  child:
                  TextFormField(
                    controller:
                    _controllers[
                    index],
                    enabled: UserInfo
                        .otherstatus ==
                        0,
                    keyboardType:
                    TextInputType
                        .number,
                    textInputAction:
                    TextInputAction
                        .done,
                    decoration:
                    const InputDecoration(
                      border:
                      OutlineInputBorder(),
                      contentPadding:
                      EdgeInsets
                          .symmetric(
                        vertical: 8,
                        horizontal:
                        10,
                      ),
                    ),
                    onChanged:
                        (value) {
                      _sendAfterTypingStops(
                        index,
                        value,
                      );
                    },
                    onFieldSubmitted:
                        (_) {
                      _finishEditing(
                        index,
                      );
                    },
                    onTapOutside: (_) {
                      FocusManager
                          .instance
                          .primaryFocus
                          ?.unfocus();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}