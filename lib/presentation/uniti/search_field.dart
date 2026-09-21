import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.searchController,
    this.onPressed,
    this.isIcon,
    this.hintText = 'ابحث هنا',
  });

  final TextEditingController searchController;
  final Function(String)? onPressed;
  final bool? isIcon;
  final String hintText;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  Animation<double>? _secondaryAnimation;
  TabController? _tabController;
  int? _lastTabIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      _secondaryAnimation?.removeListener(_onRouteAnimationChanged);
      _secondaryAnimation = route.secondaryAnimation;
      _secondaryAnimation?.addListener(_onRouteAnimationChanged);
    }

    final tabController = DefaultTabController.maybeOf(context);
    if (tabController != _tabController) {
      _tabController?.removeListener(_onTabChanged);
      _tabController = tabController;
      _lastTabIndex = tabController?.index;
      _tabController?.addListener(_onTabChanged);
    }
  }

  void _onRouteAnimationChanged() {
    // عندما تعود الصفحة للظهور (إغلاق الصفحة التي فوقها وعودة الأنيميشن إلى 0)
    if (_secondaryAnimation != null && _secondaryAnimation!.value == 0.0) {
      _resetSearch();
    }
  }

  void _onTabChanged() {
    // عند الانتقال من تاب لتاب نفرّغ البحث ونعيد القائمة الأساسية
    final index = _tabController?.index;
    if (index != _lastTabIndex) {
      _lastTabIndex = index;
      _resetSearch();
    }
  }

  void _resetSearch() {
    if (widget.searchController.text.isEmpty) return;
    widget.searchController.clear();
    widget.onPressed?.call(''); // نص فارغ لإعادة القائمة الكاملة في البلوك
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _secondaryAnimation?.removeListener(_onRouteAnimationChanged);
    _tabController?.removeListener(_onTabChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double fontSize;
    double iconSize;
    double horizontalPadding;
    double verticalPadding;
    double borderRadius;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        fontSize = 15;
        iconSize = 23;
        horizontalPadding = 16;
        verticalPadding = 14;
        borderRadius = 12;
        break;

      case AppDeviceType.tabletPortrait:
        fontSize = 17;
        iconSize = 26;
        horizontalPadding = 20;
        verticalPadding = 17;
        borderRadius = 14;
        break;

      case AppDeviceType.tabletLandscape:
        fontSize = 16;
        iconSize = 25;
        horizontalPadding = 20;
        verticalPadding = 15;
        borderRadius = 14;
        break;
    }

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: TextFormField(
          controller: widget.searchController,
          textInputAction: TextInputAction.search,
          onChanged: widget.onPressed,
          onFieldSubmitted: widget.onPressed,
          style: TextStyle(
            fontSize: fontSize,
            color: ColorManager.medicalText,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: fontSize,
              color: ColorManager.medicalMuted,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: ColorManager.white,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // زر مسح يظهر تلقائياً إذا كان هناك نص في البحث
                if (widget.searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    color: ColorManager.medicalMuted,
                    onPressed: () {
                      widget.searchController.clear();
                      if (widget.onPressed != null) {
                        widget.onPressed!('');
                      }
                      setState(() {});
                    },
                  ),
                if (widget.isIcon == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.search_rounded,
                      color: ColorManager.medicalMuted,
                      size: iconSize,
                    ),
                  ),
              ],
            ),
            suffixIconConstraints: BoxConstraints(
              minWidth: iconSize + 30,
              minHeight: iconSize + 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: ColorManager.medicalBorder,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: ColorManager.medicalBorder,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: ColorManager.medicalPrimary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}