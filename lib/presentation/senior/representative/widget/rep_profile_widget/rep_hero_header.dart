import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';


// =====================================================
// Hero
// Mobile + Tablet Portrait
// =====================================================

Widget buildHeroHeader(
    BuildContext context,
    InfoRep rep, {
  required bool isFinal,
}) {
  final ui =
  AppUi.of(context);

  // =====================================================
  // Hero-specific dimensions.
  //
  // هدول خاصين بالـHero لذلك ما لازم نحول AppUi
  // لمخزن لكل رقم بالمشروع.
  // =====================================================

  final double verticalPadding =
  ui.isMobile
      ? 28
      : 34;

  final double horizontalPadding =
  ui.isMobile
      ? 20
      : 28;

  final double avatarSize =
  ui.isMobile
      ? 80
      : 92;

  final double avatarRadius =
  ui.isMobile
      ? 22
      : 26;

  final double initialFontSize =
  ui.isMobile
      ? 30
      : 34;

  final double nameFontSize =
  ui.isMobile
      ? 22
      : 26;

  final double addressFontSize =
  ui.isMobile
      ? 13
      : 15;

  return Hero(
    tag:
    'rep_card_${rep.id}',

    child: Material(
      color:
      Colors.transparent,

      child: Container(
        width:
        double.infinity,

        padding:
        EdgeInsets.symmetric(
          vertical:
          verticalPadding,

          horizontal:
          horizontalPadding,
        ),

        decoration:
        BoxDecoration(
          // ===============================================
          // الهوية الأساسية للبروفايل
          // ===============================================
          color:
          const Color(
            0xFF164683,
          ),

          borderRadius:
          BorderRadius.circular(
            ui.cardRadius + 6,
          ),

          boxShadow: [
            BoxShadow(
              color:
              const Color(
                0xFF1F4E79,
              ).withOpacity(
                0.14,
              ),

              blurRadius:
              14,

              offset:
              const Offset(
                0,
                6,
              ),
            ),
          ],
        ),

        child: Column(
          mainAxisSize:
          MainAxisSize.min,

          children: [
            // =================================================
            // Avatar
            // =================================================
            Container(
              width:
              avatarSize,

              height:
              avatarSize,

              alignment:
              Alignment.center,

              decoration:
              BoxDecoration(
                color:
                Colors.white
                    .withOpacity(
                  0.14,
                ),

                border:
                Border.all(
                  color:
                  Colors.white
                      .withOpacity(
                    0.25,
                  ),

                  width:
                  1.5,
                ),

                borderRadius:
                BorderRadius.circular(
                  avatarRadius,
                ),
              ),

              child: Text(
                rep.name.isNotEmpty
                    ? rep.name
                    .substring(
                  0,
                  1,
                )
                    : "",

                style:
                TextStyle(
                  fontSize:
                  initialFontSize,

                  color:
                  Colors.white,

                  fontWeight:
                  FontWeight
                      .w900,
                ),
              ),
            ),

            SizedBox(
              height:
              ui.largeSpacing,
            ),

            // =================================================
            // Name
            // =================================================
            Text(
              rep.name,

              textAlign:
              TextAlign.center,

              maxLines:
              2,

              overflow:
              TextOverflow
                  .ellipsis,

              style:
              TextStyle(
                fontSize:
                nameFontSize,

                color:
                Colors.white,

                fontWeight:
                FontWeight
                    .w700,

                height:
                1.25,
              ),
            ),

            // =================================================
            // Address
            // =================================================
            if (rep
                .address
                .isNotEmpty) ...[
              SizedBox(
                height:
                ui.mediumSpacing,
              ),

              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .center,

                children: [
                  Icon(
                    Icons
                        .location_on_outlined,

                    size:
                    addressFontSize +
                        3,

                    color:
                    Colors.white
                        .withOpacity(
                      0.75,
                    ),
                  ),

                  const SizedBox(
                    width: 5,
                  ),

                  Flexible(
                    child: Text(
                      rep.address,

                      maxLines:
                      2,

                      overflow:
                      TextOverflow
                          .ellipsis,

                      textAlign:
                      TextAlign
                          .center,

                      style:
                      TextStyle(
                        fontSize:
                        addressFontSize,

                        color:
                        Colors.white
                            .withOpacity(
                          0.85,
                        ),

                        fontWeight:
                        FontWeight
                            .w500,

                        height:
                        1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (rep
                .groupTitle
                .isNotEmpty&&rep.repType==7) ...[
              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .center,

                children: [
                  Icon(
                    Icons
                        .group_outlined,

                    size:
                    16,

                    color:
                    Colors.white
                        .withOpacity(
                      0.75,
                    ),
                  ),

                  const SizedBox(
                    width: 5,
                  ),

                  Flexible(
                    child: Text(
                      rep.groupTitle,

                      maxLines:
                      3,

                      overflow:
                      TextOverflow
                          .ellipsis,

                      textAlign:
                      TextAlign
                          .center,

                      style:
                      TextStyle(
                        fontSize:
                        13,

                        color:
                        Colors.white
                            .withOpacity(
                          0.85,
                        ),

                        fontWeight:
                        FontWeight
                            .w500,

                        height:
                        1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            // =================================================
            // Finished Plan Badge
            // =================================================
            if (isFinal) ...[
              SizedBox(
                height:
                ui.sectionSpacing,
              ),

              Container(
                padding:
                const EdgeInsets
                    .symmetric(
                  horizontal:
                  12,

                  vertical:
                  6,
                ),

                decoration:
                BoxDecoration(
                  color:
                  Colors.white
                      .withOpacity(
                    0.12,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    10,
                  ),

                  border:
                  Border.all(
                    color:
                    Colors.white
                        .withOpacity(
                      0.20,
                    ),
                  ),
                ),

                child:
                const Row(
                  mainAxisSize:
                  MainAxisSize
                      .min,

                  children: [
                    Icon(
                      Icons
                          .history_rounded,

                      size: 15,

                      color:
                      Colors.white,
                    ),

                    SizedBox(
                      width: 6,
                    ),

                    Text(
                      'خطة منتهية',

                      style:
                      TextStyle(
                        fontSize:
                        11.5,

                        color:
                        Colors.white,

                        fontWeight:
                        FontWeight
                            .w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}
