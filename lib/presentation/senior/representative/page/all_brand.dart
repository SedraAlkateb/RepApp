import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/basic/brand.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllBrand extends StatelessWidget {
  AllBrand({super.key});
  final TextEditingController searchDocController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الاصناف'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h,),
                  SearchField(
                    searchController: searchDocController,
                    onPressed: (value) {
                      BlocProvider.of<SeniorProfBloc>(context)
                          .add(SenSearchBrandEvent(value));
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<SeniorProfBloc, SeniorProfState>(
              buildWhen: (previous, current) =>
                  current is SenAllBrandsState ||
                  current is SenAllBrandEmptyState,
              builder: (context, state) {
                List<BrandModel> brandModel =
                    context.watch<SeniorProfBloc>().brand;
                if (state is SenAllBrandsState) {
                  brandModel = state.brand;
                }
                if (state is SenAllBrandEmptyState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 100,
                    ),
                    emptyFullScreen(context)
                  ]));
                }
                if (state is SenAllBrandErrorState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 100,
                    ),
                    errorFullScreen(context, func: () {
                      BlocProvider.of<SeniorProfBloc>(context)
                          .add(SenAllBrandEvent(203));
                    })
                  ]));
                }
                if (state is SenAllBrandLoadingState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 100,
                    ),
                    loadingFullScreen(context)
                  ]));
                }
                return SliverList(
                  delegate: SliverChildListDelegate([
                    BrandListWidget(brands: brandModel,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),),
                  ]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
