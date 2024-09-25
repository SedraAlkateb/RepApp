import 'package:custom_dropdown_search/custom_dropdown_search.dart';
import 'package:flutter/material.dart';


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
        itemAsString: (dynamic value) => value.title,
        validator: validator,
        popupProps:  PopupProps.menu(
          itemBuilder: (context, item, isSelected) {
            return Column(
              children: [
                ListTile(
          title: Text('${item.title}'),
                  onTap: () {
                    onChanged(item);
                  },
                ),
                Divider(color:Colors.grey[200],height: 0.2,), // إضافة الفاصل هنا
              ],
            );
          },

          errorBuilder: (context, searchEntry, exception) =>
              Container(
             //   height: MediaQuery.of(context).size.height /17,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.red.withOpacity(0.2),
            child: Text(
              searchEntry.toString(),
              style: TextStyle(color: Colors.white,fontSize:tablet?19: 14,overflow: TextOverflow.fade,),
            ),
          ),
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              //cursorWidth:MediaQuery.of(context).size.width* 0.4 ,
              decoration: InputDecoration(
                  border:InputBorder.none,
                  isDense: true,
                //  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  hintText: 'ابحث هنا',
                  hintStyle: TextStyle(fontSize: tablet?17:12,overflow: TextOverflow.fade,),
                  prefixIcon: Icon(Icons.search,size: 12,)
              ),
            )
          //   showSelectedItems: true,
        ),
        items:items,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(fontSize:tablet?19: 14,overflow: TextOverflow.fade,),
          dropdownSearchDecoration: InputDecoration(
            icon:icon,
           labelStyle: TextStyle(fontSize:tablet?19:  14,overflow: TextOverflow.fade,),
            hintText:hintText ,
            hintStyle: TextStyle(fontSize:tablet?17:  12,overflow: TextOverflow.fade,)

          ),

        ),

        onChanged: onChanged,

        //selectedItem: "Brazil",
      ),

    );
  }
}