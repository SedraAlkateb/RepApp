import 'package:custom_dropdown_search/custom_dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownSearchNot extends StatelessWidget {
  const CustomDropDownSearchNot({
    Key? key,
    required this.validator,
    required this.onChanged,
    required this.items,
    this.icon,
    required this.hintText,
    required this.errorText,
  }) : super(key: key);
  

  final FormFieldValidator<dynamic> validator;
  final ValueSetter<dynamic> onChanged;
  final List<dynamic> items;
  final String hintText;
  final String? errorText;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    bool tablet = MediaQuery.of(context).size.width > 800;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      width: MediaQuery.of(context).size.width,
      child: DropdownSearch<dynamic>(
        itemAsString: (dynamic item) =>
            '${item.name}',
        validator: validator,
        popupProps: PopupProps.menu(
          itemBuilder: (context, item, isSelected) {
            return Column(
              children: [
                ListTile(
                  title: Text('${item.name}'),
                  onTap: () {
                    onChanged(item);
                  },
                ),
                Divider(color: Colors.grey[200], height: 0.2),
              ],
            );
          },
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              hintText: 'ابحث هنا',
              hintStyle: TextStyle(
                fontSize: tablet ? 17.sp : 12.sp,
                overflow: TextOverflow.fade,
              ),
              prefixIcon: Icon(Icons.search, size: 12),
            ),
          ),
        ),
        items: items,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(
            fontSize: tablet ? 19.sp : 14.sp,
            overflow: TextOverflow.fade,
          ),
          dropdownSearchDecoration: InputDecoration(
            icon: icon,
            labelStyle: TextStyle(
              fontSize: tablet ? 19.sp : 14.sp,
              overflow: TextOverflow.fade,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: tablet ? 17.sp : 12.sp,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
