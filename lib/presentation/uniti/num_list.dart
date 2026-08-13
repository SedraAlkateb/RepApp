import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

Widget buildTotalReportsCard(
    int length,
    String title1,
    String? title2,
    ) {
  return Builder(
    builder: (context) {
      final deviceType =
      AppResponsive.deviceType(context);

      double verticalMargin;

      double cardPadding;
      double cardRadius;

      double iconBoxSize;
      double iconSize;
      double iconRadius;
      double iconSpacing;

      double titleFontSize;
      double subtitleFontSize;

      double counterHorizontalPadding;
      double counterVerticalPadding;
      double counterRadius;
      double counterFontSize;

      switch (deviceType) {
      // =================================================
      // Mobile
      // =================================================
        case AppDeviceType.mobilePortrait:
          verticalMargin = 6;

          cardPadding = 12;
          cardRadius = 18;

          iconBoxSize = 44;
          iconSize = 21;
          iconRadius = 12;
          iconSpacing = 12;

          titleFontSize = 14;
          subtitleFontSize = 11;

          counterHorizontalPadding = 14;
          counterVerticalPadding = 8;
          counterRadius = 12;
          counterFontSize = 18;
          break;

      // =================================================
      // Tablet Portrait
      // =================================================
        case AppDeviceType.tabletPortrait:
          verticalMargin = 8;

          cardPadding = 16;
          cardRadius = 20;

          iconBoxSize = 52;
          iconSize = 25;
          iconRadius = 14;
          iconSpacing = 15;

          titleFontSize = 17;
          subtitleFontSize = 13;

          counterHorizontalPadding = 18;
          counterVerticalPadding = 10;
          counterRadius = 14;
          counterFontSize = 22;
          break;

      // =================================================
      // Tablet Landscape
      // =================================================
        case AppDeviceType.tabletLandscape:
          verticalMargin = 6;

          cardPadding = 14;
          cardRadius = 18;

          iconBoxSize = 48;
          iconSize = 23;
          iconRadius = 13;
          iconSpacing = 14;

          titleFontSize = 16;
          subtitleFontSize = 12;

          counterHorizontalPadding = 16;
          counterVerticalPadding = 8;
          counterRadius = 13;
          counterFontSize = 20;
          break;
      }

      final bool hasSubtitle =
          title2 != null &&
              title2.trim().isNotEmpty;

      return Padding(
        // ما عاد في horizontal padding
        // لأن القائمة الأم هي اللي بتتحكم فيه
        padding: EdgeInsets.symmetric(
          vertical: verticalMargin,
        ),

        child: Container(
          width: double.infinity,

          padding: EdgeInsets.all(
            cardPadding,
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
                color: Colors.black
                    .withOpacity(0.025),
                blurRadius: 12,
                offset: const Offset(
                  0,
                  4,
                ),
              ),
            ],
          ),

          child: Row(
            children: [
              // =================================================
              // Icon
              // =================================================
              Container(
                width: iconBoxSize,
                height: iconBoxSize,

                alignment:
                Alignment.center,

                decoration:
                BoxDecoration(
                  color: const Color(
                    0xFFEFF6FF,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    iconRadius,
                  ),
                ),

                child: Icon(
                  Icons
                      .description_outlined,

                  size: iconSize,

                  color: const Color(
                    0xFF1F4E79,
                  ),
                ),
              ),

              SizedBox(
                width: iconSpacing,
              ),

              // =================================================
              // Title
              // =================================================
              Expanded(
                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,

                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  children: [
                    Text(
                      title1,

                      maxLines: 2,

                      overflow:
                      TextOverflow
                          .ellipsis,

                      style: TextStyle(
                        fontSize:
                        titleFontSize,

                        fontWeight:
                        FontWeight.w700,

                        color:
                        const Color(
                          0xFF1F4E79,
                        ),

                        height: 1.25,
                      ),
                    ),

                    if (hasSubtitle) ...[
                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        title2,

                        maxLines: 1,

                        overflow:
                        TextOverflow
                            .ellipsis,

                        style:
                        TextStyle(
                          fontSize:
                          subtitleFontSize,

                          color: Colors
                              .grey
                              .shade600,

                          fontWeight:
                          FontWeight
                              .w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              // =================================================
              // Total Number
              // =================================================
              Container(
                constraints:
                const BoxConstraints(
                  minWidth: 48,
                ),

                padding:
                EdgeInsets.symmetric(
                  horizontal:
                  counterHorizontalPadding,
                  vertical:
                  counterVerticalPadding,
                ),

                decoration:
                BoxDecoration(
                  color: const Color(
                    0xFFDBEAFE,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    counterRadius,
                  ),
                ),

                child: Text(
                  "$length",

                  textAlign:
                  TextAlign.center,

                  style: TextStyle(
                    fontSize:
                    counterFontSize,

                    height: 1,

                    fontWeight:
                    FontWeight.w800,

                    color: const Color(
                      0xFF2563EB,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}