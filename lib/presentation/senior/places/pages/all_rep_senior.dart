import 'package:domina_app/app/di.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/representative/page/rep_profile.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllRepSenior extends StatelessWidget {
  AllRepSenior({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تقارير المندوبين'),
      ),
      body: bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    return Column(
      children: [
        SearchField(
          searchController: searchController,
          onPressed: (value) {
            BlocProvider.of<SeniorRepsBloc>(context)
                .add(SenSearchRepEvent(value));
          },
        ),
        BlocBuilder<SeniorRepsBloc, SeniorRepsState>(
          builder: (context, state) {
            List<AllRepresentative> allRepresentative =
                context.watch<SeniorRepsBloc>().allRepresentative;
             if (state is AllSeniorRepLoadingState) {
            return loadingFullScreen(context);
            }
            if (state is AllSeniorRepEmptyState) {
              return emptyFullScreen(context);
            }
            else if (state is AllSeniorRepErrorState) {
            return errorFullScreen(context,
            func: () => BlocProvider.of<SeniorRepsBloc>(context)
                .add(AllSeniorRepEvent(BlocProvider.of<SeniorRepsBloc>(context).cityId)));
            }
          else  if (state is AllSeniorRepState) {
              allRepresentative = state.representatives;
            }
            return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          initSeniorProfModule();
                          BlocProvider.of<SeniorProfBloc>(context).add(
                              getInfoRepEvent(allRepresentative[index].id));
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return RepProfile(
                                index: index,
                                  repPlanId:
                                      allRepresentative[index].activePlan,
                                  id: allRepresentative[index].id,
                              cityId: BlocProvider.of<SeniorRepsBloc>(context).cityId,);
                            },
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.all(AppPaddingH.p8),
                          padding: EdgeInsets.all(AppPaddingH.p16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              //  ColorManager.secondaryColor6,
                              ColorManager.secondaryColor7,
                              ColorManager.secondaryColor7,
                              ColorManager.secondaryColor7,
                            ]),
                            color: ColorManager.white,
                            borderRadius:  BorderRadius.all(
                                Radius.circular(AppSize.s8)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${allRepresentative[index].name}",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                "${allRepresentative[index].number}",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: allRepresentative.length,
                  ),
                ),
              );

          },
        ),
      ],
    );
  }
}
