// ignore_for_file: must_be_immutable

import 'package:domina_app/presentation/uniti/animation/pressable_effect.dart';
import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/uniti/type_style.dart';
import 'package:domina_app/presentation/resources/flag_color.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/bloc/edit_brand_plan_bloc.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/page/auditing_plan.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/senior/manage_future/widget/drop_down_change_plan.dart';
import 'package:domina_app/presentation/senior/places/widget/city_filter_search_widget.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/senior/plan_review/page/plan_sp_br.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllRepWithFuture extends StatefulWidget {
  const AllRepWithFuture({
    super.key,
  });

  @override
  State<AllRepWithFuture> createState() => _AllRepWithFutureState();
}

class _AllRepWithFutureState extends State<AllRepWithFuture>
    with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();

  // يمنع تحميل نفس المحافظة مرتين
  int? _lastLoadedCityId;

  Widget buildDateTimeCard({
    required BuildContext context,
    required AppUi ui,
    required String dateTime,
  }) {
    if (dateTime.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        ui.pagePadding,
        ui.searchTopPadding,
        ui.pagePadding,
        ui.searchBottomPadding,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: ui.cardPadding,
          vertical: ui.mediumSpacing,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(
            ui.cardRadius,
          ),
          border: Border.all(
            color: const Color(0xFFBFDBFE),
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A1E3A5F),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: ui.iconBoxSize,
              height: ui.iconBoxSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFDBEAFE),
                borderRadius: BorderRadius.circular(
                  ui.smallRadius + 2,
                ),
              ),
              child: Icon(
                Icons.calendar_month_rounded,
                size: ui.smallIconSize + 4,
                color: const Color(0xFF2563EB),
              ),
            ),
            SizedBox(
              width: ui.mediumSpacing,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'التاريخ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ui.smallTextSize,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  SizedBox(
                    height: ui.smallSpacing / 2,
                  ),
                  Text(
                    dateTime,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ui.bodyTextSize + 1,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        _loadSelectedCity();
      },
    );
  }

  void _loadSelectedCity({
    bool force = false,
  }) {
    if (!mounted) {
      return;
    }

    final cityBloc = context.read<AllCityBloc>();
    final int? cityId = cityBloc.selectedCityId;

    if (cityId == null || cityId < 0) {
      return;
    }

    if (!force && _lastLoadedCityId == cityId) {
      return;
    }

    _lastLoadedCityId = cityId;
    searchController.clear();

    context.read<ManageFutureBloc>().add(
      AllSeniorRepFutureEvent(
        cityId: cityId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);
    final cityBloc = context.watch<AllCityBloc>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          " إدارة الخطة المستقبلية (${cityBloc.selectedCity?.title ?? ""})",
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return RefreshIndicator(
              color: ColorManager.secondaryColor1,
              onRefresh: () async {
                BlocProvider.of<ManageFutureBloc>(context).add(
                  AllSeniorRepFutureEvent(
                    cityId: context.read<AllCityBloc>().selectedCityId,
                  ),
                );
                // انتظار قصير لضمان سلاسة حركة الـ RefreshIndicator
                await Future.delayed(const Duration(milliseconds: 500));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: ui.pageMaxWidth,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          buildDateTimeCard(
                            context: context,
                            ui: ui,
                            dateTime:
                            context.read<ManageFutureBloc>().dateTime,
                          ),
                          BlocListener<AllCityBloc, AllCityState>(
                            listener: (context, state) {
                              if (state is GetAllCityState) {
                                _loadSelectedCity();
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                ui.pagePadding,
                                ui.searchTopPadding,
                                ui.pagePadding,
                                ui.searchBottomPadding,
                              ),
                              child: SearchWithCityFilter(
                                searchController: searchController,
                                onSearch: (value) {
                                  BlocProvider.of<ManageFutureBloc>(context).add(
                                    SenSearchRepFutureEvent(value),
                                  );
                                },
                              ),
                            ),
                          ),
                          BlocBuilder<ManageFutureBloc, ManageFutureState>(
                            builder: (context, state) {
                              List<AllRepresentativeFuture> allRepresentative =
                                  context
                                      .watch<ManageFutureBloc>()
                                      .allRepresentativeSearch;
                              if (state is AllSeniorRepState) {
                                allRepresentative = state.representatives;
                              }
                              if (state is ChangPlanStatusState) {
                                allRepresentative = state.representatives;
                              }

                              if (state is AllSeniorRepLoadingState) {
                                return SizedBox(
                                  height: (constraints.maxHeight - 200)
                                      .clamp(250, double.infinity),
                                  child: Center(
                                    child: _buildLoadingState(context),
                                  ),
                                );
                              }

                              if (state is AllSeniorRepErrorState) {
                                return SizedBox(
                                  height: (constraints.maxHeight - 200)
                                      .clamp(250, double.infinity),
                                  child: Center(
                                    child: errorFullScreen(
                                      context,
                                      func: () {
                                        BlocProvider.of<ManageFutureBloc>(
                                          context,
                                        ).add(
                                          AllSeniorRepFutureEvent(
                                            cityId: context
                                                .read<AllCityBloc>()
                                                .cities[0]
                                                .id,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }

                              if (allRepresentative.isEmpty) {
                                return SizedBox(
                                  height: (constraints.maxHeight - 200)
                                      .clamp(250, double.infinity),
                                  child: Center(
                                    child: _buildEmptyState(context),
                                  ),
                                );
                              }

                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                  ui.pagePadding,
                                  ui.listTopPadding,
                                  ui.pagePadding,
                                  ui.listBottomPadding,
                                ),
                                child: Column(
                                  children: List.generate(
                                    allRepresentative.length,
                                        (index) => Padding(
                                      padding: EdgeInsets.only(
                                        bottom: ui.cardSpacing,
                                      ),
                                      child: _buildRepItem(
                                        context,
                                        allRepresentative[index],
                                        index,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRepItem(
      BuildContext context,
      AllRepresentativeFuture rep,
      int index,
      ) {
    final ui = AppUi.of(context);
    final bool isSelected = _lastLoadedCityId == index;

    return PressableEffect(child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _lastLoadedCityId = isSelected ? -1 : index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.all(ui.cardPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ui.cardRadius),
          border: Border.all(
            color: isSelected
                ? ColorManager.secondaryColor1
                : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? ColorManager.secondaryColor1.withOpacity(0.065)
                  : Colors.black.withOpacity(0.025),
              blurRadius: isSelected ? 16 : 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedRotation(
                  turns: isSelected ? 0 : 0.5,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: ui.iconBoxSize - 4,
                    height: ui.iconBoxSize - 4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorManager.secondaryColor1
                          : ColorManager.secondaryColor1.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(ui.smallRadius + 2),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: isSelected
                          ? Colors.white
                          : ColorManager.secondaryColor1,
                      size: ui.iconSize,
                    ),
                  ),
                ),
                SizedBox(width: ui.sectionSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rep.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFF1E293B),
                          fontSize: ui.cardTitleSize,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                      SizedBox(height: ui.smallSpacing),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: rep.reptype.color.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(ui.smallRadius),
                            border: Border.all(
                              color: rep.reptype.color.withOpacity(0.16),
                            ),
                          ),
                          child: Text(
                            rep.reptype.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: const Color(0xFF475569),
                              fontSize: ui.smallTextSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: ui.mediumSpacing),
                _buildPulseDot(context, rep.flag.flag, rep.reptype),
              ],
            ),
            SizedBox(height: ui.sectionSpacing + 2),
            DropDownChangePlan(
              key: ValueKey('rep_${rep.id}_status_${rep.flag.flag}'),
              hintText: rep.flag.name,
              items: getAllFlags(rep.reptype.i),
              statusColor: getColor(rep.flag.flag),
              onChanged: (x) {
                final FlagModel xx = x as FlagModel;
                BlocProvider.of<ManageFutureBloc>(context).add(
                  ChangPlanStatusEvent(
                    rep.activePlan,
                    xx.flag,
                    index,
                    rep.id,
                  ),
                );
              },
              errorText: "",
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 260),
              curve: Curves.fastOutSlowIn,
              alignment: Alignment.topCenter,
              child: !isSelected
                  ? const SizedBox.shrink()
                  : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: ui.sectionSpacing,
                    ),
                    child: const Divider(
                      color: Color(0xFFF1F5F9),
                      thickness: 1,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMicroActionButton(
                          context: context,
                          title: "تدقيق الخطة",
                          subtitle: "مراجعة شاملة",
                          icon: Icons.fact_check_rounded,
                          isActive:
                          rep.flag.flag == UserInfo.statusPlan,
                          color: ColorManager.secondaryColor1,
                          onTap: () => _handleAuditing(rep),
                        ),
                      ),
                      SizedBox(width: ui.mediumSpacing),
                      Expanded(
                        child: _buildMicroActionButton(
                          context: context,
                          title: "الأصناف",
                          subtitle: "تعديل القائمة",
                          icon: Icons.auto_awesome_motion_rounded,
                          isActive:
                          rep.flag.flag == UserInfo.statusPlan,
                          color: const Color(0xFF3F7FBF),
                          onTap: () => _handleEditBrands(rep),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildMicroActionButton({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isActive,
    required Color color,
    required VoidCallback onTap,
  }) {
    final ui = AppUi.of(context);

    return Material(
      color: Colors.transparent,
      child: AppInkWell(
        onTap: isActive ? onTap : null,
        borderRadius: BorderRadius.circular(ui.cardRadius - 2),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(
            horizontal: ui.mediumSpacing,
            vertical: ui.sectionSpacing,
          ),
          decoration: BoxDecoration(
            color: isActive ? color.withOpacity(0.05) : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(ui.cardRadius - 2),
            border: Border.all(
              color: isActive ? color.withOpacity(0.24) : const Color(0xFFE2E8F0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: ui.iconBoxSize - 6,
                height: ui.iconBoxSize - 6,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isActive ? color.withOpacity(0.09) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(ui.smallRadius + 2),
                ),
                child: Icon(
                  icon,
                  color: isActive ? color : const Color(0xFF94A3B8),
                  size: ui.iconSize,
                ),
              ),
              SizedBox(height: ui.smallSpacing + 2),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isActive ? color : const Color(0xFF94A3B8),
                  fontWeight: FontWeight.w700,
                  fontSize: ui.bodyTextSize,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF94A3B8),
                  fontSize: ui.smallTextSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPulseDot(
      BuildContext context,
      int flag,
      RepType repType,
      ) {
    final ui = AppUi.of(context);
    final double dotSize = ui.isMobile ? 10 : 11;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.4, end: 1),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getColor(flag),
            boxShadow: [
              BoxShadow(
                color: repType.color.withOpacity(0.45),
                blurRadius: 10 * (1 - value),
                spreadRadius: 4 * (1 - value),
              ),
            ],
          ),
        );
      },
      onEnd: () {},
    );
  }

  void _handleAuditing(AllRepresentativeFuture rep) {
    iniFutureModule();

    if (rep.reptype.i == 7) {
      initActivePlanModule();
      Navigator.push(
        context,
        _createRoute(
          PlanSpBr(
            id: rep.id,
            repPlanId: rep.activePlan,
            flag: rep.flag,
            sampleCount: rep.samplesCount,
            repName: rep.name,
            repType: rep.reptype,
          ),
        ),
      );
    } else {
      BlocProvider.of<FutureRepBloc>(context).add(
        FutureRepPlanBrandSpEvent(
          RepSp(rep.activePlan, 38, rep.id),
          rep.samplesCount,

        ),
      );

      Navigator.pushNamed(
        context,
        Routes.RepPlanBrandSp,
        arguments: {
          'title': "كل الاختصاصات",
          'flag': rep.flag.flag,
        },
      );
    }
  }

  void _handleEditBrands(AllRepresentativeFuture rep) {
    iniEditBrandPlanModule();

    BlocProvider.of<EditBrandPlanBloc>(context).add(
      FutureGetPlanBrandEvent(
        Rep(rep.activePlan, 1),
      ),
    );

    Navigator.push(
      context,
      _createRoute(
        EditingPlan(
          repPlan: rep.activePlan,
          repName: rep.name,
        ),
      ),
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.easeOutQuart;

        final tween = Tween<Offset>(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    final ui = AppUi.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ui.pagePadding),
      child: loadingShimmer(
        context,
        5,
        100,
        20,
        BorderRadius.circular(ui.cardRadius),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final ui = AppUi.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(ui.pagePadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: ui.iconBoxSize + 20,
              height: ui.iconBoxSize + 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorManager.secondaryColor1.withOpacity(0.07),
                borderRadius: BorderRadius.circular(ui.cardRadius),
              ),
              child: Icon(
                Icons.manage_accounts_outlined,
                size: ui.iconSize + 10,
                color: ColorManager.secondaryColor1.withOpacity(0.7),
              ),
            ),
            SizedBox(height: ui.sectionSpacing),
            Text(
              "لا يوجد مندوبون حالياً",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ui.cardTitleSize,
                color: const Color(0xFF334155),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: ui.smallSpacing),
            Text(
              "ستظهر بيانات المندوبين هنا عند توفرها",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ui.smallTextSize,
                color: const Color(0xFF94A3B8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}