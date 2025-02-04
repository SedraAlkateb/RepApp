import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportInventory extends StatelessWidget {
  const ReportInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  size: AppSize.s30,
                  Icons.arrow_back_sharp,
                  color: ColorManager.secondaryColor1,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          title: Text('تقرير توزيع العينات (الجرد)'),
        ),
        body: bodyBuild(context));
  }

  Widget bodyBuild(BuildContext context) {
    return BlocBuilder<ReportInventoryBloc, ReportInventoryState>(
      builder: (context, state) {
        if (state is SenAllInventoryState) {
          final List<InventoryModel> inventoryModel = state.inventoryModel;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(AppPadding.p8),
                  padding: EdgeInsets.all(AppPadding.p16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorManager.secondaryColor6,
                      ColorManager.secondaryColor7,
                      ColorManager.secondaryColor7,
                    ]),
                    color: ColorManager.white,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppSize.s8)),
                  ),
                  child: Center(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                              " اسم المستحضر : ${inventoryModel[index].title}", style: Theme.of(context).textTheme.titleSmall,),
                          Text(
                              "  العدد الكلي: ${inventoryModel[index].total}", style: Theme.of(context).textTheme.titleSmall,),
                          Text(
                            "المتبقي :${inventoryModel[index].rest.toString()}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text("عدد العينات الموزعة : ${inventoryModel[index].used}", style: Theme.of(context).textTheme.titleSmall,),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: inventoryModel.length,
            ),
          );
        }
        if (state is SenAllInventoryLoadingState) {
          print("gtggggggggggggggggg");
          return loadingFullScreen(context);
        }
        if (state is SenAllInventoryErrorState) {
          return errorFullScreen(context,
              func: () => BlocProvider.of<ReportInventoryBloc>(context)
                  .add(SenAllInventoryEvent(203)));
        }
        return SizedBox();
      },
    );
  }
}
