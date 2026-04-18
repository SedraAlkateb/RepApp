import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/basic/spec_grid_widget.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecSeniorPage extends StatelessWidget {
  SpecSeniorPage({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return Scaffold(
      appBar: AppBar(

        title: Text('الإختصاصات'),
      ),
      body:OrientationBuilder(
          builder: (context, orientation) {
            int crossAxisCount;
            if (isTablet) {
              crossAxisCount = orientation == Orientation.landscape ? 4 : 3;
            } else {
              crossAxisCount = orientation == Orientation.landscape ? 3 : 2;
            }

            return SingleChildScrollView(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: isTablet ? 30.w : 16.w,
              vertical: 12.h
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SearchField(
                    searchController: searchController,
                    onPressed: (value) {
                      BlocProvider.of<SeniorProfBloc>(context)
                          .add(SenSearchSpecEvent(value));
                    },
                  ),
                  SizedBox(height: 12.h,),
                  BlocConsumer<SeniorProfBloc, SeniorProfState>(
                    listener: (context, state) {
                      /*
                            if (state is AllSpecLoadingState) {
                              loading(context);
                            }
                            if (state is AllSpecState) {
                              success(context);
                            }
                            */
                      if (state is SenAllSpecErrorState) {
                        error(context, state.failure.massage, state.failure.code);
                      }
                    },
                    builder: (context, state) {
                      List<SpecDModel> placeModel =
                          context.watch<SeniorProfBloc>().specialization;
                      if (state is SenAllSpecState) {
                        placeModel = state.Specs;
                      }
                      if(state is SenAllSpecLoadingState){
                        return loadingFullScreen(context);
                      }
                      return SpecGridWidget(items: placeModel, crossAxisCount: crossAxisCount);


                    },
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
