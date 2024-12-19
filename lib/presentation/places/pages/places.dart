import 'dart:async' as s;
import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/main.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/pages/place_visit_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:domina_app/presentation/uniti/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class Places extends StatelessWidget {
  Places({super.key});
  final TextEditingController searchController = TextEditingController();
  @override

  Widget build(BuildContext context) {
    print(UserInfo.activePlanId);
    final size = MediaQuery.of(context).size;
    // PhotoHero(
    //   widget: ,
    //   width: 300.0,
    //   onTap: () {
    //     Navigator.of(context).pop();
    //   },
    // )
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<PlaceBloc>().k == 0) {
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
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "اختر أحد المناطق لإِظهار(الأطباء,المشافي)في المنطقة المختارة",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: ColorManager.secondaryColor1,
                                      fontWeight: FontWeight.bold,
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
                                    context.read<PlaceBloc>().k = 1;
                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        ),
                      ),
                    )),
              )));
            });
        context.read<PlaceBloc>().k = 1;
      }
    });
    // التحقق من الوقت الحالي مقابل UserInfo.endDate
    s.Timer.periodic(const Duration(seconds: 60), (timer) async {

      final now =formatDateTimeFromDataTime(DateTime.now()) ;
      if (UserInfo.endDate != null && now==formatDateTime(UserInfo.endDate??""))
      {
        timer.cancel();
        // إيقاف الفحص عند تحقق الشرط
        await _showEndDateNotification();

      }
    });
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
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
// إنشاء الإشعار باستخدام flutter_local_notifications
  Future<void> _showEndDateNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // معرف القناة
      'التنبيهات', // اسم القناة
      channelDescription: 'تنبيهات خاصة بالوقت',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      enableVibration :true,
        playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // معرف الإشعار
      'شركة دومِنا', // عنوان الإشعار
      'لقد وصلت إلى نهاية الخطة الحالية, يرجى ضغط زر المزامنة لرفع الزيارات وتحديث المعلومات ', // نص الإشعار
      platformChannelSpecifics,
      payload: 'end_date_notification', // يمكن استخدام هذا في التنقل بين الصفحات
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
                  children: [
                    Icon(
                      Icons.warning_amber_outlined,
                      color: Colors.red,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "يرجى الضغط على زر المزامنة لرفع زيارات الخطة الحالية",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ))
            : SizedBox(),
        SizedBox(
          height: 10,
        ),
        SearchField(
          searchController: searchController,
          onPressed: (value) {
            BlocProvider.of<PlaceBloc>(context)
                .add(SearchPlaceEvent(value: value));
          },
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return PlaceVisitPage(
                                placeId: placeModel[index].placeId);
                          },
                        ));
                        BlocProvider.of<VisitPlaceBloc>(context).add(
                          DoctorByPlace(placeModel[index].placeId, 0),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(AppPadding.p8),
                        padding: EdgeInsets.all(AppPadding.p16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            ColorManager.secondaryColor6,
                            ColorManager.secondaryColor7,
                            ColorManager.secondaryColor7,
                          ]),
                          color: ColorManager.white,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppSize.s8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              placeModel[index].title,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: placeModel.length,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
