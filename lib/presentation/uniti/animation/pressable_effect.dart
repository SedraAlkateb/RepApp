import 'package:flutter/material.dart';

/// يضيف حركة (تكبير/تصغير + ظل) عند تقريب الماوس وعند الضغط،
/// دون التأثير على سلوك الضغط الأصلي للعنصر (يعتمد على Listener لا يدخل في gesture arena).
class PressableEffect extends StatefulWidget {
  const PressableEffect({
    super.key,
    required this.child,
    this.enabled = true,
    this.borderRadius,
    this.hoverScale = 1.015,
    this.pressedScale = 0.97,
  });

  final Widget child;
  final bool enabled;
  final BorderRadius? borderRadius;
  final double hoverScale;
  final double pressedScale;

  @override
  State<PressableEffect> createState() => _PressableEffectState();
}

class _PressableEffectState extends State<PressableEffect> {
  bool _hovered = false;
  bool _pressed = false;

  void _setHovered(bool value) {
    if (_hovered != value) setState(() => _hovered = value);
  }

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    final double scale = _pressed
        ? widget.pressedScale
        : _hovered
            ? widget.hoverScale
            : 1;

    final bool active = _hovered || _pressed;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) => _setPressed(true),
        onPointerUp: (_) => _setPressed(false),
        onPointerCancel: (_) => _setPressed(false),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: active ? 0.10 : 0),
                  blurRadius: _pressed ? 6 : 12,
                  offset: Offset(0, _pressed ? 2 : 5),
                ),
              ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// بديل لـ [InkWell] يضيف حركة الماوس/الضغط تلقائياً.
class AppInkWell extends StatelessWidget {
  const AppInkWell({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius,
  });

  final Widget? child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return PressableEffect(
      enabled: onTap != null,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }
}
