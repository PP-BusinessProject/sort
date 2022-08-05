import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../generated/i18n.g.dart';
import '../providers/flutter_providers.dart';
import '../utils/logger.dart';
import '../widgets/focus_wrapper.dart';

final StateProvider<bool> _isAuthorizationLoading =
    StateProvider<bool>((final _) => false);

/// The screen used to authorize a user.
class AuthorizationScreen extends HookConsumerWidget {
  /// The screen used to authorize a user.
  const AuthorizationScreen({final super.key});

  /// The padding of the main content on this screen.
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(horizontal: 24);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = ref.watch(i18nProvider)();

    final GlobalKey<State<StatefulWidget>> inputFieldKey =
        useMemoized(() => GlobalKey(debugLabel: 'phone_number_input'));
    final bool Function() isMounted = useIsMounted();
    final ValueNotifier<String> errorText = useState('');
    final ValueNotifier<PhoneNumber?> phoneNumber =
        useState<PhoneNumber?>(null);

    FutureOr<bool> authorizePhoneNumber([final int? resendToken]) async {
      final PhoneNumber? $phoneNumber = phoneNumber.value;
      final StateController<bool> isLoading =
          ref.read(_isAuthorizationLoading.notifier);
      if ($phoneNumber == null || !$phoneNumber.validate() || isLoading.state) {
        return false;
      }
      isLoading.state = true;
      bool success = false;
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          forceResendingToken: resendToken,
          phoneNumber: $phoneNumber.international,
          verificationCompleted: FirebaseAuth.instance.signInWithCredential,
          verificationFailed: (final FirebaseAuthException exception) {
            if (exception.code == 'invalid-phone-number') {
              if (isMounted()) {
                errorText.value = $.auth.phoneNumber.error.invalid;
              }
              logger.w('The provided phone number is not valid.');
            } else {
              if (isMounted()) {
                errorText.value = $.auth.phoneNumber.error.unknown;
              }
              logger.e(
                'Exception occured while verifying phone number.',
                exception,
                exception.stackTrace,
              );
            }
          },
          codeSent:
              (final String verificationId, final int? resendToken) async {
            logger.i(
              'Code sent successfully to number: ${$phoneNumber.international}',
            );

            Future<String> verifyCode(final String smsCode) async {
              final StateController<bool> isLoading =
                  ref.read(_isCodeLoading.notifier)..state = true;
              final PhoneAuthCredential credential =
                  PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: smsCode,
              );
              try {
                await FirebaseAuth.instance.signInWithCredential(credential);
              } on FirebaseAuthException catch (exception) {
                logger.e(
                  'Exception occured while verifying send code.',
                  exception,
                  exception.stackTrace,
                );
                return exception.code;
              } finally {
                isLoading.state = false;
              }
              logger.i('SMS Code is verified: $smsCode.');
              success = true;
              return '';
            }

            await navigator.push<String>(
              PageTransition<String>(
                type: PageTransitionType.leftToRightWithFade,
                child: SMSScreen(
                  $phoneNumber,
                  verify: verifyCode,
                  resend: resendToken != null
                      ? () => authorizePhoneNumber(resendToken)
                      : null,
                ),
                childCurrent: this,
              ),
            );
          },
          codeAutoRetrievalTimeout: (final String verificationId) {},
        );
      } finally {
        isLoading.state = false;
      }
      return success;
    }

    return FocusWrapper(
      unfocussableKeys: <GlobalKey<State<StatefulWidget>>>[inputFieldKey],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: contentPadding,
            children: <Widget>[
              AppBar(backgroundColor: Colors.transparent),
              PhoneFormField(
                key: inputFieldKey,
                defaultCountry: IsoCode.UA,
                decoration: InputDecoration(
                  errorText: errorText.value,
                  hintText: $.auth.phoneNumber.enter,
                  contentPadding: const EdgeInsets.all(12),
                ),
                flagSize: 18,
                isCountryChipPersistent: true,
                isCountrySelectionEnabled: false,
                textAlignVertical: TextAlignVertical.center,
                style: theme.textTheme.headlineSmall,
                strutStyle: StrutStyle(
                  height:
                      (theme.textTheme.headlineSmall?.height ?? 1 / 1.1) * 1.1,
                ),
                countryCodeStyle: theme.textTheme.headlineSmall,
                countrySelectorNavigator:
                    const CountrySelectorNavigator.bottomSheet(),
                onSaved: (final _) async => await authorizePhoneNumber(),
                onChanged: (final _) =>
                    isMounted() ? phoneNumber.value = _ : null,
                toolbarOptions: const ToolbarOptions(
                  copy: true,
                  cut: true,
                  paste: true,
                  selectAll: true,
                ),
                validator: PhoneValidator.validMobile(
                  errorText: $.auth.phoneNumber.error.invalid,
                ),
              ),
              const SizedBox(height: 100),
              Consumer(
                builder: (final _, final WidgetRef ref, final Widget? child) =>
                    ElevatedButton(
                  onPressed: !ref.watch(_isAuthorizationLoading) &&
                          (phoneNumber.value?.validate() ?? false)
                      ? authorizePhoneNumber
                      : null,
                  child: Text($.auth.phoneNumber.getCode),
                ),
              ),
            ],
          ),
        ),
        persistentFooterButtons: <Widget>[
          Align(
            child: TextButton(
              onPressed: () => logger.i('ACTION: Contact support.'),
              style: TextButton.styleFrom(
                textStyle: theme.textTheme.headlineMedium?.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
              child: Text($.auth.support),
            ),
          ),
        ],
      ),
    );
  }
}

final StateProvider<bool> _isCodeLoading =
    StateProvider<bool>((final _) => false);

/// The screen to input the sms code.
class SMSScreen extends HookConsumerWidget {
  /// The screen to input the sms code.
  const SMSScreen(
    this.phoneNumber, {
    required final this.verify,
    final this.resend,
    final super.key,
  });

  /// The phone number that the sms code was sent to.
  final PhoneNumber phoneNumber;

  /// The function to verify the code.
  final FutureOr<String> Function(String code) verify;

  /// The function to resend the code.
  final FutureOr<bool> Function()? resend;

  /// The length of the code.
  static const int codeLength = 6;

  /// The padding of the main content on this screen.
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(horizontal: 24);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final GlobalKey<State<StatefulWidget>> codeFieldKey =
        useMemoized(() => GlobalKey(debugLabel: 'sms_code_input'));
    final bool Function() isMounted = useIsMounted();
    // ignore: close_sinks
    final StreamController<ErrorAnimationType> errorController =
        useStreamController<ErrorAnimationType>();
    final ValueNotifier<String> errorText = useState('');
    final I18N $ = ref.watch(i18nProvider)();
    final double fieldSize =
        (mediaQuery.size.width - contentPadding.horizontal) / (codeLength + 10);
    return FocusWrapper(
      unfocussableKeys: <GlobalKey<State<StatefulWidget>>>[codeFieldKey],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: CupertinoNavigationBarBackButton(
            previousPageTitle: $.misc.prevPage,
          ),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: contentPadding,
            children: <Widget>[
              Text($.auth.phoneNumber.codeSent(phoneNumber.international)),
              const SizedBox(height: 24),
              PinCodeTextField(
                key: codeFieldKey,
                appContext: context,
                errorAnimationController: errorController,
                length: codeLength,
                animationType: AnimationType.fade,
                showCursor: false,
                hintCharacter: '-',
                textStyle: theme.textTheme.displaySmall,
                animationDuration: const Duration(milliseconds: 200),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldHeight: fieldSize < 40 ? 40 : fieldSize,
                  fieldWidth: fieldSize < 40 ? 40 : fieldSize,
                  errorBorderColor: theme.colorScheme.error,
                  borderWidth: 3,
                  activeColor: theme.colorScheme.onPrimary,
                  disabledColor: theme.colorScheme.primaryContainer,
                  inactiveColor: theme.colorScheme.primary,
                  selectedColor: theme.colorScheme.tertiary,
                  activeFillColor: theme.colorScheme.onPrimary,
                  inactiveFillColor: theme.colorScheme.primary,
                  selectedFillColor: Colors.transparent,
                ),
                backgroundColor: Colors.transparent,
                onCompleted: (final String value) async => isMounted()
                    ? (errorText.value = await verify(value)).isNotEmpty
                        ? isMounted()
                            ? errorController.add(ErrorAnimationType.shake)
                            : null
                        : await navigator.maybePop()
                    : null,
                onChanged: (final _) {},
                beforeTextPaste: (final String? value) {
                  logger.i('Allowing to paste $value');
                  return true;
                },
              ),
              const SizedBox(height: 100),
              if (resend != null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text($.auth.phoneNumber.resendCodePrompt),
                    const SizedBox(height: 8),
                    Consumer(
                      builder:
                          (final _, final WidgetRef ref, final Widget? child) =>
                              ElevatedButton(
                        onPressed: ref.watch(_isCodeLoading) ? null : resend,
                        child: Text($.auth.phoneNumber.resendCode),
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
        // bottomNavigationBar: Align(
        //   child: TextButton(
        //     onPressed: () => logger.i('ACTION: Contact support.'),
        //     child: Text($.auth.support),
        //   ),
        // ),
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties
        ..add(DiagnosticsProperty<PhoneNumber>('phoneNumber', phoneNumber))
        ..add(
          ObjectFlagProperty<FutureOr<String> Function(String code)>.has(
            'verify',
            verify,
          ),
        )
        ..add(
          ObjectFlagProperty<FutureOr<bool> Function()?>.has('resend', resend),
        ),
    );
  }
}
