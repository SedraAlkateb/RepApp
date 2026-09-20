import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/bloc/edit_brand_plan_bloc.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/widgets/editing_plan_assistant.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/widgets/editing_plan_target.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditingPlan extends StatefulWidget {
  const EditingPlan({
    super.key,
    required this.repPlan,
    required this.repName,
  });

  final int repPlan;
  final String repName;

  @override
  State<EditingPlan> createState() => _EditingPlanState();
}

class _EditingPlanState extends State<EditingPlan>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // استخدام الأسماء العامة الجديدة هنا
  final GlobalKey<EditingPlanTargetState> targetKey = GlobalKey();
  final GlobalKey<EditingPlanAssistantState> assistantKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> onWillPop() async {
    BlocProvider.of<ManageFutureBloc>(context).add(
      AllSeniorRepFutureEvent(
        cityId: context.read<AllCityBloc>().selectedCityId,
      ),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);
    final double tabBarHeight = ui.isMobile
        ? 52
        : ui.isTabletPortrait
        ? 58
        : 54;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                scrolledUnderElevation: 0,
                pinned: true,
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ColorManager.secondaryColor1,
                    size: ui.iconSize,
                  ),
                  onPressed: () {
                    onWillPop();
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  "تعديل أصناف خطة ${widget.repName}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorManager.secondaryColor1,
                    fontWeight: FontWeight.w700,
                    fontSize: ui.cardTitleSize,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ColoredBox(
                  color: const Color(0xFFF8FAFC),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: ui.pageMaxWidth),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          ui.pagePadding,
                          ui.searchTopPadding,
                          ui.pagePadding,
                          ui.searchBottomPadding,
                        ),
                        child: Container(
                          height: tabBarHeight,
                          padding: const EdgeInsets.all(4),
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
                          child: TabBar(
                            controller: _tabController,
                            padding: EdgeInsets.zero,
                            dividerColor: Colors.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.white,
                            unselectedLabelColor: const Color(0xFF94A3B8),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: ui.bodyTextSize,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: ui.bodyTextSize,
                            ),
                            indicator: BoxDecoration(
                              color: ColorManager.secondaryColor1,
                              borderRadius:
                              BorderRadius.circular(ui.cardRadius - 5),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorManager.secondaryColor1
                                      .withOpacity(0.12),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            onTap: (value) {
                              // تم إزالة const من هنا لأن الكلاس غير ثابت
                              BlocProvider.of<EditBrandPlanBloc>(context).add(
                                FutureSearchSpecEvent(""),
                              );

                              if (value == 0) {
                                targetKey.currentState?.clearSearch();
                              } else {
                                assistantKey.currentState?.clearSearch();
                              }

                              BlocProvider.of<EditBrandPlanBloc>(context).add(
                                FutureGetPlanBrandEvent(
                                  Rep(widget.repPlan, value == 0 ? 1 : 2),
                                ),
                              );
                            },
                            tabs: [
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star_outline_rounded,
                                        size: ui.smallIconSize + 2),
                                    SizedBox(width: ui.smallSpacing),
                                    const Flexible(
                                      child: Text('الهدف',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.support_agent_rounded,
                                        size: ui.smallIconSize + 2),
                                    SizedBox(width: ui.smallSpacing),
                                    const Flexible(
                                      child: Text('مساعد',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              EditingPlanTarget(
                key: targetKey,
                repPlan: widget.repPlan,
              ),
              EditingPlanAssistant(
                key: assistantKey,
                repPlan: widget.repPlan,
              ),
            ],
          ),
        ),
      ),
    );
  }
}