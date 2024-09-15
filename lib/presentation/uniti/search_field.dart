import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
class SearchField extends StatelessWidget {
   const SearchField({super.key,required this.searchController,this.onPressed});
  final TextEditingController searchController;
   final  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
              },
              decoration: InputDecoration(
                fillColor: ColorManager.white,
                  border:InputBorder.none,
                  isDense: true,
                prefixIcon:Icon(Icons.search,color: ColorManager.secondaryColor1,size: AppSize.s28,) ,
                contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
                  focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  hintText: 'ابحث هنا ....',
                  hintStyle: const TextStyle(fontSize: AppSize.s16,overflow: TextOverflow.fade ),
              ),
            ),
          ),
       //   IconButton(onPressed:onPressed , icon: Icon(Icons.search,color: ColorManager.secondaryColor,size: AppSize.s28,))
        ],
      ),
    );
  }
}
