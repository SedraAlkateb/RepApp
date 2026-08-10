import 'package:domina_app/presentation/places/widget/hospital_archive/hospital_archive_responsive.dart';
import 'package:flutter/material.dart';

class HospitalArchive extends StatefulWidget {
  const HospitalArchive({super.key});

  @override
  State<HospitalArchive> createState() => _HospitalArchiveState();
}

class _HospitalArchiveState extends State<HospitalArchive> {
  final TextEditingController searchHospitalController =
  TextEditingController();

  @override
  void dispose() {
    searchHospitalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HospitalArchiveResponsive(
      searchController: searchHospitalController,
    );
  }
}