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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DoctorsBloc>(context).add(AllDoctorEvent(117));
    });
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
            ' Doctors'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Icon(Icons.location_city),

                  Text("   All Doctors",style: Theme.of(context).textTheme.titleMedium,),
                ],
              ),

            ),
            Text("click to show all Doctor",),
            Expanded(
              child: BlocConsumer<DoctorsBloc, DoctorsState>(
  listener: (context, state) {
    if(state is AllDoctorErrorState){
      error(context, state.failure.massage, state.failure.code);
    }
    if(state is AllDoctorState){
      success(context);
    }
    if(state is AllDoctorLoadingState){
      loading(context);
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