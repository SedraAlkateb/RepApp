import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildHeaderSection(TextEditingController searchController,BuildContext context) {
  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25.r),
        bottomRight: Radius.circular(25.r),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 10,
          offset: const Offset(0, 5),
        )
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: SearchField(
            searchController: searchController,
            isIcon: false,
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () {
            if (searchController.text.isNotEmpty) {
              BlocProvider.of<SearchDoctorsBloc>(context).value==0?
              BlocProvider.of<SearchDoctorsBloc>(context)
                  .add(FutureSearchDocEvent(searchController.text)):
              BlocProvider.of<SearchDoctorsBloc>(context)
                  .add(FutureSearchHosEvent(searchController.text))
              ;
            }
          },
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.secondaryColor1,
                  ColorManager.secondaryColor1.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.secondaryColor1.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: const Center(
              child: Icon(Icons.search, color: Colors.white, size: 24),
            ),
          ),
        ),
      ],
    ),
  );
}