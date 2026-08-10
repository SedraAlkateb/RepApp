import 'package:domina_app/presentation/places/widget/doctor_archive/doctor_archive_responsive.dart';
import 'package:flutter/material.dart';

class DoctorArchive extends StatefulWidget {
  const DoctorArchive({super.key});

  @override
  State<DoctorArchive> createState() => _DoctorArchiveState();
}

class _DoctorArchiveState extends State<DoctorArchive> {
  final TextEditingController searchDocController =
  TextEditingController();

  @override
  void dispose() {
    searchDocController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoctorArchiveResponsive(
      searchController: searchDocController,
    );
  }
}