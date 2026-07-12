// ignore_for_file: must_be_immutable
import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/senior/manage_future/widget/status_plan_widget.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/basic/spec_grid_widget.dart'; // الـ Widget المطلوب استخدامه
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FutureSpecializationsPage extends StatefulWidget {
  FutureSpecializationsPage({
    super.key,
    required this.id,
    required this.repPlanId,
    required this.flag,
    required this.sampleCount,
    required this.repName,
    required this.repType
  });
  final String repName;
  final int id;
  final int repPlanId;
  final FlagModel flag;
  final int sampleCount;
  final RepType repType;
  @override
  State<FutureSpecializationsPage> createState() => _FutureSpecializationsPageState();
}

class _FutureSpecializationsPageState extends State<FutureSpecializationsPage> {
  final TextEditingController searchController = TextEditingController();
@override
  void initState() {
  BlocProvider.of<FutureRepBloc>(context).add(FutureSpEvent(widget.id));

  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // تحديد ما إذا كان الجهاز تابلت
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    Future<bool> onWillPop() async {
      BlocProvider.of<ManageFutureBloc>(context).add(AllSeniorRepFutureEvent());
      return true;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: ColorManager.background, // تغيير الخلفية لتطابق الصفحة المطلوبة
        appBar: AppBar(
          title: Text(
            'اختصاصات ${widget.repName}',
          ),
        ),
        floatingActionButton: BlocConsumer<FutureRepBloc, FutureRepState>(
          listener: (context, state) {
            if (state is EditeStatusLoadingState) {
              loading(context);
            } else if (state is EditeStatusFailureState) {
              error(context, state.failure.massage, state.failure.code);
            } else if (state is EditeStatusState) {
              BlocProvider.of<ManageFutureBloc>(context).add(AllSeniorRepFutureEvent());
              success(context);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return FloatingActionButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              onPressed: () => showStatusBottomSheet(context,widget.repType.i,widget.repPlanId),
              backgroundColor: ColorManager.secondaryColor1,
              child: Icon(Icons.check, color: ColorManager.white),
            );
          },
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            // حساب عدد الأعمدة بناءً على نوع الجهاز والوضعية
            int crossAxisCount;
            if (isTablet) {
              crossAxisCount = orientation == Orientation.landscape ? 4 : 3;
            } else {
              crossAxisCount = orientation == Orientation.landscape ? 3 : 2;
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 30.w : 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    SearchField(
                      searchController: searchController,
                      onPressed: (value) {
                        BlocProvider.of<FutureRepBloc>(context).add(FutureSearchSpecEvent(value));
                      },
                    ),
                    BlocBuilder<FutureRepBloc, FutureRepState>(
                      builder: (context, state) {
                        List<SpecDModel> spModel = context.watch<FutureRepBloc>().specialization;

                        if (state is FutureSpRepState) {
                          spModel = state.Specs;
                        }

                        if (state is FutureSpRepLoadingState) {
                          return Padding(
                            padding: EdgeInsets.only(top: 100.h),
                            child: loadingFullScreen(context),
                          );
                        }

                        if (state is FutureSpRepErrorState) {
                          return errorFullScreen(
                            context,
                            mes: state.failure.massage,
                            func: () => BlocProvider.of<FutureRepBloc>(context).add(FutureSpEvent(widget.id)),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          child: SpecGridWidget(
                            items: spModel,
                            crossAxisCount: crossAxisCount,
                            onTap: (model) {
                              iniFutureModule();
                              BlocProvider.of<FutureRepBloc>(context).add(
                                FutureRepPlanBrandSpEvent(
                                  RepSp(widget.repPlanId, model.id, widget.id),
                                  widget.sampleCount,
                                ),
                              );

                              Navigator.pushNamed(
                                context,
                                Routes.RepPlanBrandSp,
                                arguments: {
                                  'title': model.title,
                                  'flag': widget.flag.flag,
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // دالة منفصلة لعرض الـ Bottom Sheet للحفاظ على نظافة الكود

}