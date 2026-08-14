import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

class PersonProgressCard extends StatefulWidget {
  const PersonProgressCard({
    super.key,
    required this.name,
    required this.unreadCount,
    required this.totalCount,
    required this.onTap,
    this.progressTitle = "زيارات الخطة",
    this.remainingTitle = "المتبقية",
    this.showArrow = true,
  });

  /// اسم الشخص
  final String name;

  /// العدد غير المقروء / المتبقي
  final int unreadCount;

  /// العدد الكلي
  final int totalCount;

  /// الضغط على الكرت
  final VoidCallback onTap;

  /// مثال:
  /// زيارات الخطة
  /// الزيارات
  /// التقارير
  final String progressTitle;

  /// مثال:
  /// المتبقية
  /// غير المقروءة
  final String remainingTitle;

  final bool showArrow;

  @override
  State<PersonProgressCard> createState() =>
      _PersonProgressCardState();
}

class _PersonProgressCardState
    extends State<PersonProgressCard> {
  bool _isPressed = false;

  // =====================================================
  // Safe Values
  // =====================================================

  int get _safeTotal {
    return widget.totalCount < 0
        ? 0
        : widget.totalCount;
  }

  int get _safeUnread {
    if (widget.unreadCount < 0) {
      return 0;
    }

    if (_safeTotal > 0 &&
        widget.unreadCount > _safeTotal) {
      return _safeTotal;
    }

    return widget.unreadCount;
  }

  // =====================================================
  // Read / Completed
  // =====================================================

  int get _completedCount {
    final result =
        _safeTotal - _safeUnread;

    return result < 0
        ? 0
        : result;
  }

  // =====================================================
  // Progress
  // =====================================================

  double get _progress {
    if (_safeTotal <= 0) {
      return 0;
    }

    return (_completedCount / _safeTotal)
        .clamp(
      0.0,
      1.0,
    );
  }

  int get _percentage {
    return (_progress * 100).round();
  }

  // =====================================================
  // Initial
  // =====================================================

  String get _initial {
    final cleanName =
    widget.name.trim();

    if (cleanName.isEmpty) {
      return "";
    }

    return cleanName.substring(
      0,
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ui =
    AppUi.of(context);

    final progressColor =
    _getProgressColor(
      _percentage,
    );

    return GestureDetector(
      behavior:
      HitTestBehavior.opaque,

      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },

      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });

        // نفس سلوك الكروت السابقة
        widget.onTap();
      },

      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },

      child: AnimatedScale(
        duration:
        const Duration(
          milliseconds: 120,
        ),

        scale:
        _isPressed
            ? 0.992
            : 1,

        child: AnimatedContainer(
          duration:
          const Duration(
            milliseconds: 150,
          ),

          width:
          double.infinity,

          padding:
          EdgeInsets.all(
            ui.cardPadding,
          ),

          decoration:
          BoxDecoration(
            color:
            Colors.white,

            borderRadius:
            BorderRadius.circular(
              ui.cardRadius,
            ),

            border:
            Border.all(
              color:
              _isPressed
                  ? ColorManager
                  .medicalPrimary
                  .withOpacity(
                0.28,
              )
                  : const Color(
                0xFFE2E8F0,
              ),
            ),

            boxShadow: [
              BoxShadow(
                color:
                Colors.black
                    .withOpacity(
                  0.03,
                ),

                blurRadius:
                12,

                offset:
                const Offset(
                  0,
                  4,
                ),
              ),
            ],
          ),

          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              // =================================================
              // Avatar
              // =================================================
              AnimatedContainer(
                duration:
                const Duration(
                  milliseconds: 150,
                ),

                width:
                ui.iconBoxSize + 6,

                height:
                ui.iconBoxSize + 6,

                alignment:
                Alignment.center,

                decoration:
                BoxDecoration(
                  color:
                  _isPressed
                      ? ColorManager
                      .medicalPrimary
                      : ColorManager
                      .medicalPrimary
                      .withOpacity(
                    0.07,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    ui.smallRadius + 3,
                  ),
                ),

                child: Text(
                  _initial,

                  style:
                  TextStyle(
                    fontSize:
                    ui.cardTitleSize +
                        2,

                    fontWeight:
                    FontWeight.w800,

                    color:
                    _isPressed
                        ? Colors.white
                        : ColorManager
                        .medicalPrimary,
                  ),
                ),
              ),

              SizedBox(
                width:
                ui.sectionSpacing,
              ),

              // =================================================
              // Information
              // =================================================
              Expanded(
                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,

                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  children: [
                    // =============================================
                    // Name
                    // =============================================
                    Text(
                      widget.name,

                      maxLines:
                      1,

                      overflow:
                      TextOverflow
                          .ellipsis,

                      style:
                      TextStyle(
                        fontSize:
                        ui.cardTitleSize,

                        fontWeight:
                        FontWeight.w700,

                        color:
                        const Color(
                          0xFF1E293B,
                        ),

                        height:
                        1.25,
                      ),
                    ),

                    SizedBox(
                      height:
                      ui.mediumSpacing,
                    ),

                    // =============================================
                    // Counts + Percentage
                    // =============================================
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  widget
                                      .progressTitle,

                                  maxLines:
                                  1,

                                  overflow:
                                  TextOverflow
                                      .ellipsis,

                                  style:
                                  TextStyle(
                                    fontSize:
                                    ui.bodyTextSize,

                                    fontWeight:
                                    FontWeight.w600,

                                    color:
                                    const Color(
                                      0xFF64748B,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width:
                                ui.smallSpacing,
                              ),

                              Text(
                                "$_completedCount / $_safeTotal",

                                style:
                                TextStyle(
                                  fontSize:
                                  ui.bodyTextSize,

                                  fontWeight:
                                  FontWeight.w700,

                                  color:
                                  ColorManager
                                      .medicalPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // =========================================
                        // Percentage Badge
                        // =========================================
                        Container(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal:
                            8,

                            vertical:
                            4,
                          ),

                          decoration:
                          BoxDecoration(
                            color:
                            progressColor
                                .withOpacity(
                              0.08,
                            ),

                            borderRadius:
                            BorderRadius
                                .circular(
                              ui.smallRadius,
                            ),
                          ),

                          child: Text(
                            "$_percentage%",

                            style:
                            TextStyle(
                              fontSize:
                              ui.smallTextSize,

                              fontWeight:
                              FontWeight.w700,

                              color:
                              progressColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      ui.smallSpacing,
                    ),

                    // =============================================
                    // Unread / Remaining
                    // =============================================
                    Row(
                      children: [
                        Icon(
                          Icons
                              .pending_actions_outlined,

                          size:
                          ui.smallIconSize,

                          color:
                          const Color(
                            0xFFE67E22,
                          ),
                        ),

                        const SizedBox(
                          width: 5,
                        ),

                        Flexible(
                          child: Text(
                            "${widget.remainingTitle}: $_safeUnread",

                            maxLines:
                            1,

                            overflow:
                            TextOverflow
                                .ellipsis,

                            style:
                            TextStyle(
                              fontSize:
                              ui.smallTextSize,

                              fontWeight:
                              FontWeight.w500,

                              color:
                              const Color(
                                0xFF94A3B8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      ui.mediumSpacing,
                    ),

                    // =============================================
                    // Progress
                    // =============================================
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(
                        20,
                      ),

                      child:
                      LinearProgressIndicator(
                        value:
                        _progress,

                        minHeight:
                        ui.isMobile
                            ? 6
                            : 7,

                        backgroundColor:
                        const Color(
                          0xFFF1F5F9,
                        ),

                        valueColor:
                        AlwaysStoppedAnimation<
                            Color>(
                          progressColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =================================================
              // Arrow
              // =================================================
              if (widget.showArrow) ...[
                SizedBox(
                  width:
                  ui.mediumSpacing,
                ),

                AnimatedContainer(
                  duration:
                  const Duration(
                    milliseconds: 150,
                  ),

                  width:
                  ui.iconBoxSize - 6,

                  height:
                  ui.iconBoxSize - 6,

                  alignment:
                  Alignment.center,

                  decoration:
                  BoxDecoration(
                    color:
                    _isPressed
                        ? ColorManager
                        .medicalPrimary
                        .withOpacity(
                      0.09,
                    )
                        : const Color(
                      0xFFF8FAFC,
                    ),

                    borderRadius:
                    BorderRadius.circular(
                      ui.smallRadius,
                    ),
                  ),

                  child: Icon(
                    Icons
                        .arrow_forward_ios_rounded,

                    size:
                    ui.smallIconSize,

                    color:
                    _isPressed
                        ? ColorManager
                        .medicalPrimary
                        : const Color(
                      0xFFCBD5E1,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Semantic Progress Color
  // =====================================================

  Color _getProgressColor(
      int percentage,
      ) {
    if (percentage >= 100) {
      return const Color(
        0xFF2D947A,
      );
    }

    if (percentage >= 60) {
      return const Color(
        0xFF3F7FBF,
      );
    }

    if (percentage >= 30) {
      return const Color(
        0xFFE67E22,
      );
    }

    return const Color(
      0xFFE74C3C,
    );
  }
}