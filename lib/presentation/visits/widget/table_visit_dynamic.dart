import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TableVisitDynamic extends StatelessWidget {
  const TableVisitDynamic({super.key,required this.selectBrand});
final  List<PharmacyBrandModel> selectBrand;
  @override
  Widget build(BuildContext context) {
    return selectBrand.isNotEmpty
        ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        border: TableBorder.all(
            width: 1,
            color: ColorManager.grey1,
            borderRadius: BorderRadius.all(
                Radius.circular(15))),
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
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text('نوع العينة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text('الكمية',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text('حذف العينة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold)),
                ),
              ),
            ],
          ),
          ...selectBrand
              .asMap()
              .entries
              .map((entry) {
            final index = entry.key;
            final brand = entry.value;
            TextEditingController amount =
            TextEditingController();
            amount.text = selectBrand[index]
                .amount
                .toString();
            return TableRow(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.all(8),
                  child: Text(
                    brand.title,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.all(8),
                  child: Text(brand.phTitle,
                      textAlign:
                      TextAlign.center),
                ),
                IntrinsicHeight(
                  child: TextField(
                    controller: amount,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        BlocProvider.of<
                            VisitBloc>(
                            context)
                            .add(
                            EditAmountBrandEvent(
                                index, 1));
                      } else {
                        BlocProvider.of<
                            VisitBloc>(
                            context)
                            .add(
                            EditAmountBrandEvent(
                                index,
                                int.parse(
                                    value)));
                      }
                    },
                    keyboardType:
                    TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '1',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelSmall,
                      errorText: null,
                      enabledBorder:
                      OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                          Colors.transparent,
                          width: AppSize.s1_5,
                        ),
                      ),
                      focusedBorder:
                      OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                          Colors.transparent,
                          width: AppSize.s1_5,
                        ),
                      ),
                      focusedErrorBorder:
                      OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                          Colors.transparent,
                          width: AppSize.s1_5,
                        ),
                      ),
                      fillColor:
                      ColorManager.white,
                      filled: true,
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.all(8.0),
                  child: Center(
                    child: IconButton(
                      color: const Color.fromARGB(
                          255, 155, 23, 14),
                      icon: Icon(
                          Icons.delete_forever),
                      onPressed: () {
                        BlocProvider.of<
                            VisitBloc>(
                            context)
                            .add(RemoveBrandEvent(
                            brand));
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
