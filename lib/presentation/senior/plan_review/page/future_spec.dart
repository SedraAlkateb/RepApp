import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FutureSpecializationsPage extends StatelessWidget {
  FutureSpecializationsPage({
    super.key,
    required this.id,
    required this.repPlanId,
    required this.flag,
    required this.sampleCount,
  });
  final int id;
  final int repPlanId;
  final FlagModel flag;
  final int sampleCount;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      BlocProvider.of<ManageFutureBloc>(context).add(AllSeniorRepFutureEvent());
      return true;
    }

    Future.microtask(() {
      BlocProvider.of<FutureRepBloc>(context).add(FutureSpEvent(id));
    });
    return Center(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          floatingActionButton: BlocConsumer<FutureRepBloc, FutureRepState>(
            listener: (context, state) {
              if (state is EditeStatusLoadingState) {
                loading(context);
              } else if (state is EditeStatusFailureState) {
                error(context, state.failure.massage, state.failure.code);
              } else if (state is EditeStatusState) {
                BlocProvider.of<ManageFutureBloc>(context)
                    .add(AllSeniorRepFutureEvent());
                success(context);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () {
               List<StatusPlanModel> statusPlan  = UserInfo.repType=="4"?statusPlanSupervisor:statusPlanTeamleader;
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'اختر الحالة الجديدة',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 20),

                            ... statusPlan.map((status) => ListTile(
                              title: Text(status.name),
                              onTap: () {
                                Navigator.pop(context);
                                BlocProvider.of<FutureRepBloc>(context).add(
                                  EditePlanStatusEvent(repPlanId, status.id),
                                );
                              },
                            )
                            ),

                          ],
                        ),
                      );
                    },
                  );
                },


                backgroundColor: ColorManager.secondaryColor1,
                child: Icon(
                  Icons.check,
                  color: ColorManager.white,
                ),
              );
            },
          ),
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    size: AppSize.s30,
                    Icons.arrow_back_ios_new,
                    color: ColorManager.secondaryColor1,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
            title: const Text('الإختصاصات'),
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 0.6,
                      color: ColorManager.white,
                      spreadRadius: 0.5,
                      offset: const Offset(2, 3))
                ],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchField(
                      searchController: searchController,
                      onPressed: (value) {
                        BlocProvider.of<FutureRepBloc>(context)
                            .add(FutureSearchSpecEvent(value));
                      },
                    ),
                    BlocBuilder<FutureRepBloc, FutureRepState>(
                      builder: (context, state) {
                        List<SpecDModel> spModel =
                            context.watch<FutureRepBloc>().specialization;
                        if (state is FutureSpRepState) {
                          spModel = state.Specs;
                        }
                        if (state is FutureSpRepLoadingState) {
                          return loadingFullScreen(context);
                        }
                        if (state is FutureSpRepErrorState) {
                          return errorFullScreen(context,
                              mes: state.failure.massage,
                              func: () =>
                                  BlocProvider.of<FutureRepBloc>(context)
                                      .add(FutureSpEvent(id)));
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1.0,
                            mainAxisSpacing: 2.0,
                            childAspectRatio: 1,
                          ),
                          itemCount: spModel.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                iniFutureModule();
                                BlocProvider.of<FutureRepBloc>(context).add(
                                    FutureRepPlanBrandSpEvent(
                                        RepSp(repPlanId, spModel[index].id, id),
                                        sampleCount));

                                Navigator.pushNamed(
                                  context,
                                  Routes.RepPlanBrandSp,
                                  arguments: {
                                    'title': spModel[index].title,
                                    'flag': flag.flag
                                  },
                                );
                              },
                              child: Container(
                                margin:  EdgeInsets.all(AppPaddingH.p10),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.2), // ظل خفيف
                                      blurRadius: 4, // تمويه للظل
                                      spreadRadius: 2, // انتشار الظل
                                      offset: const Offset(
                                          0, 2), // إزاحة بسيطة للأسفل
                                    ),
                                  ],
                                  color: ColorManager.white,
                                  borderRadius:  BorderRadius.all(
                                    Radius.circular(AppSize.s25),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          ImageAssetsSpec()
                                              .getImage(spModel[index].id),
                                          width: 60,
                                          height: 60,
                                          color: ColorManager.secondaryColor1,
                                          colorBlendMode: BlendMode.modulate,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const SizedBox();
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorManager.secondaryColor7,
                                          borderRadius:  BorderRadius.only(
                                            bottomLeft:
                                                Radius.circular(AppSize.s25),
                                            bottomRight:
                                                Radius.circular(AppSize.s25),
                                          ),
                                        ),
                                        child: Text(
                                          spModel[index].title,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: ColorManager.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
