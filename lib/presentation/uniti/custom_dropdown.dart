import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
class CustomDropDown extends StatelessWidget {

  const CustomDropDown({super.key,required this.hintText, required this.items, required this.prefixIcon,required this.onChanged,required this.validator,this.width,this.value,});
  final String hintText;
  final List<dynamic> items;
  final Icon? prefixIcon;
  final double? width;
  final ValueSetter<dynamic> onChanged;

  final FormFieldValidator<dynamic> validator;
  final String? value;
  @override
  Widget build(BuildContext context) {
    bool tablet=MediaQuery.of(context).size.width>800;
    return   DropdownButtonFormField<dynamic>(
      elevation: 3,
      validator: validator,
      hint: Text(
        hintText,style:  TextStyle(fontSize:tablet?17: 12,color: Colors.black),
        overflow: TextOverflow.fade,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorManager.secondaryColor3,
        prefixIcon: prefixIcon,
        //  focusedBorder:InputBorder.none,
        border:InputBorder.none,
        isDense: true,
      ),
      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
      // borderRadius: BorderRadius.circular(20),
      isExpanded: true,
      items: items.map(( dynamic val){
        return DropdownMenuItem(
            value: val,
            child: Row(
              children: [
                Text(val.title.toString(),style: TextStyle(fontSize: tablet?19:14,color: Colors.black)),
                Text(val.phTitle.toString(),style: TextStyle(fontSize: tablet?19:14,color: Colors.black)),

              ],
            ));
      }).toList(),
      onChanged: onChanged,
      onTap: (){
        // Workshop workshop = item as Workshop;
        //Navigator.pushNamed(context, workshopProfile,arguments:workshop.id );
      },
      value: value,
    );}}