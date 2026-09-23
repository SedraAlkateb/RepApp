import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/uniti/num_list.dart';
import 'package:domina_app/presentation/uniti/string_utils_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showHosDocSearchDialog({
  required BuildContext context,
  required String title,
  required bool isHospital,
}) {
  final bloc = BlocProvider.of<FutureRepBloc>(context);

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: bloc,
        child: _HosDocSearchDialogView(title: title, isHospital: isHospital),
      );
    },
  );
}

class _HosDocSearchDialogView extends StatefulWidget {
  final String title;
  final bool isHospital;

  const _HosDocSearchDialogView({
    required this.title,
    required this.isHospital,
  });

  @override
  State<_HosDocSearchDialogView> createState() => _HosDocSearchDialogViewState();
}

class _HosDocSearchDialogViewState extends State<_HosDocSearchDialogView> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FutureRepBloc, FutureRepState>(
      builder: (context, state) {
        final deviceType = AppResponsive.deviceType(context);
        double dialogWidth = deviceType == AppDeviceType.mobilePortrait ? double.infinity : 600;

        bool isLoading = state is DocHosSpSearchLoadingState;
        bool isFailure = state is DocHosSpSearchFailureState;

        // استخراج القائمة الأصلية من الـ State
        List<HosDocSpSearchModel> items = [];
        if (state is DocHosSpSearchState) {
          items = state.items;
        }

        // تصفية القائمة بناءً على نص البحث (البحث بالاسم أو عدد الزيارات)
        final filteredItems = items.where((item) {
          final nameMatch = item.name.toLowerCase().contains(searchQuery.toLowerCase());
          final visitsMatch = item.visits.toString().contains((searchQuery.toEnglishNumbers()));
          final placeMatch = item.placeTitle.toLowerCase().contains(searchQuery.toLowerCase());
          return nameMatch || visitsMatch || placeMatch;
        }).toList();

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: dialogWidth,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ================= Header =================
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          widget.isHospital ? Icons.local_hospital_outlined : Icons.person_outline_rounded,
                          color: const Color(0xFF1F4E79),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Color(0xFF64748B)),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFFE2E8F0), height: 1),
                  const SizedBox(height: 12),

                  // ================= Search Bar =================
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.trim();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "ابحث بالاسم، المكان، أو عدد الزيارات...",
                      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF1F4E79), size: 20),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFF1F4E79), width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  widget.isHospital?
          buildTotalReportsCard(filteredItems
              .length, "عدد المشافي والشعب", "في هذا الاختصاص")
                  : buildTotalReportsCard(filteredItems
                      .length, "عدد الأطباء", "في هذا الاختصاص")


                  ,
                  const SizedBox(height: 12),
                  // ================= Body =================
                  Expanded(
                    child: isLoading
                        ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(
                          color: Color(0xFF1F4E79),
                        ),
                      ),
                    )
                        : isFailure
                        ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          "حدث خطأ أثناء جلب البيانات، يرجى المحاولة لاحقاً.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.redAccent, fontSize: 14),
                        ),
                      ),
                    )
                        : filteredItems.isEmpty
                        ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          "لا توجد نتائج مطابقة للبحث",
                          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        ),
                      ),
                    )
                        : ListView.separated(
                      shrinkWrap: true,
                      itemCount: filteredItems.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return _buildSearchItemCard(item, widget.isHospital);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// بطاقة عنصر فردي داخل القائمة
Widget _buildSearchItemCard(HosDocSpSearchModel item, bool isHospital) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1F4E79).withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            isHospital ? Icons.business_outlined : Icons.medical_services_outlined,
            color: const Color(0xFF1F4E79),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.category_outlined, size: 13, color: Color(0xFF64748B)),
                  const SizedBox(width: 4),
                  Text(
                    item.spTitle,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.location_on_outlined, size: 13, color: Color(0xFF64748B)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      item.placeTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  _infoChip(Icons.star_outline, "التقييم: ${item.rate}", Colors.amber.shade700),
                  const SizedBox(width: 8),
                  _infoChip(Icons.repeat, "الزيارات: ${item.visits}", const Color(0xFF2563EB)),
                  if (item.totalDocs != null) ...[
                    const SizedBox(width: 8),
                    _infoChip(Icons.people_outline, "الأطباء: ${item.totalDocs}", const Color(0xFF0D9488)),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _infoChip(IconData icon, String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: color),
        const SizedBox(width: 3),
        Text(
          text,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    ),
  );
}