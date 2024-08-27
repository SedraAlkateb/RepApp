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
      padding: const EdgeInsets.symmetric(vertical: 14),
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
                  //  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  hintText: 'Search here....',

                  hintStyle: const TextStyle(fontSize: 12,overflow: TextOverflow.fade,),
              ),
            ),
          ),
          IconButton(onPressed:onPressed , icon: Icon(Icons.search,color: ColorManager.secondaryColor,size: AppSize.s28,))
        ],
      ),
    );
  }
}
