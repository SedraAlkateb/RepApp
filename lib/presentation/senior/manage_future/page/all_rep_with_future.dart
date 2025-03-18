import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/drawer/pages/drawer_page.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllRepWithFuture extends StatelessWidget {
  AllRepWithFuture({super.key});

  final TextEditingController searchController = TextEditingController();

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
        title: Text('إدارة الخطط'),
      ),
      body: bodyBuild(context),
    );
  }

  Widget bodyBuild(BuildContext context) {
    return Column(
      children: [
        SearchField(
          searchController: searchController,
          onPressed: (value) {
            BlocProvider.of<ManageFutureBloc>(context)
                .add(SenSearchRepFutureEvent(value));
          },
        ),
        BlocBuilder<ManageFutureBloc, ManageFutureState>(
          builder: (context, state) {
            List<AllRepresentativeFuture> allRepresentative =
                context.watch<ManageFutureBloc>().allRepresentative;
            if (state is AllSeniorRepLoadingState) {
              return loadingFullScreen(context);
            }
            else if (state is AllSeniorRepErrorState) {
              return errorFullScreen(context,
                  func: () => BlocProvider.of<ManageFutureBloc>(context)
                      .add(AllSeniorRepFutureEvent()));
            }
            else  if (state is AllSeniorRepState) {
              allRepresentative = state.representatives;
            }
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {

                      },
                      child: Container(
                        margin: EdgeInsets.all(AppPadding.p8),
                        padding: EdgeInsets.all(AppPadding.p16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            //  ColorManager.secondaryColor6,
                            ColorManager.secondaryColor7,
                            ColorManager.secondaryColor7,
                            ColorManager.secondaryColor7,
                          ]),
                          color: ColorManager.white,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppSize.s8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${allRepresentative[index].name}",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Icon(Icons.circle,
                            color: ColorManager.error,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: allRepresentative.length,
                ),
              ),
            );

          },
        ),
      ],
    );
  }
}
