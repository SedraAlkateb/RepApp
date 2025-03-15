import 'package:domina_app/domain/models/models.dart';
import 'package:flutter/material.dart';
class TableVisitStatic extends StatelessWidget {
  const TableVisitStatic({super.key,required this.selectBrand});
final  List<PharmacyBrandModel> selectBrand;
  @override
  Widget build(BuildContext context) {
    return selectBrand.isNotEmpty
        ? Padding(
        padding:
        const EdgeInsets.all(8.0),
        child: Table(
            border: TableBorder.all(),
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets
                        .all(8.0),
                    child: Center(
                      child: Text(
                          'العينات',
                          style: TextStyle(
                              fontWeight:
                              FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets
                        .all(8.0),
                    child: Center(
                      child: Text(
                          'نوع العينة',
                          style: TextStyle(
                              fontWeight:
                              FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets
                        .all(8.0),
                    child: Center(
                      child: Text(
                          'الكمية',
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
                //    final index = entry.key;
                final brand =
                    entry.value;
                return TableRow(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets
                          .only(
                          top: 8),
                      child: Text(
                        brand.title,
                        textAlign:
                        TextAlign
                            .center,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets
                          .only(
                          top: 8),
                      child: Text(
                          brand
                              .phTitle,
                          textAlign:
                          TextAlign
                              .center),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets
                          .only(
                          top: 8),
                      child: Text(
                        brand.amount
                            .toString(),
                        textAlign:
                        TextAlign
                            .center,
                      ),
                    ),
                  ],
                );
              })
            ]))
        : SizedBox();;
  }
}
