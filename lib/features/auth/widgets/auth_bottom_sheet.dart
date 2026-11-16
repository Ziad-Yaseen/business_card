import 'package:business_card/core/components/main_text_field_with_laabel.dart';
import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/cubit/theme_cubit.dart';
import 'package:business_card/core/cubit/theme_state.dart';
import 'package:business_card/core/helpers/theme_extension.dart';
import 'package:business_card/features/auth/cubit/auth_cubit.dart';
import 'package:business_card/features/auth/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_ui/material_ui.dart';

enum AuthMode { signUp, signIn }

Future<void> showAuthSheet(BuildContext context, AuthMode mode) {
  context.read<AuthCubit>().clearError();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    builder: (_) => AuthBottomSheet(mode: mode),
  );
}

class AuthBottomSheet extends StatefulWidget {
  const AuthBottomSheet({super.key, required this.mode});

  final AuthMode mode;

  @override
  State<AuthBottomSheet> createState() => _AuthBottomSheetState();
}

class _AuthBottomSheetState extends State<AuthBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _hidden = true;

  bool get _isSignUp => widget.mode == AuthMode.signUp;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final cubit = context.read<AuthCubit>();
    if (_isSignUp) {
      cubit.signUp(_email.text, _password.text);
    } else {
      cubit.signIn(_email.text, _password.text);
    }
  }

  String? _validateEmail(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Enter your email';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? v) {
    final value = v ?? '';
    if (value.isEmpty) return 'Enter your password';
    if (_isSignUp && value.length < 6) return 'At least 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (p, c) => !p.isLoggedIn && c.isLoggedIn,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);
        Navigator.of(context).pop();
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(_isSignUp ? 'Account created' : 'Logged in'),
            ),
          );
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppAccent.cardBg(context),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppAccent.stroke(context),
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                    Gap(18.h),
                    Text(
                      _isSignUp ? 'Create account' : 'Log in',
                      style: GoogleFonts.dmSans(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: AppAccent.primaryText(context),
                      ),
                    ),
                    Gap(20.h),
                    MainTextField(
                      title: 'Email',
                      hint: 'you@example.com',
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      enableInteractiveSelection: true,
                      validator: _validateEmail,
                    ),
                    Gap(14.h),
                    MainTextField(
                      title: 'Password',
                      subTitle: _isSignUp ? 'Min. 6 characters' : '',
                      hint: '••••••••',
                      controller: _password,
                      obscureText: _hidden,
                      textInputAction: TextInputAction.done,
                      enableInteractiveSelection: true,
                      onFieldSubmitted: (_) => _submit(),
                      validator: _validatePassword,
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => _hidden = !_hidden),
                        icon: Icon(
                          _hidden ? Iconsax.eye : Iconsax.eye_slash,
                          size: 20.sp,
                          color: AppAccent.secoundaryText(context),
                        ),
                      ),
                    ),
                    BlocBuilder<AuthCubit, AuthState>(
                      buildWhen: (p, c) => p.error != c.error,
                      builder: (context, state) {
                        if (state.error == null) return const SizedBox.shrink();
                        return Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: Text(
                            state.error!,
                            style: GoogleFonts.dmSans(
                              fontSize: 14.sp,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                    Gap(22.h),
                    BlocBuilder<AuthCubit, AuthState>(
                      buildWhen: (p, c) => p.loading != c.loading,
                      builder: (context, state) =>
                          BlocBuilder<ThemeCubit, ThemeState>(
                            builder: (context, themeState) => FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: context.isDark
                                    ? AppAccent
                                          .presets[themeState.colorIndex]
                                          .dark
                                    : AppAccent
                                          .presets[themeState.colorIndex]
                                          .light,
                                shape: const StadiumBorder(),
                              ),
                              onPressed: state.loading ? null : _submit,
                              child: state.loading
                                  ? SizedBox(
                                      width: 20.w,
                                      height: 20.w,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      _isSignUp ? 'Create account' : 'Log in',
                                      style: GoogleFonts.dmSans(
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
