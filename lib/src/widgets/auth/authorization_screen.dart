import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide Provider;
import 'package:page_transition/page_transition.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../generated/i18n.g.dart';
import '../../providers/supabase/texts_provider.dart';
import '../shared/shared_widgets.dart';
import '../utils/focus_wrapper.dart';
import 'sms_screen.dart';

final StateProvider<bool> _isAuthorizationLoading =
    StateProvider<bool>((final _) => false);

/// The screen used to authorize a user.
class AuthorizationScreen extends HookConsumerWidget {
  /// The screen used to authorize a user.
  const AuthorizationScreen({super.key});

  /// The padding of the main content on this screen.
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(horizontal: 24);

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = I18NLocalizations.of(context);

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
      try {
        /// https://supabase.com/docs/guides/auth/auth-twilio#using-otp-as-a-passwordless-sign-in-mechanism
        final GotrueJsonResponse response =
            await Supabase.instance.client.auth.api.sendMobileOTP(
          $phoneNumber.international,
          shouldCreateUser: true,
        );
        if (response.statusCode != 200) {
          Supabase.instance.log('The provided phone number is not valid.');
          return false;
        }
        Supabase.instance.log(
          'Code sent successfully to number: ${$phoneNumber.international}',
        );

        await navigator.push<String>(
          PageTransition<String>(
            type: PageTransitionType.leftToRightWithFade,
            child: SMSScreen(
              $phoneNumber,
              resend: resendToken != null
                  ? () => authorizePhoneNumber(resendToken)
                  : null,
            ),
            childCurrent: this,
          ),
        );
        return true;
      } on GoTrueException catch (_) {
        Supabase.instance.log('Error occured while sending sms.');
        rethrow;
      } finally {
        isLoading.state = false;
      }
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
                      onSaved: (final _) async => authorizePhoneNumber(),
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
              onPressed: () =>
                  Supabase.instance.log('ACTION: Contact support.'),
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
