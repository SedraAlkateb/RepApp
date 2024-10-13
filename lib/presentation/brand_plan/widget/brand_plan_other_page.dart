import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandPlanOtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(UserInfo.otherstatus);
    print(UserInfo.percentage);
    return Scaffold(
      backgroundColor: ColorManager.white,
      drawer: DrawerPage(),
       body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocConsumer<BrandPlanBloc, BrandPlanState>(
                  listener: (context, state) {
                    if (state is AllBrandPlanErrorState) {
                      error(context, state.failure.massage, state.failure.code);
                    }
                    if (state is SumErrorState) {
                      error(context, state.failure.massage, state.failure.code);
                      BlocProvider.of<BrandPlanBloc>(context).add(UpdateEvent());
                    }
                  },
                  builder: (context, state) {
                    List<PlanBrandSqlModel> planBrandModel =
                        context.watch<BrandPlanBloc>().planBrand;
                    if(state is SumState){
                      planBrandModel=state.planBrands;
                    }
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.all(AppPadding.p8),
                        padding: EdgeInsets.all(AppPadding.p16),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: ColorManager.secondaryColor),
                          ],
                          color: ColorManager.white,
                          border: Border.all(color: ColorManager.secondaryColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(AppSize.s8)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.add_card),
                                  Text(
                                    "العينة : ${planBrandModel[index].brandTitle} ( ${planBrandModel[index].brandType == 1 ? " رئيسي " : " ثانوي "} )",
                                    style:
                                        Theme.of(context).textTheme.headlineMedium,
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.merge_type_rounded),
                                  Expanded(
                                    child: Text(
                                      "النوع : ${planBrandModel[index].phTitle}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.medical_services_outlined),
                                  Text(
                                    'الاختصاص: ${planBrandModel[index].specializationTitle}',
                                    style:
                                        Theme.of(context).textTheme.headlineMedium,
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'العدد ',
                                    style:
                                        Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  SizedBox(
                                      width: 10),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
            
                                        hintText:
                                            planBrandModel[index].amount.toString(),
                                        enabled:  UserInfo.otherstatus==0? true: state is SumErrorState ?false : false,
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 10,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if(value.isNotEmpty&&value!=""){
                                          print(value);
                                          print("value");
                                          BlocProvider.of<BrandPlanBloc>(context).add( ChangeFieldEvent(int.parse(value),index));
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
                      ),
                      itemCount: planBrandModel.length,
                    );
                  },
                ),
              ),
            ),
            BlocListener<BrandPlanBloc, BrandPlanState>(
  listener: (context, state) {
   if(state is UpdateAmountErrorState){
     error(context, state.failure.massage, state.failure.code);
   }
   if(state is UpdateAmountState){
     success(context);
   }
   if(state is UpdateAmountLoadingState){
     loading(context);
   }
  },
  child: Positioned(
                bottom: 20,
                left: 10,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(ColorManager.secondaryColor6), // لتغيير لون الخلفية
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<CircleBorder>(CircleBorder(),),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(20),),), onPressed: (){
                      BlocProvider.of<BrandPlanBloc>(context).add(UpdateAmountSucEvent());
                }, child: Text("حفظ"))),
),
          ],
        ),
      ),
    );
  }
}
