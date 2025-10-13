import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class EditFutureRep extends StatelessWidget {
  final List<FutureBrandModel> futureBrandModel;
  @override
  const EditFutureRep({super.key, required this.futureBrandModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: Text("futureBrandModel[index].title")),
      backgroundColor: ColorManager.white,
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<BrandPlanBloc, BrandPlanState>(
                    builder: (context, state) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.all(AppPaddingH.p8),
                          padding: EdgeInsets.all(AppPaddingH.p16),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: ColorManager.secondaryColor),
                            ],
                            color: ColorManager.white,
                            border:
                                Border.all(color: ColorManager.secondaryColor7),
                            borderRadius:  BorderRadius.all(
                                Radius.circular(AppSize.s8)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.medication_outlined,
                                        color: ColorManager.secondaryColor4,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "العينة : ${futureBrandModel[index].title}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: AppPaddingH.p8,
                                        horizontal: AppPaddingW.p14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: int.parse(futureBrandModel[index]
                                                    .brandType) ==
                                                1
                                            ? ColorManager.secondaryColor1
                                            : ColorManager.secondaryColor2,
                                        borderRadius:  BorderRadius.all(
                                          Radius.circular(AppSize.s8),
                                        ),
                                      ),
                                      child: Text(
                                        int.parse(futureBrandModel[index]
                                                    .brandType) ==
                                                1
                                            ? "هدف"
                                            : "مساعد",
                                        style: TextStyle(
                                          color: ColorManager.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(color: ColorManager.secondaryColor7),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.medical_information_outlined,
                                        color: ColorManager.secondaryColor4,
                                      ),
                                    ),
                                    SizedBox(width: 8), // مسافة صغيرة
                                    Expanded(
                                      child: Text(
                                        "النوع : ${futureBrandModel[index].phTitle}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color: ColorManager.secondaryColor7),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        'العدد ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            10), // مسافة بين النص وحقل الإدخال
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: futureBrandModel[index]
                                              .amount
                                              .toString(),
                                          enabled: UserInfo.otherstatus == 0
                                              ? true
                                              : state is SumErrorState
                                                  ? false
                                                  : false,
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 10,
                                          ),
                                        ),
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        itemCount: futureBrandModel.length,
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
