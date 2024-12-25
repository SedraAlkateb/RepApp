import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/hospitals/bloc/hospitals_bloc.dart';
import 'package:domina_app/presentation/hospitals/page/hospital_details.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/uniti/circle_number_widget.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Hospital extends StatelessWidget {
  Hospital({super.key});
  final TextEditingController searchhosController = TextEditingController();

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
        title: Text('المشافي'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          slivers: [
            // عنصر البحث
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchField(
                    searchController: searchhosController,
                    onPressed: (value) {
                      BlocProvider.of<HospitalsBloc>(context)
                          .add(SearchhosEvent(value));
                    },
                  ),
                ],
              ),
            ),
            BlocConsumer<HospitalsBloc, HospitalsState>(
              listener: (context, state) {
                if (state is AllHospitalErrorState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    error(context, state.failure.massage, state.failure.code);
                  });
                }
              },
              builder: (context, state) {
                List<HospitalSpAllModel> hospitalModel =
                    context.watch<HospitalsBloc>().hospital;
                if (state is AllHospitalEmptyState) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 100,
                    ),
                    emptyFullScreen(context)
                  ]));
                }
                if (state is AllHospitalsState) {
                  hospitalModel = state.hospital;
                }
                return SliverList(
                  delegate: SliverChildListDelegate([
                    // عرض عدد المستشفيات في Row
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("عدد المشافي: ",
                              style: Theme.of(context).textTheme.labelSmall),
                          CircleNumberWidget(number: hospitalModel.length),
                        ],
                      ),
                    ),
                    // القائمة
                    ...hospitalModel.map((hospital) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HospitalDetails(hospital: hospital),
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
                                hospital.title ?? "",
                                style: Theme.of(context).textTheme.labelLarge,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                hospital.titleSp ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
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
