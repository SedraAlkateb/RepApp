
import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_launcher.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/widget/animation_press.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Places extends StatefulWidget {
  Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  @override
  void initState() {
  BlocProvider.of<PlaceBloc>(context).add(NumEvent());
    super.initState();
  }
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final placeBloc = context.read<PlaceBloc>();
    final size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (placeBloc.k == 0) {
        showDialog(
            context: context,
            builder: (context) {
              return Container(
                  child: Center(
                      child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
                child: Container(
                    height: size.height / 3.2,
                    decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Container(
                        height: size.height / 3,
                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 30),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "اختر إحدى المناطق لإظهار (الأطباء، المشافي) في المنطقة المختارة",
                                  style: TextStyle(
                                      fontFamily: 'Tajawal',
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.secondaryColor1,
                                      // fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              ElevatedButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("موافق"),
                                  ),
                                  onPressed: () {
                                    placeBloc.k = 1;
                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        ),
                      ),
                    )),
              )));
            });
        placeBloc.k = 1;
      }
    });
    return Scaffold(
      drawer: DrawerPage(),
      backgroundColor: ColorManager.medicalBg,
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(1.0), // هنا نحدد الارتفاع (سماكة الخط)
          child: Container(
            color: ColorManager.medicalBorder, // لون الخط
            height: 1.0, // ارتفاع الحاوية التي تمثل الخط
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return Center(
              child: IconButton(
                icon: Icon(
                  size: AppSize.s30,
                  Icons.menu,
                  color: ColorManager.secondaryColor,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            );
          },
        ),
        title: Text('المناطق'),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: [
            bodyBuild(context),
            Positioned(
              bottom: 30,
              left: 30,
              child: FloatingActionButton(
                onPressed: () {
                  initAsyncInModule();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamed(context, Routes.asyncIn);
                  });
                },
                backgroundColor: ColorManager.secondaryColor1,
                child: Icon(
                  Icons.wifi_protected_setup_outlined,
                  color: ColorManager.white,
                ),
              ),
            ),
          ],
        ),
      ),
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
                child:
                placeModel.isEmpty?emptyFullScreen(context):
                ListView.builder(
                  itemCount: placeModel.length,
                  itemBuilder: (context, index) {
                    return AnimatedPlaceCard(
                      place: placeModel[index],
                      onTap: () {
                        print(placeModel[index].placeId);
                        Navigator.pushNamed(
                          context,
                          Routes.placeVisitPage,
                          arguments: placeModel[index].placeId, // نرسل الـ ID هنا
                        );
                        BlocProvider.of<VisitPlaceBloc>(context).add(
                          DoctorByPlace(placeModel[index].placeId, 0),
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
