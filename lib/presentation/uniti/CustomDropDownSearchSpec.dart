import 'package:custom_dropdown_search/custom_dropdown_search.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Customdropdownsearchspec extends StatelessWidget {
  const Customdropdownsearchspec({Key? key,required this.validator,required this.onChanged,required this.items,this.icon
    ,required this.hintText
  ,
    required this.errorText
  }) : super(key: key);
  final FormFieldValidator<dynamic> validator;
  final ValueSetter<dynamic> onChanged;
  final List<dynamic> items;
  final String hintText;
  final String? errorText;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    bool tablet=false;
    tablet=MediaQuery.of(context).size.width>800;

    return    Container(
      decoration: BoxDecoration(
       
        borderRadius: BorderRadius.circular(15),
      ),
      
      width: MediaQuery.of(context).size.width,
     // height: MediaQuery.of(context).size.height /17,

      child: DropdownSearch<dynamic>(
        itemAsString: (dynamic value) => value.specModel.title,
        validator: validator,
        popupProps:  PopupProps.menu(
          itemBuilder: (context, item, isSelected) {
            return Column(
              children: [
                ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${item.specModel.title} '),
              Text('${item.hospitalSpModel.rate}'),
            ],
          ),
                  onTap: () {
                    onChanged(item);
                  },
                ),
                Divider(color:Colors.grey[200],height: 0.2,), // إضافة الفاصل هنا
              ],
            );
          },
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              //cursorWidth:MediaQuery.of(context).size.width* 0.4 ,
              decoration: InputDecoration(

                  border:InputBorder.none,
                  isDense: true,
                //  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  hintText: 'ابحث هنا',
                  hintStyle: TextStyle(fontSize: 1214.sp,overflow: TextOverflow.fade,),
                  prefixIcon: Icon(Icons.search,size: 20,color: ColorManager.black,)
              ),
            )
          //   showSelectedItems: true,
        ),
        items:items,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(fontSize: 1414.sp,overflow: TextOverflow.fade,),
          dropdownSearchDecoration: InputDecoration(
            icon:icon,
           labelStyle: TextStyle(fontSize:14.sp,overflow: TextOverflow.fade,),
            hintText:hintText ,
            hintStyle: TextStyle(fontSize: 12.sp,overflow: TextOverflow.fade,)

          ),

        ),

        onChanged: onChanged,

        //selectedItem: "Brazil",
      ),

    );
  }
}