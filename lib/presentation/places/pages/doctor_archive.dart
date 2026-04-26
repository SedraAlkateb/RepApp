import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/uniti/basic/doctor.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorArchive extends StatelessWidget {
  DoctorArchive({super.key});
  final TextEditingController searchDocController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          slivers: [

            BlocBuilder<PlaceBloc, PlaceState>(
              buildWhen: (previous, current) => current is AllDoctorArchiveByPlaceState||current is AllDoctorArchiveByPlaceErrorState||current is EmptyArchiveState,

              builder: (context, state) {

                if (state is AllDoctorArchiveByPlaceState) {
                List<DoctorModel>   doctorModel = state.data;
                return SliverList(
                  delegate: SliverChildListDelegate([
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12.h,
                          ),
                          SearchField(
                            searchController: searchDocController,
                            onPressed: (value) {
                              BlocProvider.of<PlaceBloc>(context)
                                  .add(SearchDoctorArchive(value,doctorModel));
                            },
                          ),
                        ],
                      ),
                    ),
                    DoctorListWidget(doctorModel: doctorModel)
                  ]),
                );
                }
                if (state is AllDoctorArchiveByPlaceErrorState) {
                  return errorFullScreen(context,mes:  state.failure.massage, func: (){});
                }
                if (state is EmptyArchiveState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 100,
                        ),
                        emptyFullScreen(context)
                      ]));
                }
                return SizedBox();


              },
            ),
          ],
        ),
      ),
    );
  }
}
