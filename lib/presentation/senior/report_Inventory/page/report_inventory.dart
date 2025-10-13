import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportInventory extends StatelessWidget {
   ReportInventory({super.key});
  final TextEditingController searchInventoryController = TextEditingController();
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
            padding:  EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [ SearchField(
                searchController: searchInventoryController,
                onPressed: (value) {
                  BlocProvider.of<ReportInventoryBloc>(context)
                      .add(SenSearchInventoryEvent(value));
                },
              ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(AppPaddingH.p8),
                            padding: EdgeInsets.all(AppPaddingH.p16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                ColorManager.secondaryColor6,
                                ColorManager.secondaryColor7,
                                ColorManager.secondaryColor7,
                              ]),
                              color: ColorManager.white,
                              borderRadius:
                                   BorderRadius.all(Radius.circular(AppSize.s8)),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                      " اسم المستحضر : ${inventoryModel[index].title}",
                                    style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
                                  Text(
                                      "  العدد الكلي : ${inventoryModel[index].total}",
                                    style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,),
                                  Text(
                                    " المتبقي : ${inventoryModel[index].rest.toString()}",
                                    style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,
                                  ),
                                  Text("عدد العينات الموزعة : ${inventoryModel[index].used}",
                                    style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: inventoryModel.length,
                  ),
                ),
              ],
            ),
          );
        }
        if (state is SenAllInventoryLoadingState) {

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
