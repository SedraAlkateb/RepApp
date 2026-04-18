import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand/bloc/brand_bloc.dart';
import 'package:domina_app/presentation/uniti/basic/brand.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandPage extends StatelessWidget {
  BrandPage({super.key});
  final TextEditingController searchbrandController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(' الأصناف'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h,),
                SearchField(
                    searchController: searchbrandController,
                    onPressed: (value) {
                      BlocProvider.of<BrandBloc>(context)
                          .add(SearchbradEvent(value));
                    }),
                BlocConsumer<BrandBloc, BrandState>(
                  listener: (context, state) {
                    if (state is AllBrandErrorState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        error(
                            context, state.failure.massage, state.failure.code);
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
                return BrandListWidget(brands: brandModel);
                                }

                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
