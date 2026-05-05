import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/uniti/basic/doctor.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Doctors extends StatelessWidget {
  Doctors({super.key});
  final TextEditingController searchDocController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.w),
        child: CustomScrollView(
          slivers: [
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
                      BlocProvider.of<DoctorsBloc>(context)
                          .add(SearchDocEvent(value));
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<DoctorsBloc, DoctorsState>(
              buildWhen: (previous, current) => current is AllDoctorState||current is AllDoctorEmptyState,

              builder: (context, state) {
                List<DoctorModel> doctorModel=context.watch<DoctorsBloc>().doctor;
                if (state is AllDoctorState) {
                  doctorModel = state.doctor;
                }
                if (state is AllDoctorErrorState) {
                 return errorFullScreen(context,mes:  state.failure.massage, func: (){});
                }
                if (state is AllDoctorEmptyState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 100,
                        ),
                        emptyFullScreen(context)
                      ]));
                }
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      DoctorListWidget(doctorModel: doctorModel)
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
