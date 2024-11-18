import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandPlanOtherPage extends StatefulWidget {
  final OtherBrandSpPlanModel otherBrandSpPlanModel;
 final int index1;
  @override
  const BrandPlanOtherPage({super.key, required this.otherBrandSpPlanModel
    ,required this.index1});

  State<BrandPlanOtherPage> createState() => _BrandPlanOtherPageState();
}

class _BrandPlanOtherPageState extends State<BrandPlanOtherPage>
    with AutomaticKeepAliveClientMixin {
  int summ=0;
  @override
  void initState() {
    for (var brand in widget.otherBrandSpPlanModel.brands) {
      summ=summ+brand.amount;
    }
    BlocProvider.of<BrandPlanBloc>(context).sumS=summ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(appBar: AppBar(centerTitle: true,
        title:Text(widget.otherBrandSpPlanModel.specModel.title)),
      backgroundColor: ColorManager.white,
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocConsumer<BrandPlanBloc, BrandPlanState>(
  listener: (context, state) {
    if (state is SumErrorState) {
      error(context, state.failure.massage, state.failure.code);
      BlocProvider.of<BrandPlanBloc>(context)
          .add(UpdateEvent());
    }
  },
  builder: (context, state) {

    return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        BlocBuilder<BrandPlanBloc, BrandPlanState>(
                      builder: (context, state) {
                        return Container(
                          margin: EdgeInsets.all(AppPadding.p8),
                          padding: EdgeInsets.all(AppPadding.p16),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: ColorManager.secondaryColor),
                            ],
                            color: ColorManager.white,
                            border:
                                Border.all(color: ColorManager.secondaryColor7),
                            borderRadius: const BorderRadius.all(
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
                                        "العينة : ${widget.otherBrandSpPlanModel.brands[index].title}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: AppPadding.p8,
                                        horizontal: AppPadding.p14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: int.parse(widget.otherBrandSpPlanModel.brands[index].brandType) == 1
                                            ? ColorManager.secondaryColor1
                                            : ColorManager.secondaryColor2,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(AppSize.s8),
                                        ),
                                      ),
                                      child: Text(
                                        int.parse(widget.otherBrandSpPlanModel.brands[index].brandType) == 1
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
                                        Icons.medical_information_outlined ,
                                        color: ColorManager.secondaryColor4,
                                      ),
                                    ),
                                    SizedBox(width: 8), // مسافة صغيرة
                                    Expanded(
                                      child: Text(
                                        "النوع : ${widget.otherBrandSpPlanModel.brands[index].phTitle}",
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
                                          hintText: widget.otherBrandSpPlanModel
                                              .brands[index].amount
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
                                        onChanged: (value) {
                                          if (value.isNotEmpty && value != "") {
                                            print(value);
                                            print("value");
                                            BlocProvider.of<BrandPlanBloc>(
                                                    context)
                                                .add(ChangeFieldEvent(
                                                    int.parse(value),
                                                widget.index1,
                                                  index, widget.otherBrandSpPlanModel.brandm));
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    itemCount: widget.otherBrandSpPlanModel.brands.length,
                  );
  },
)),
            ),

          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
