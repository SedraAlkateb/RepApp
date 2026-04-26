import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/widget/animation_press.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlacesArchive extends StatefulWidget {
  PlacesArchive({super.key});

  @override
  State<PlacesArchive> createState() => _PlacesArchiveState();
}

class _PlacesArchiveState extends State<PlacesArchive> {
  @override
  void initState() {
  BlocProvider.of<PlaceBloc>(context).add(NumEvent());
    super.initState();
  }
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar
        (leading:IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back)) ,
        title: Text('ارشيف المناطق'),
      ),
      body:    bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        UserInfo.endDate == BlocProvider.of<PlaceBloc>(context).data
            ? Padding(
                padding: const EdgeInsets.only(right: 17),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_amber_outlined,
                      color: Colors.red,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "يرجى الضغط على زر المزامنة لرفع زيارات الخطة الحالية",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ))
            : SizedBox(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
          child: SearchField(
            //
            searchController: searchController,
            onPressed: (value) {
              BlocProvider.of<PlaceBloc>(context)
                  .add(SearchPlaceEvent(value: value));
            },
          ),
        ),
        Expanded(
          child: BlocConsumer<PlaceBloc, PlaceState>(
            listener: (context, state) {
              if (state is AllPlaceErrorState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  error(context, state.failure.massage, state.failure.code);
                });
              }
              if (state is CheckRepState) {
                if (state.isCheck == false) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.deleteLogout,
                      (route) => false,
                    );
                  });
                }
              }
            },
            builder: (context, state) {
              List<PlaceModel> placeModel =
                  context.watch<PlaceBloc>().placeSearchModel;
              if (state is AllPlaceState) {
                placeModel = state.places;
              }
              if (state is SearchPlaceState) {
                placeModel = state.places;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: placeModel.length,
                  itemBuilder: (context, index) {
                    return AnimatedPlaceCard(
                      place: placeModel[index],
                      onTap: () {
                        print(placeModel[index].placeId);
                        Navigator.pushNamed(
                          context,
                          Routes.doctorAndHospitalArchive,
                          arguments: placeModel[index].placeId, // نرسل الـ ID هنا
                        );
                        BlocProvider.of<PlaceBloc>(context).add(
                          DoctorArchiveByPlace(placeModel[index].placeId, 0),
                        );
                      },
                    );
                  },
                ),
              );

            },
          ),
        ),
      ],
    );
  }
}
