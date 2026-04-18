import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';

class DropDownChangePlan extends StatelessWidget {
  const DropDownChangePlan(
      {super.key,
        required this.hintText,
        required this.items,
        required this.onChanged,
        this.validator,
        this.width,
        this.value,
        this.onTap, required String errorText});
  final String hintText;
  final List<dynamic> items;
  final double? width;
  final ValueSetter<dynamic> onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<dynamic>? validator;
  final String? value;
  @override
  Widget build(BuildContext context) {
    bool tablet = MediaQuery.of(context).size.width > 800;
    return DropdownButtonFormField<dynamic>(
      elevation: 3,
      validator: validator,
      hint: Text(
        hintText,
        style:
        TextStyle(
          color: ColorManager.secondaryColor1,
          fontSize:17,
        ),        overflow: TextOverflow.fade,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        //  focusedBorder:InputBorder.none,
        border: InputBorder.none,
        isDense: true,
      ),
      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
      // borderRadius: BorderRadius.circular(20),
      isExpanded: true,
      items: items.map((dynamic val) {
        return DropdownMenuItem(
          value: val,
          onTap: onTap ?? () {},
          child: Text(
            "${val.name}",
            style: TextStyle(
              fontSize: tablet ? 19 : 14,
              color: Colors.black,
            ),
            softWrap: false,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      value: value,
    );
  }
}
