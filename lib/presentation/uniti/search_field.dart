import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {
  const SearchField(

      {super.key, required this.searchController, this.onPressed,this.isIcon});
  final TextEditingController searchController;
  final Function(String)? onPressed;
  final bool? isIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric( horizontal: 8.w),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(

              controller: searchController,
              onChanged: onPressed,

              decoration: InputDecoration(
                fillColor: ColorManager.white,
                border: InputBorder.none,
                isDense: true,
                suffixIcon:isIcon==true? Icon(
                  Icons.search,
                  color: ColorManager.medicalMuted,
                  size: AppSize.s28,
                ):null,

                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.medicalBorder),
                    borderRadius:
                        BorderRadius.all(
                            Radius.circular(AppSize.s12))),

                hintText: 'ابحث هنا',
                hintStyle: TextStyle(
                    fontSize: 16.sp, overflow: TextOverflow.fade),
              ),
            ),
          ),
          //   IconButton(onPressed:onPressed , icon: Icon(Icons.search,color: ColorManager.secondaryColor,size: AppSize.s28,))
        ],
      ),
    );
  }
}
