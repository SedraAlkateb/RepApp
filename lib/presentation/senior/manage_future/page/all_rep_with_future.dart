import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/font_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/bloc/edit_brand_plan_bloc.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/page/auditing_plan.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/senior/manage_future/widget/Buttom.dart';
import 'package:domina_app/presentation/senior/manage_future/widget/drop_down_change_plan.dart';
import 'package:domina_app/presentation/senior/plan_review/page/future_spec.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class AllRepWithFuture extends StatefulWidget {
  const AllRepWithFuture({super.key});

  @override
  State<AllRepWithFuture> createState() => _AllRepWithFutureState();
}

class _AllRepWithFutureState extends State<AllRepWithFuture> {
  final TextEditingController searchController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  int index = -1;
  bool startAnimation = false;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
print("object");
print(UserInfo.statusPlan);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  void onRefresh() {
    BlocProvider.of<ManageFutureBloc>(context).add(AllSeniorRepFutureEvent());

    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("إدارة الخطة الفعالة")),
      body: bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12.h,
        ),
        SearchField(
          searchController: searchController,
          onPressed: (value) {
            BlocProvider.of<ManageFutureBloc>(context)
                .add(SenSearchRepFutureEvent(value));
          },
        ),
        BlocBuilder<ManageFutureBloc, ManageFutureState>(
          builder: (context, state) {
            List<AllRepresentativeFuture> allRepresentative =
                context.watch<ManageFutureBloc>().allRepresentative;

            if (state is AllSeniorRepLoadingState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: AnimatedContainer(
                      height: 60,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 300 + (index * 200)),
                      transform: Matrix4.translationValues(
                          startAnimation ? 0 : screenWidth, 0, 0),
                      margin:  EdgeInsets.all(AppPaddingH.p8),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth / 20,
                      ),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: ColorManager.secondaryColor22),
                        color: const Color.fromARGB(255, 250, 254, 255),
                        borderRadius:
                             BorderRadius.all(Radius.circular(AppSize.s8)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                          ),
                          Container(
                            width: 50,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius:  BorderRadius.all(
                                  Radius.circular(AppSize.s8)),
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is AllSeniorRepErrorState) {
              return errorFullScreen(context,
                  func: () => BlocProvider.of<ManageFutureBloc>(context)
                      .add(AllSeniorRepFutureEvent()));
            } else if (state is AllSeniorRepState) {
              allRepresentative = state.representatives;
            }
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: onRefresh,
                  enablePullDown: true,
                  child: ListView.builder(
                    itemCount: allRepresentative.length,
                    itemBuilder: (context, index) {
                      final isSelected = index == this.index;
                      return AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              this.index = isSelected
                                  ? -1
                                  : index; // للإلغاء في حال تم الضغط مرتين
                            });
                          },
                          child: Container(
                            margin:  EdgeInsets.all(AppPaddingH.p8),
                            padding:  EdgeInsets.symmetric(
                                vertical: AppPaddingH.p16),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorManager.secondaryColor1,
                                  width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(AppSize.s8)),
                              color: ColorManager.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allRepresentative[index].name,
                                        style: TextStyle(
                                          color: ColorManager.secondaryColor1,
                                          fontSize: FontSize.s20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      DropDownChangePlan(
                                          hintText:
                                          allRepresentative[index].flag.name,
                                          items: allFlags,
                                          onChanged: (x){
                                            FlagModel flagModel =x;
                                            BlocProvider.of
                                            <ManageFutureBloc>(context)
                                                .add(ChangPlanStatusEvent
                                              (allRepresentative[index].activePlan,
                                                flagModel.flag,index));
                                          },
                                          errorText:""),
                                      // Text(
                                      //   allRepresentative[index].flag.name,
                                      //   style: TextStyle(
                                      //     color: ColorManager.secondaryColor1,
                                      //     fontSize: FontSize.s17,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),

                                if (isSelected) ...[
                                  const SizedBox(height: 16),
                                  Divider(color: ColorManager.secondaryColor),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButtonFuture(
                                        isactive: allRepresentative[index]
                                                .flag
                                                .flag ==
                                            UserInfo.statusPlan,
                                        icon: Icons.arrow_back_ios_sharp,
                                        text: "تدقيق الخطة",
                                        onPressed: allRepresentative[index]
                                                    .flag
                                                    .flag ==
                                                UserInfo.statusPlan
                                            ? () {

                                                iniFutureModule();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return FutureSpecializationsPage(
                                                        id: allRepresentative[
                                                                index]
                                                            .id,
                                                        repPlanId:
                                                            allRepresentative[
                                                                    index]
                                                                .activePlan,
                                                        flag: allRepresentative[
                                                                index]
                                                            .flag,
                                                        sampleCount:
                                                            allRepresentative[
                                                                    index]
                                                                .samplesCount,
                                                      );
                                                    },
                                                  ),
                                                );
                                              }
                                            : () {},
                                      ),
                                      CustomButtonFuture(
                                        isactive: true,
                                        icon: Icons.edit,
                                        text: "تعديل الأصناف",
                                        onPressed: () {
                                          print(allRepresentative[index]
                                              .flag//
                                              .flag);
                                          print("allRepresentative[index]"
                                          );
                                          iniEditBrandPlanModule();
                                          BlocProvider.of<EditBrandPlanBloc>(
                                                  context)
                                              .add(
                                            FutureGetPlanBrandEvent(
                                              Rep(
                                                allRepresentative[index]
                                                    .activePlan,
                                                1,
                                              ),
                                            ),
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditingPlan(
                                                repPlan:
                                                    allRepresentative[index]
                                                        .activePlan,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ]
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
