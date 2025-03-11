import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/doctors/pages/doctor_details%20.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Doctors extends StatelessWidget {
  Doctors({super.key});
  final TextEditingController searchDocController = TextEditingController();

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
                color: ColorManager.secondaryColor1,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text('الأطباء'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
            BlocConsumer<DoctorsBloc, DoctorsState>(
              buildWhen: (previous, current) => current is AllDoctorState||current is AllDoctorEmptyState,
              listener: (context, state) {
                if (state is AllDoctorErrorState) {
                  error(context, state.failure.massage, state.failure.code);
                }
              },
              builder: (context, state) {
                List<DoctorModel> doctorModel=context.watch<DoctorsBloc>().doctor;
                if (state is AllDoctorState) {
                  doctorModel = state.doctor;
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "عدد الأطباء: ",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            CircleNumberWidget(number: doctorModel.length),
                          ],
                        ),
                      ),
                      ...doctorModel.map((doctor) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DoctorDetails(doctor: doctor),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(AppPadding.p8),
                            padding: EdgeInsets.all(AppPadding.p16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorManager.secondaryColor6,
                                  ColorManager.secondaryColor7,
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(AppSize.s8)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  doctor.title,
                                  style: Theme.of(context).textTheme.labelLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
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
