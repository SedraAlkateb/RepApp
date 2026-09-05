import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/uniti/search_field.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// =======================================================
// Inventory Card
// =======================================================

class InventoryCard extends StatelessWidget {
  final InventoryModel data;

  const InventoryCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

    // =====================================================
    // Inventory Values
    // =====================================================
    final int total =
        int.tryParse(data.total) ?? 0;

    final int used =
        int.tryParse(data.used) ?? 0;

    final int rest = data.rest;

    // =====================================================
    // Progress
    // =====================================================
    final double usePercent =
    total == 0
        ? 0.0
        : (used / total).clamp(
      0.0,
      1.0,
    );

    final int percentage =
    (usePercent * 100).round();

    // =====================================================
    // Responsive Values
    // =====================================================

    double cardBottomSpacing;

    double cardRadius;

    double headerHorizontalPadding;
    double headerVerticalPadding;

    double contentPadding;

    double iconBoxSize;
    double iconSize;
    double iconRadius;
    double iconSpacing;

    double titleFontSize;

    double infoLabelFontSize;
    double infoValueFontSize;

    double infoVerticalPadding;
    double infoRadius;

    double sectionSpacing;

    double progressHeight;
    double progressLabelFontSize;
    double progressPercentFontSize;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        cardBottomSpacing = 12;

        cardRadius = 18;

        headerHorizontalPadding = 14;
        headerVerticalPadding = 12;

        contentPadding = 15;

        iconBoxSize = 40;
        iconSize = 21;
        iconRadius = 11;
        iconSpacing = 10;

        titleFontSize = 15;

        infoLabelFontSize = 10.5;
        infoValueFontSize = 18;

        infoVerticalPadding = 10;
        infoRadius = 12;

        sectionSpacing = 16;

        progressHeight = 7;
        progressLabelFontSize = 10.5;
        progressPercentFontSize = 11;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        cardBottomSpacing = 14;

        cardRadius = 20;

        headerHorizontalPadding = 18;
        headerVerticalPadding = 15;

        contentPadding = 20;

        iconBoxSize = 48;
        iconSize = 25;
        iconRadius = 13;
        iconSpacing = 14;

        titleFontSize = 18;

        infoLabelFontSize = 12;
        infoValueFontSize = 22;

        infoVerticalPadding = 13;
        infoRadius = 14;

        sectionSpacing = 20;

        progressHeight = 8;
        progressLabelFontSize = 12;
        progressPercentFontSize = 13;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        cardBottomSpacing = 12;

        cardRadius = 18;

        headerHorizontalPadding = 16;
        headerVerticalPadding = 12;

        contentPadding = 17;

        iconBoxSize = 44;
        iconSize = 23;
        iconRadius = 12;
        iconSpacing = 12;

        titleFontSize = 17;

        infoLabelFontSize = 11;
        infoValueFontSize = 20;

        infoVerticalPadding = 11;
        infoRadius = 13;

        sectionSpacing = 17;

        progressHeight = 7;
        progressLabelFontSize = 11;
        progressPercentFontSize = 12;
        break;
    }

    return Directionality(
      textDirection: TextDirection.rtl,

      child: Container(
        margin: EdgeInsets.only(
          bottom: cardBottomSpacing,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(
            cardRadius,
          ),

          border: Border.all(
            color: const Color(
              0xFFE2E8F0,
            ),
          ),

          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withOpacity(
                0.025,
              ),
              blurRadius: 12,
              offset: const Offset(
                0,
                4,
              ),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius:
          BorderRadius.circular(
            cardRadius - 1,
          ),

          child: Column(
            mainAxisSize:
            MainAxisSize.min,

            children: [
              // =================================================
              // Header
              // =================================================
              Container(
                width: double.infinity,

                padding:
                EdgeInsets.symmetric(
                  horizontal:
                  headerHorizontalPadding,
                  vertical:
                  headerVerticalPadding,
                ),

                color: ColorManager
                    .medicalSecondary
                    .withOpacity(
                  0.08,
                ),

                child: Row(
                  children: [
                    // =============================================
                    // Icon
                    // =============================================
                    Container(
                      width:
                      iconBoxSize,
                      height:
                      iconBoxSize,

                      alignment:
                      Alignment.center,

                      decoration:
                      BoxDecoration(
                        color:
                        Colors.white,

                        borderRadius:
                        BorderRadius.circular(
                          iconRadius,
                        ),

                        border:
                        Border.all(
                          color: ColorManager
                              .medicalSecondary
                              .withOpacity(
                            0.12,
                          ),
                        ),
                      ),

                      child: Icon(
                        Icons
                            .medication_liquid_outlined,

                        color: ColorManager
                            .medicalSecondary,

                        size:
                        iconSize,
                      ),
                    ),

                    SizedBox(
                      width:
                      iconSpacing,
                    ),

                    // =============================================
                    // Product Name
                    // =============================================
                    Expanded(
                      child: Text(
                        data.title,

                        maxLines: 2,

                        overflow:
                        TextOverflow
                            .ellipsis,

                        style:
                        TextStyle(
                          fontSize:
                          titleFontSize,

                          fontWeight:
                          FontWeight
                              .w700,

                          height: 1.25,

                          color:
                          const Color(
                            0xFF1F4E79,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    // =============================================
                    // Existing Type Badge
                    // =============================================
                    Type.buildBadge(
                      data.type,
                    ),
                  ],
                ),
              ),

              // =================================================
              // Content
              // =================================================
              Padding(
                padding: EdgeInsets.all(
                  contentPadding,
                ),

                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,

                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,

                  children: [
                    // ===========================================
                    // Inventory Numbers
                    // ===========================================
                    Row(
                      children: [
                        Expanded(
                          child:
                          _buildInfoItem(
                            label:
                            "الكل",

                            value:
                            total.toString(),

                            color:
                            const Color(
                              0xFF475569,
                            ),

                            backgroundColor:
                            const Color(
                              0xFFF8FAFC,
                            ),

                            labelFontSize:
                            infoLabelFontSize,

                            valueFontSize:
                            infoValueFontSize,

                            verticalPadding:
                            infoVerticalPadding,

                            radius:
                            infoRadius,
                          ),
                        ),

                        const SizedBox(
                          width: 8,
                        ),

                        Expanded(
                          child:
                          _buildInfoItem(
                            label:
                            "الموزع",

                            value:
                            used.toString(),

                            color:
                            const Color(
                              0xFF2E7D32,
                            ),

                            backgroundColor:
                            const Color(
                              0xFFF0FDF4,
                            ),

                            labelFontSize:
                            infoLabelFontSize,

                            valueFontSize:
                            infoValueFontSize,

                            verticalPadding:
                            infoVerticalPadding,

                            radius:
                            infoRadius,
                          ),
                        ),

                        const SizedBox(
                          width: 8,
                        ),

                        Expanded(
                          child:
                          _buildInfoItem(
                            label:
                            "المتبقي",

                            value:
                            rest.toString(),

                            color:
                            const Color(
                              0xFFD97706,
                            ),

                            backgroundColor:
                            const Color(
                              0xFFFFF7ED,
                            ),

                            labelFontSize:
                            infoLabelFontSize,

                            valueFontSize:
                            infoValueFontSize,

                            verticalPadding:
                            infoVerticalPadding,

                            radius:
                            infoRadius,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      sectionSpacing,
                    ),

                    // ===========================================
                    // Divider
                    // ===========================================
                    Container(
                      height: 1,

                      color:
                      const Color(
                        0xFFF1F5F9,
                      ),
                    ),

                    SizedBox(
                      height:
                      sectionSpacing,
                    ),

                    // ===========================================
                    // Progress Header
                    // ===========================================
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "نسبة توزيع العينات",

                            maxLines: 1,

                            overflow:
                            TextOverflow
                                .ellipsis,

                            style:
                            TextStyle(
                              fontSize:
                              progressLabelFontSize,

                              color: Colors
                                  .grey
                                  .shade600,

                              fontWeight:
                              FontWeight
                                  .w500,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        Container(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),

                          decoration:
                          BoxDecoration(
                            color: ColorManager
                                .medicalSecondary
                                .withOpacity(
                              0.10,
                            ),

                            borderRadius:
                            BorderRadius
                                .circular(
                              7,
                            ),
                          ),

                          child: Text(
                            "$percentage%",

                            style:
                            TextStyle(
                              fontSize:
                              progressPercentFontSize,

                              fontWeight:
                              FontWeight
                                  .w700,

                              color: ColorManager
                                  .medicalSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // ===========================================
                    // Progress Bar
                    // ===========================================
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(
                        10,
                      ),

                      child:
                      LinearProgressIndicator(
                        value:
                        usePercent,

                        minHeight:
                        progressHeight,

                        backgroundColor:
                        const Color(
                          0xFFF1F5F9,
                        ),

                        valueColor:
                        AlwaysStoppedAnimation<
                            Color>(
                          ColorManager
                              .medicalSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Inventory Number Item
  // =====================================================

  Widget _buildInfoItem({
    required String label,
    required String value,
    required Color color,
    required Color backgroundColor,
    required double labelFontSize,
    required double valueFontSize,
    required double verticalPadding,
    required double radius,
  }) {
    return Container(
      padding:
      EdgeInsets.symmetric(
        horizontal: 6,
        vertical:
        verticalPadding,
      ),

      decoration:
      BoxDecoration(
        color:
        backgroundColor,

        borderRadius:
        BorderRadius.circular(
          radius,
        ),
      ),

      child: Column(
        mainAxisSize:
        MainAxisSize.min,

        children: [
          Text(
            label,

            maxLines: 1,

            overflow:
            TextOverflow.ellipsis,

            style: TextStyle(
              fontSize:
              labelFontSize,

              color:
              Colors.grey.shade600,

              fontWeight:
              FontWeight.w500,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(
            value,

            maxLines: 1,

            overflow:
            TextOverflow.ellipsis,

            style: TextStyle(
              fontSize:
              valueFontSize,

              height: 1,

              fontWeight:
              FontWeight.w800,

              color:
              color,
            ),
          ),
        ],
      ),
    );
  }
}

// =======================================================
// Report Inventory
// =======================================================

class ReportInventory extends StatelessWidget {
  ReportInventory({
    super.key,
  });

  final TextEditingController searchInventoryController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(
        0xFFF8FAFC,
      ),

      appBar: AppBar(
        title:
        const Text(
          'تقرير توزيع العينات ( الجرد )',
        ),
      ),

      body:
      bodyBuild(context),
    );
  }

  Widget bodyBuild(
      BuildContext context,
      ) {
    final deviceType =
    AppResponsive.deviceType(context);

    double pageMaxWidth;

    double horizontalPadding;

    double searchTopPadding;
    double searchBottomPadding;

    double listTopPadding;
    double listBottomPadding;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;

        searchTopPadding = 14;
        searchBottomPadding = 8;

        listTopPadding = 6;
        listBottomPadding = 24;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        horizontalPadding = 28;

        searchTopPadding = 18;
        searchBottomPadding = 10;

        listTopPadding = 8;
        listBottomPadding = 30;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        horizontalPadding = 32;

        searchTopPadding = 14;
        searchBottomPadding = 8;

        listTopPadding = 6;
        listBottomPadding = 28;
        break;
    }

    return BlocBuilder<
        ReportInventoryBloc,
        ReportInventoryState>(
      builder: (context, state) {
        // =================================================
        // Success
        // =================================================
        if (state
        is SenAllInventoryState) {
          final List inventoryModel =
              state.inventoryModel;

          return Center(
            child: ConstrainedBox(
              constraints:
              BoxConstraints(
                maxWidth:
                pageMaxWidth,
              ),

              child: Column(
                children: [
                  // =============================================
                  // Search
                  // =============================================
                  Padding(
                    padding:
                    EdgeInsets.fromLTRB(
                      horizontalPadding,
                      searchTopPadding,
                      horizontalPadding,
                      searchBottomPadding,
                    ),

                    child:
                    SearchField(
                      searchController:
                      searchInventoryController,

                      onPressed:
                          (value) {
                        BlocProvider.of<
                            ReportInventoryBloc>(
                          context,
                        ).add(
                          SenSearchInventoryEvent(
                            value,
                          ),
                        );
                      },
                    ),
                  ),

                  // =============================================
                  // Empty
                  // =============================================
                  if (inventoryModel
                      .isEmpty)
                    Expanded(
                      child:
                      emptyFullScreen(
                        context,
                      ),
                    )

                  // =============================================
                  // List
                  // =============================================
                  else
                    Expanded(
                      child:
                      ListView.builder(
                        keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior
                            .onDrag,

                        padding:
                        EdgeInsets.fromLTRB(
                          horizontalPadding,
                          listTopPadding,
                          horizontalPadding,
                          listBottomPadding,
                        ),

                        itemCount:
                        inventoryModel.length,

                        itemBuilder:
                            (context, index) {
                          return InventoryCard(
                            data:
                            inventoryModel[
                            index],
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        }

        // =================================================
        // Loading
        // =================================================
        if (state
        is SenAllInventoryLoadingState) {
          return loadingFullScreen(
            context,
          );
        }

        // =================================================
        // Error
        // =================================================
        if (state
        is SenAllInventoryErrorState) {
          return errorFullScreen(
            context,

            func: () {
              BlocProvider.of<
                  ReportInventoryBloc>(
                context,
              ).add(
                SenAllInventoryEvent(
                  203,
                  state.planId,
                ),
              );
            },
          );
        }

        return const SizedBox
            .shrink();
      },
    );
  }
}