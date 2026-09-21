// ignore_for_file: must_be_immutable

import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/bloc/edit_brand_plan_bloc.dart';
import 'package:domina_app/presentation/uniti/custom_dropdown.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EditingPlanTarget extends StatefulWidget {
  const EditingPlanTarget({
    super.key,
    required this.repPlan,
  });

  final int repPlan;

  @override
  State<EditingPlanTarget> createState() => EditingPlanTargetState();
}

// أصبحت عامة بدون شرطة سفلية
class EditingPlanTargetState extends State<EditingPlanTarget>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();

  void clearSearch() {
    if (searchController.text.isNotEmpty) {
      searchController.clear();
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ui = AppUi.of(context);

    return ColoredBox(
      color: Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ui.pageMaxWidth),
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
                  searchController: searchController,
                  onPressed: (value) {
                    BlocProvider.of<EditBrandPlanBloc>(context).add(
                      FutureSearchSpecEvent(value),
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<EditBrandPlanBloc, EditBrandPlanState>(
                  builder: (context, state) {
                    List<PlanBrandModel> planBrand =
                        context.watch<EditBrandPlanBloc>().planBrands;

                    if (state is FuturePlanBrandState) {
                      planBrand = state.planbrand;
                    }
                    if (state is FutureSpRepLoadingState) {
                      return loadingFullScreen(context);
                    }
                    if (state is FutureSpRepErrorState) {
                      return errorFullScreen(context, func: () {});
                    }
                    if (planBrand.isEmpty) {
                      return emptyFullScreen(context);
                    }

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.fromLTRB(
                        ui.pagePadding,
                        ui.listTopPadding,
                        ui.pagePadding,
                        ui.listBottomPadding + 24,
                      ),
                      itemCount: planBrand.length,
                      itemBuilder: (context, index) {
                        return _buildElegantCard(context, index, planBrand);
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

  Widget _buildElegantCard(
      BuildContext context,
      int index,
      List<PlanBrandModel> planBrand,
      ) {
    final ui = AppUi.of(context);
    final PlanBrandModel item = planBrand[index];
    final int brandTypeId = item.brandType.i;
    String brandTypeHintText = "غير محدد";

    for (final type in brandType) {
      if (type.i == brandTypeId) {
        brandTypeHintText = type.name;
        break;
      }
    }

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
        child: Padding(
          padding: EdgeInsets.all(ui.cardPadding),
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
                      color: ColorManager.secondaryColor1.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(ui.smallRadius + 2),
                    ),
                    child: Icon(
                      Icons.medication_liquid_rounded,
                      color: ColorManager.secondaryColor1,
                      size: ui.iconSize,
                    ),
                  ),
                  SizedBox(width: ui.sectionSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: ui.cardTitleSize,
                            color: const Color(0xFF1E293B),
                            height: 1.25,
                          ),
                        ),
                        SizedBox(height: ui.smallSpacing),
                        Row(
                          children: [
                            Icon(
                              Icons.category_outlined,
                              size: ui.smallIconSize,
                              color: const Color(0xFF94A3B8),
                            ),
                            SizedBox(width: ui.smallSpacing),
                            Expanded(
                              child: Text(
                                item.pharmaceuticalForm,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: const Color(0xFF64748B),
                                  fontSize: ui.smallTextSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: ui.sectionSpacing),
              const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
              SizedBox(height: ui.sectionSpacing),
              Row(
                children: [
                  Container(
                    width: ui.smallIconSize + 12,
                    height: ui.smallIconSize + 12,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorManager.secondaryColor1.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(ui.smallRadius),
                    ),
                    child: Icon(
                      Icons.tune_rounded,
                      size: ui.smallIconSize,
                      color: ColorManager.secondaryColor1,
                    ),
                  ),
                  SizedBox(width: ui.mediumSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "الشكل الصيدلاني",
                          style: TextStyle(
                            fontSize: ui.bodyTextSize,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "اختر التصنيف المناسب للصنف",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ui.smallTextSize,
                            color: const Color(0xFF94A3B8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: ui.mediumSpacing),
              BlocConsumer<EditBrandPlanBloc, EditBrandPlanState>(
                listener: (context, state) {
                  if (state is FutureChangePlanBrandTypeErrorState) {
                    error(context, state.failure.massage, state.failure.code);
                  }
                },
                builder: (context, state) {
                  if (state is FutureChangeLoadingItemValueState &&
                      state.index == index) {
                    return Container(
                      height: ui.isMobile ? 46 : 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius:
                        BorderRadius.circular(ui.smallRadius + 2),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: SpinKitThreeBounce(
                        color: ColorManager.secondaryColor1,
                        size: ui.isMobile ? 18 : 20,
                      ),
                    );
                  }

                  return CustomDropDown(
                    hintText: brandTypeHintText,
                    items: brandType,
                    prefixIcon: null,
                    onChanged: (value) {
                      BlocProvider.of<EditBrandPlanBloc>(context).add(
                        FutureChangePlanBrandTypeEvent(item.id, value.i),
                      );
                      item.brandType.i = value.i;
                      BlocProvider.of<EditBrandPlanBloc>(context).add(
                        FutureChangeLoadingItemValueEvent(index),
                      );
                    },
                    validator: (value) => null,
                    errorText: '',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}