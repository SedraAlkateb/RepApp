import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/pages/visit_doctor.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorVisit extends StatefulWidget {
  @override
  _DoctorVisitState createState() => _DoctorVisitState();
}

class _DoctorVisitState extends State<DoctorVisit>
    with AutomaticKeepAliveClientMixin {

  final TextEditingController searchController = TextEditingController();

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(
              searchController: searchController,
              onPressed: (value) {
                BlocProvider.of<VisitPlaceBloc>(context)
                    .add(SearchDoctorVisitEvent(value: value));
              },
            ),
            BlocConsumer<VisitPlaceBloc, VisitPlaceState>(
              listener: (context, state) {
                if (state is AllDoctorByPlaceErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    error(context, state.failure.massage, state.failure.code);
                  });
                }
              },
              builder: (context, state) {
                List<DoctorModel> doctors =
                    context.watch<VisitPlaceBloc>().doctors;
                if (state is SearchVisitDoctorState) {
                  doctors = state.doctorVisit;
                }
                if (state is AllDoctorByPlaceState) {
                  doctors = state.data;
                }
                if(state is EmptyState){
                  return  emptyFullScreen(context);
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return VisitDoctor(doctorModel: doctors[index]);
                            }),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(AppPadding.p8),
                          padding: EdgeInsets.all(AppPadding.p16),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            border: Border.all(color: ColorManager.hintGrey),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(AppSize.s8)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                doctors[index].title,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              TextRach(
                                  s1: "العنوان: ", s2: doctors[index].address),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: doctors.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
