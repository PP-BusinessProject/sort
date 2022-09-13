import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../generated/i18n.g.dart';
import '../../providers/model_providers.dart';
import '../../utils/logger.dart';
import '../shared/shared_widgets.dart';
import '../utils/focus_wrapper.dart';
import 'sms_screen.dart';

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
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = I18NLocalizations.of(context)!.current();

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
      if ($phoneNumber == null || !$phoneNumber.isValid() || isLoading.state) {
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
              }
              logger.i('SMS Code is verified: $smsCode.');
              success = true;
              await ref.refresh(userProvider.future);
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
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: Column(
          children: <Widget>[
            Expanded(
              child: listView(
                mediaQuery,
                padding: contentPadding,
                children: <Widget>[
                  /// Offset needed for [SMSScreen]
                  const CupertinoNavigationBar(
                    transitionBetweenRoutes: false,
                    border: Border(),
                  ),

                  /// Phone Number Field
                  Material(
                    child: PhoneFormField(
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
                            (theme.textTheme.headlineSmall?.height ?? 1 / 1.1) *
                                1.1,
                      ),
                      countryCodeStyle: theme.textTheme.headlineSmall,
                      countrySelectorNavigator:
                          const CountrySelectorNavigator.bottomSheet(),
                      onSaved: (final _) => authorizePhoneNumber(),
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
                  ),

                  /// Confirm Button
                  const SizedBox(height: 100),
                  Consumer(
                    builder: (
                      final _,
                      final WidgetRef ref,
                      final Widget? child,
                    ) =>
                        ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(0),
                      ),
                      onPressed: !ref.watch(_isAuthorizationLoading) &&
                              (phoneNumber.value?.isValid() ?? false)
                          ? authorizePhoneNumber
                          : null,
                      child: Text($.auth.phoneNumber.getCode),
                    ),
                  ),
                ],
              ),
            ),

            /// Contact Support Button
            TextButton(
              onPressed: () => logger.i('ACTION: Contact support.'),
              child: Text(
                $.auth.support,
                style: theme.textTheme.titleLarge?.copyWith(
                  decoration: TextDecoration.underline,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
