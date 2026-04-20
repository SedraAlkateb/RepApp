import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:domina_app/presentation/senior/all_city/widget/customcard.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/senior/places/pages/all_rep_senior.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCity extends StatefulWidget {
  const AllCity({super.key});

  @override
  State<AllCity> createState() => _AllCityState();
}

class _AllCityState extends State<AllCity> {
  final TextEditingController searchController = TextEditingController();
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    return BlocBuilder<AllCityBloc, AllCityState>(
      builder: (context, state) {
        if (state is GetAllCityState) {
          final List<CityModel> cities = state.cities;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  itemCount: cities.length
                  ,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        initSeniorModule();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return AllRepSenior(
                              cityname: cities[index].title,
                              cityId: cities[index].id,
                              repId: UserInfo.repId,
                            );
                          },
                        ));
                        BlocProvider.of<SeniorRepsBloc>(context)
                            .add(AllSeniorRepEvent(
                          cities[index].id,UserInfo.repId
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: CustomCard(
                          startAnimation: startAnimation,
                          index: index,
                          screenWidth: MediaQuery.of(context).size.width,
                          text: cities[index].title,
                          cardGradientColors: [
                            ColorManager.shadowCard,
                            ColorManager.shadowCard,
                          ],
                          borderWidth: 22.0,
                          textColor: ColorManager.secondaryColor1,
                          linerGradientColors: [
                            ColorManager.secondaryColor1,
                            ColorManager.secondaryColor1,
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
        if (state is AllCityLoadingState) {
          return loadingShimmer(context, 20, 25, 70, BorderRadius.circular(20));
        }
        if (state is AllCityErrorState) {
          return errorFullScreen(context,
              func: () => BlocProvider.of<AllCityBloc>(context)
                  .add(const GetAllCityEvent()));
        }
        return const SizedBox();
      },
    );
  }
}
