import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/language_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableVisitDynamic extends StatefulWidget {
  const TableVisitDynamic({super.key, required this.selectBrand});
  final List<PharmacyBrandModel> selectBrand;

  @override
  State<TableVisitDynamic> createState() => _TableVisitDynamicState();
}

class _TableVisitDynamicState extends State<TableVisitDynamic> {
  // الربط بواسطة item.id بدلاً من index لضمان بقاء نفس الـ controller/FocusNode
  // عبر عمليات إعادة البناء (بدل إنشاء TextEditingController جديد بكل
  // rebuild، وهو اللي كان يسبب تعليق لوحة المفاتيح أثناء الكتابة).
  final Map<int, TextEditingController> _amountControllers = {};
  final Map<int, FocusNode> _amountFocusNodes = {};

  @override
  void dispose() {
    for (final controller in _amountControllers.values) {
      controller.dispose();
    }
    for (final focusNode in _amountFocusNodes.values) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectBrand.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(
                  width: 1,
                  color: ColorManager.grey1,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text('العينات',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text('الشكل الصيدلاني',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text('الكمية',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text('حذف العينة',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                ...widget.selectBrand.asMap().entries.map((entry) {
                  final index = entry.key;
                  final brand = entry.value;

                  final TextEditingController amount =
                      _amountControllers.putIfAbsent(
                    brand.id,
                    () => TextEditingController(text: brand.amount),
                  );
                  final FocusNode amountFocusNode =
                      _amountFocusNodes.putIfAbsent(
                    brand.id,
                    () => FocusNode(),
                  );

                  // تحديث نص الحقل من البيانات الخارجية فقط عندما لا يكون
                  // الحقل مركّزاً عليه حالياً، حتى لا نصطدم بحالة الـ IME
                  // الحيّة أثناء الكتابة (نفس سبب تعليق الكيبورد بصفحة تدقيق
                  // الخطة).
                  if (!amountFocusNode.hasFocus &&
                      amount.text != brand.amount) {
                    amount.text = brand.amount;
                    amount.selection = TextSelection.fromPosition(
                      TextPosition(offset: amount.text.length),
                    );
                  }

                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          brand.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(brand.phTitle, textAlign: TextAlign.center),
                      ),
                      IntrinsicHeight(
                        child: TextField(
                          controller: amount,
                          focusNode: amountFocusNode,
                          onChanged: (v) {
                            String value = convertArabicNumberToEnglish(v);
                            if (value.isEmpty) {
                              BlocProvider.of<VisitBloc>(context)
                                  .add(EditAmountBrandEvent(index, 1));
                            } else {
                              BlocProvider.of<VisitBloc>(context).add(
                                  EditAmountBrandEvent(
                                      index,
                                      int.parse(convertArabicNumberToEnglish(
                                          value))));
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '1',
                            hintStyle: Theme.of(context).textTheme.labelSmall,
                            errorText: null,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: AppSize.s1_5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: AppSize.s1_5,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: AppSize.s1_5,
                              ),
                            ),
                            fillColor: ColorManager.white,
                            filled: true,
                          ),
                          cursorColor: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: IconButton(
                            color: const Color.fromARGB(255, 155, 23, 14),
                            icon: Icon(Icons.delete_forever),
                            onPressed: () {
                              BlocProvider.of<VisitBloc>(context)
                                  .add(RemoveBrandEvent(brand));
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          )
        : SizedBox();
  }
}
