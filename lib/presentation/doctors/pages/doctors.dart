import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Doctors extends StatelessWidget {
  Doctors({super.key});

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
                  ColorManager.white, // هنا يمكنك تحديد لون الأيقونة
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: Text(
              'الأطباء'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              Expanded(
                child: BlocConsumer<DoctorsBloc, DoctorsState>(
                  listener: (context, state) {
                    if(state is AllDoctorErrorState){
                      error(context, state.failure.massage, state.failure.code);
                    }

                  },
                  builder: (context, state) {
                    if(state is AllDoctorState){
                      List<DoctorModel> doctormodel=state.doctor;

                      return ListView.builder
                        (
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(AppPadding.p8),
                              padding: EdgeInsets.all(AppPadding.p16),
                              //    height: AppSize.s150,
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                border:
                                Border.all(color: ColorManager.hintGrey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(AppSize.s8)),
                                //        color: ColorManager.card,
                              ),
                              child: Row(
                                children: [
                                  Text(doctormodel[index].title)
                                ],
                              ),
                            );
                          }, itemCount: doctormodel.length);
                    }

                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}