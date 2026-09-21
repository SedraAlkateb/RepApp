import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';


// =====================================================
// Hero Tablet Landscape
// =====================================================

Widget buildHeroHeaderTablet(
    BuildContext context,
    InfoRep rep, {
  required bool isFinal,
}) {
  final ui =
  AppUi.of(context);

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
        const EdgeInsets.symmetric(
          vertical:
          32,

          horizontal:
          22,
        ),

        decoration:
        BoxDecoration(
          color:
          const Color(
            0xFF164683,
          ),

          borderRadius:
          BorderRadius.circular(
            ui.cardRadius + 8,
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
            Container(
              width: 84,
              height: 84,

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
                  24,
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
                const TextStyle(
                  fontSize:
                  30,

                  color:
                  Colors.white,

                  fontWeight:
                  FontWeight
                      .w900,
                ),
              ),
            ),

            const SizedBox(
              height: 18,
            ),

            Text(
              rep.name,

              maxLines:
              2,

              overflow:
              TextOverflow
                  .ellipsis,

              textAlign:
              TextAlign.center,

              style:
              const TextStyle(
                fontSize:
                22,

                color:
                Colors.white,

                fontWeight:
                FontWeight
                    .w700,

                height:
                1.25,
              ),
            ),

            if (rep
                .address
                .isNotEmpty) ...[
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
                        .location_on_outlined,

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
                      rep.address,

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
            if (rep
                .groupTitle
                .isNotEmpty) ...[
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
                        color:
                        Colors.white,

                        fontSize:
                        11.5,

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
