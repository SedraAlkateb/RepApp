// ignore_for_file: deprecated_member_use

import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/custom-wavy-background.dart';
import 'package:domina_app/presentation/uniti/stateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    userName.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);
    final orientation = MediaQuery.orientationOf(context);
    final bool isLandscape = orientation == Orientation.landscape;
    final bool useTwoColumnLayout = ui.isTabletLandscape;
    final double keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return BlocProvider<AuthBloc>(
      create: (context) => instance<AuthBloc>(),
      child: Scaffold(
        // مهم: لا نخلي الكيبورد يصغّر الشاشة كلها.
        // فقط جهة الفورم تتعامل معه.
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF8FAFC),
        body: PopScope(
          canPop: false,
          child: Form(
            key: formKey,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (useTwoColumnLayout) {
                  return _buildTabletLandscape(
                    context: context,
                    ui: ui,
                    keyboardInset: keyboardInset,
                  );
                }

                return _buildMobileAndPortrait(
                  context: context,
                  ui: ui,
                  isLandscape: isLandscape,
                  keyboardInset: keyboardInset,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // Tablet Landscape
  // اليمين ثابت دائماً، والكيبورد يؤثر فقط على الفورم باليسار.
  // ===========================================================
  Widget _buildTabletLandscape({
    required BuildContext context,
    required AppUi ui,
    required double keyboardInset,
  }) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          flex: 5,
          child: _buildWelcomePanel(
            context: context,
            ui: ui,
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            color: Colors.white,
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(bottom: keyboardInset),
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, formConstraints) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.symmetric(
                        horizontal: ui.pagePadding + ui.mediumSpacing,
                        vertical: ui.pageTopPadding,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: (formConstraints.maxHeight -
                              (ui.pageTopPadding * 2))
                              .clamp(0.0, double.infinity),
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 520),
                            child: _buildFormContents(
                              context: context,
                              ui: ui,
                              compact: true,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================
  // Right Welcome Panel - ثابت ولا يتحرك مع الكيبورد
  // ===========================================================
  Widget _buildWelcomePanel({
    required BuildContext context,
    required AppUi ui,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Color(0xFFF8FAFC)),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.sizeOf(context).height * 0.46,
          child: CustomWavyBackground()
              .animate()
              .fadeIn(duration: 700.ms)
              .slideY(begin: -0.05, end: 0),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ui.pagePadding + ui.largeSpacing,
              vertical: ui.pageTopPadding,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildProfessionalLogo(
                      ui: ui,
                      tabletLandscape: true,
                    ),
                    SizedBox(height: ui.largeSpacing),
                    Text(
                      'مرحباً بك مجدداً في DOMINA',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ui.pageTitleSize + 2,
                        fontWeight: FontWeight.w800,
                        color: ColorManager.medicalPrimary,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: ui.mediumSpacing),
                    Text(
                      'سجّل دخولك للوصول إلى لوحة التحكم والمهام اليومية.',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ui.pageSubtitleSize + 1,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================
  // Mobile + Tablet Portrait
  // الخلفية ثابتة، والفورم فقط يتكيّف مع الكيبورد.
  // ===========================================================
  Widget _buildMobileAndPortrait({
    required BuildContext context,
    required AppUi ui,
    required bool isLandscape,
    required double keyboardInset,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomWavyBackground()
            .animate()
            .fadeIn(duration: 700.ms)
            .slideY(begin: -0.05, end: 0),
        SafeArea(
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: keyboardInset),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(
                    ui.pagePadding,
                    isLandscape ? ui.smallSpacing : ui.pageTopPadding,
                    ui.pagePadding,
                    ui.pageBottomPadding,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: (constraints.maxHeight -
                          ui.pageBottomPadding -
                          ui.pageTopPadding)
                          .clamp(0.0, double.infinity),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: ui.pageMaxWidth),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!isLandscape) ...[
                              _buildProfessionalLogo(
                                ui: ui,
                                tabletLandscape: false,
                              ),
                              SizedBox(height: ui.largeSpacing),
                            ],
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(
                                ui.cardPadding + (ui.isMobile ? 4 : 8),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(ui.cardRadius + 8),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: _buildFormContents(
                                context: context,
                                ui: ui,
                                compact: isLandscape,
                              ),
                            )
                                .animate()
                                .scale(delay: 200.ms, curve: Curves.easeOutQuad),
                            if (!isLandscape) ...[
                              SizedBox(height: ui.largeSpacing),
                              Text(
                                'DOMINA PHARMACEUTICALS',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF94A3B8),
                                  letterSpacing: 1.4,
                                  fontSize: ui.smallTextSize,
                                  fontWeight: FontWeight.w700,
                                ),
                              ).animate().fadeIn(delay: 1.seconds),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================
  // Shared Form Contents
  // ===========================================================
  Widget _buildFormContents({
    required BuildContext context,
    required AppUi ui,
    required bool compact,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          compact ? 'تسجيل الدخول' : 'مرحباً بك مجدداً',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: compact ? ui.pageTitleSize : ui.pageTitleSize + 2,
            fontWeight: FontWeight.w800,
            color: ColorManager.medicalPrimary,
            height: 1.3,
          ),
        ).animate().fadeIn().moveY(begin: 10, end: 0),
        SizedBox(height: ui.smallSpacing),
        if (!compact)
          Text(
            'سجل دخولك للمتابعة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ui.pageSubtitleSize,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ).animate().fadeIn(delay: 200.ms),
        SizedBox(
          height: compact
              ? ui.largeSpacing
              : ui.largeSpacing + ui.mediumSpacing,
        ),
        _buildModernTextField(
          ui: ui,
          controller: userName,
          hint: 'اسم المستخدم',
          icon: Icons.alternate_email_rounded,
          textInputAction: TextInputAction.next,
          validator: (val) {
            final value = val?.trim() ?? '';
            return value.length < 3 ? 'يرجى التحقق من الاسم' : null;
          },
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
        SizedBox(height: ui.sectionSpacing),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final bool isObscured =
            state is ShowPasswordState ? state.isObscured : true;

            return _buildModernTextField(
              ui: ui,
              controller: password,
              hint: 'كلمة المرور',
              icon: Icons.lock_open_rounded,
              isPassword: true,
              isObscured: isObscured,
              textInputAction: TextInputAction.done,
              onSuffixTap: () {
                context.read<AuthBloc>().add(
                  ShowPasswordEvent(!isObscured),
                );
              },
              onFieldSubmitted: (_) => _submitLogin(context),
              validator: (val) {
                final value = val ?? '';
                return value.length < 2 ? 'كلمة المرور قصيرة' : null;
              },
            );
          },
        ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
        SizedBox(
          height: compact
              ? ui.largeSpacing
              : ui.largeSpacing + ui.smallSpacing,
        ),
        _buildPremiumButton(
          context: context,
          ui: ui,
          compact: compact,
        ),
      ],
    );
  }

  // ===========================================================
  // Logo
  // ===========================================================
  Widget _buildProfessionalLogo({
    required AppUi ui,
    required bool tabletLandscape,
  }) {
    final double logoSize = tabletLandscape
        ? 120
        : ui.isMobile
        ? 108
        : 120;

    return Container(
      width: logoSize,
      height: logoSize,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: ColorManager.medicalPrimary.withOpacity(0.10),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          ImageAssets.domina,
          width: logoSize * 0.60,
        )
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .shimmer(duration: 2.seconds, color: Colors.blue.shade50)
            .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.04, 1.04),
          duration: 2.seconds,
        ),
      ),
    );
  }

  // ===========================================================
  // Text Field
  // ===========================================================
  Widget _buildModernTextField({
    required AppUi ui,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isObscured = false,
    VoidCallback? onSuffixTap,
    String? Function(String?)? validator,
    TextInputAction? textInputAction,
    ValueChanged<String>? onFieldSubmitted,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && isObscured,
      validator: validator,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      style: TextStyle(
        fontSize: ui.isMobile ? 15 : 17,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1E293B),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: const Color(0xFF94A3B8),
          fontSize: ui.isMobile ? 14 : 16,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          icon,
          color: ColorManager.medicalPrimary.withOpacity(0.65),
          size: ui.iconSize,
        ),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isObscured
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: const Color(0xFF94A3B8),
          ),
          onPressed: onSuffixTap,
        )
            : null,
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ui.cardPadding,
          vertical: ui.isMobile ? 16 : 18,
        ),
        border: _fieldBorder(ui),
        enabledBorder: _fieldBorder(ui),
        focusedBorder: _fieldBorder(
          ui,
          color: ColorManager.medicalPrimary.withOpacity(0.55),
          width: 1.5,
        ),
        errorBorder: _fieldBorder(
          ui,
          color: const Color(0xFFEF4444),
        ),
        focusedErrorBorder: _fieldBorder(
          ui,
          color: const Color(0xFFEF4444),
          width: 1.5,
        ),
      ),
    );
  }

  OutlineInputBorder _fieldBorder(
      AppUi ui, {
        Color color = const Color(0xFFE2E8F0),
        double width = 1,
      }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(ui.cardRadius - 2),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  // ===========================================================
  // Login Button + نفس Auth flow الأصلي
  // ===========================================================
  Widget _buildPremiumButton({
    required BuildContext context,
    required AppUi ui,
    required bool compact,
  }) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          loading(context);
        }

        if (state is LoginState) {
          context.read<AuthBloc>().add(LoginInsertEvent());
        }

        if (state is InsertLoginState) {
          success(context);

          Future.delayed(
            const Duration(milliseconds: 600),
                () {
              if (!context.mounted) return;

              if (UserInfo.isLogging == 2) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.adminControl,
                      (route) => false,
                );
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.syncData,
                      (route) => false,
                );
              }
            },
          );
        }

        if (state is LoginErrorState || state is InsertLoginErrorState) {
          final dynamic errorState = state;
          error(
            context,
            errorState.failure.massage,
            errorState.failure.code,
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.medicalPrimary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(
                vertical: compact ? 14 : 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ui.cardRadius - 2),
              ),
            ),
            onPressed: () => _submitLogin(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ui.isMobile ? 16 : 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: ui.mediumSpacing),
                Icon(
                  Icons.login_rounded,
                  color: Colors.white,
                  size: ui.iconSize,
                ),
              ],
            ),
          ),
        );
      },
    ).animate().fadeIn(delay: 700.ms);
  }

  void _submitLogin(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    context.read<AuthBloc>().add(
      LoginEvent(
        userName.text.trim(),
        password.text,
      ),
    );
  }
}
