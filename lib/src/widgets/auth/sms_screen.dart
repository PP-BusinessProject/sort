import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ndialog/ndialog.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../generated/i18n.g.dart';
import '../shared/shared_widgets.dart';
import '../utils/focus_wrapper.dart';

/// The screen to input the sms code.
class SMSScreen extends HookConsumerWidget {
  /// The screen to input the sms code.
  const SMSScreen(this.phoneNumber, {this.resend, super.key});

  /// The phone number that the sms code was sent to.
  final PhoneNumber phoneNumber;

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
    final ValueNotifier<bool> isLoading = useState<bool>(false);
    // ignore: close_sinks
    final StreamController<ErrorAnimationType> errorController =
        useStreamController<ErrorAnimationType>();
    final ValueNotifier<String> errorText = useState('');
    final I18N $ = I18NLocalizations.of(context);
    final double fieldSize =
        (mediaQuery.size.width - contentPadding.horizontal) / (codeLength + 10);

    Future<String> verify(final String code) async {
      try {
        await Supabase.instance.client.auth.api
            .verifyMobileOTP(phoneNumber.international, code);
        Supabase.instance.log('SMS Code is verified: $code.');
      } on GoTrueException catch (exception) {
        if (exception.statusCode == null || exception.statusCode == '401') {
          Supabase.instance.log('Code expired.');
          await NDialog(
            title: Text($.alert.codeExpired.title),
            content: Text($.alert.codeExpired.body),
            actions: <Widget>[
              TextButton(
                style: theme.textButtonTheme.style?.copyWith(
                  shape: MaterialStateProperty.all<OutlinedBorder?>(
                    const RoundedRectangleBorder(),
                  ),
                ),
                onPressed: navigator.maybePop,
                child: Text($.alert.codeExpired.approve),
              )
            ],
          ).show<void>(context);
        } else {
          rethrow;
        }
      }
      return '';
    }

    return FocusWrapper(
      unfocussableKeys: <GlobalKey<State<StatefulWidget>>>[codeFieldKey],
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: navigationBar(
          theme,
          previousPageTitle: $.misc.prevPage,
          onPressed: navigator.maybePop,
        ),
        child: listView(
          mediaQuery,
          padding: contentPadding,
          children: <Widget>[
            /// Input Code
            Text(
              $.auth.phoneNumber.codeSent(phoneNumber.international),
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            /// Code Field
            Material(
              child: PinCodeTextField(
                key: codeFieldKey,
                appContext: context,
                errorAnimationController: errorController,
                length: codeLength,
                animationType: AnimationType.fade,
                showCursor: false,
                hintCharacter: '-',
                textStyle: theme.textTheme.displaySmall,
                animationDuration: const Duration(milliseconds: 200),
                keyboardType: TextInputType.number,
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
                  Supabase.instance.log('Allowing to paste $value');
                  return true;
                },
              ),
            ),
            const SizedBox(height: 100),

            /// Resend Button
            if (resend != null)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text($.auth.phoneNumber.resendCodePrompt),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(0),
                    ),
                    onPressed: resend == null || isLoading.value
                        ? null
                        : () async {
                            isLoading.value = true;
                            try {
                              await resend!();
                            } finally {
                              isLoading.value = false;
                            }
                          },
                    child: Text($.auth.phoneNumber.resendCode),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties
        ..add(DiagnosticsProperty<PhoneNumber>('phoneNumber', phoneNumber))
        ..add(
          ObjectFlagProperty<FutureOr<bool> Function()?>.has('resend', resend),
        ),
    );
  }
}
