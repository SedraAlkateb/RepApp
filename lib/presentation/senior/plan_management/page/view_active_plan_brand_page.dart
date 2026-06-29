import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/senior/plan_management/bloc/plan_management_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewActivePlanBrandPage extends StatefulWidget {
  const ViewActivePlanBrandPage({super.key});

  @override
  State<ViewActivePlanBrandPage> createState() => _ViewActivePlanBrandPageState();
}

class _ViewActivePlanBrandPageState extends State<ViewActivePlanBrandPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanManagementBloc, PlanManagementState>(
      builder: (context, state) {
        if (state.status == PlanStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == PlanStatus.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                const SizedBox(height: 12),
                Text(
                  state.failure?.massage ?? "حدث خطأ غير متوقع",
                  style: const TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ],
            ),
          );
        }

        final List<PlanBrandSp> displayBrands = state.searchBrands;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: SearchField(
                searchController: searchController,
                onPressed: (value) {
                  context.read<PlanManagementBloc>().add(SearchPlanBrandEvent(value));
                },
              ),
            ),
            Expanded(
              child: displayBrands.isEmpty
                  ? emptyFullScreen(context, message: 'لا توجد نتائج مطابقة للبحث')
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: displayBrands.length,
                itemBuilder: (context, index) {
                  final brand = displayBrands[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: brand.brandType.color.withOpacity(0.08),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              brand.brandType.i == 2 ? Icons.handshake_outlined : Icons.ads_click,
                              color: brand.brandType.color,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  brand.titleAr,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  brand.phTitle,
                                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: brand.brandType.color.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    brand.brandType.name,
                                    style: TextStyle(
                                        color: brand.brandType.color,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 90,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black54, fontSize: 16),
                              key: ValueKey('${brand.id}_view'),
                              initialValue: brand.totalAmount == 0 ? '' : brand.totalAmount.toString(),
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: '0',
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                filled: true,
                                fillColor: Colors.grey[100],
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}