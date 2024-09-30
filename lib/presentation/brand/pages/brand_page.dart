import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand/bloc/brand_bloc.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandPage extends StatelessWidget {
  BrandPage({super.key});
  final TextEditingController searchbrandController = TextEditingController();
  @override
  Widget build(BuildContext context) {
       return Scaffold(
        drawer: DrawerPage(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                size: AppSize.s30,
                Icons.menu,
                color:
                ColorManager.secondaryColor1, // هنا يمكنك تحديد لون الأيقونة
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
            ' الأصناف'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SearchField(searchController: searchbrandController,onPressed: (value) {
                        BlocProvider.of<BrandBloc>(context).add(SearchbradEvent(value));} ),
            Expanded(
              child: BlocConsumer<BrandBloc, BrandState>(
                listener: (context, state) {
                  if(state is AllBrandErrorState){
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      error(context, state.failure.massage, state.failure.code);
                    });
                  }
                  /*
                  if(state is AllBrandLoadingState){
                    loading(context);
                  }
                  if(state is AllBrandState){
    success(context);}

                   */
                },
  builder: (context, state) {
    if(state is AllBrandState){
      List<BrandModel> brandModel=state.brand;
      return ListView.builder
        (
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(AppPadding.p8),
              padding: EdgeInsets.all(AppPadding.p16),
              //    height: AppSize.s150,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  ColorManager.secondaryColor6,
                  ColorManager.secondaryColor7,
                  ColorManager.secondaryColor7,
                ]),
                color: ColorManager.white,

                borderRadius: const BorderRadius.all(
                    Radius.circular(AppSize.s8)),
                //        color: ColorManager.card,
              ),
              child: Column(
                children: [
                  Text(" ${brandModel[index].title} ", style: Theme.of(context)
                      .textTheme
                      .labelLarge),
                  Text(" نوع الصنف : ${brandModel[index].phTitle} ", style: Theme.of(context)
                      .textTheme
                      .titleSmall,textAlign: TextAlign.center,),

                ],
              ),
            );
          }, itemCount: brandModel.length);
    }


    return SizedBox(
    );
  },
),
            ),
          ],
        ),
      )
    );
  }
}