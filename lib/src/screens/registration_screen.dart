import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ndialog/ndialog.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../api.dart';
import '../const.dart';
import '../generated/i18n.g.dart';
import '../generated/models.g.dart';
import '../providers/flutter_providers.dart';
import '../providers/misc_providers.dart';
import '../providers/model_providers.dart';
import '../styles.dart';

/// The screen for a user to fill in his personal data.
class RegistrationScreen extends HookConsumerWidget {
  /// The screen for a user to fill in his personal data.
  const RegistrationScreen({final super.key});

  /// The padding of the main content on this screen.
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 48,
  );

  /// The validator for the first name and last name fields.
  static final RegExp nameRegExp = RegExp(
    r"[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}",
    caseSensitive: false,
  );

  /// The regular expression used to trim input text.
  static final RegExp trimmingRegExp = RegExp(r'\s\b|\b\s|^\s+$');

  static final StateProvider<bool> _isRegistrationLoading =
      StateProvider<bool>((final _) => false);

  static final StateProvider<String?> _firstNameProvider =
      StateProvider<String?>(
    (final StateProviderRef<String?> ref) => ref.watch(
      userProvider.select(
        (final AsyncValue<UserModel?> user) =>
            user.valueOrNull?.firstName ?? '',
      ),
    ),
    dependencies: <ProviderOrFamily>[userProvider],
  );

  static final StateProvider<String?> _lastNameProvider =
      StateProvider<String?>(
    (final StateProviderRef<String?> ref) => ref.watch(
      userProvider.select(
        (final AsyncValue<UserModel?> user) => user.valueOrNull?.lastName ?? '',
      ),
    ),
    dependencies: <ProviderOrFamily>[userProvider],
  );

  static final StateProvider<String?> _emailProvider = StateProvider<String?>(
    (final StateProviderRef<String?> ref) => ref.watch(
      userProvider.select(
        (final AsyncValue<UserModel?> user) => user.valueOrNull?.email ?? '',
      ),
    ),
    dependencies: <ProviderOrFamily>[userProvider],
  );

  static final StateProvider<DateTime?> _birthdayProvider =
      StateProvider<DateTime?>(
    (final StateProviderRef<DateTime?> ref) => ref.watch(
      userProvider.select(
        (final AsyncValue<UserModel?> user) => user.valueOrNull?.birthday,
      ),
    ),
    dependencies: <ProviderOrFamily>[userProvider],
  );

  static final StateProvider<bool?> _genderProvider = StateProvider<bool?>(
    (final StateProviderRef<bool?> ref) => ref.watch(
      userProvider.select(
        (final AsyncValue<UserModel?> user) => user.valueOrNull?.person?.gender,
      ),
    ),
    dependencies: <ProviderOrFamily>[userProvider],
  );

  static final StateProvider<int> _numberOfFamilyMembersProvider =
      StateProvider<int>(
    (final StateProviderRef<int> ref) => ref.watch(
      userProvider.select(
        (final AsyncValue<UserModel?> user) =>
            user.valueOrNull?.person?.familyCount ?? 1,
      ),
    ),
    dependencies: <ProviderOrFamily>[userProvider],
  );

  static final StateProvider<bool> _privacyPolicy =
      StateProvider<bool>((final StateProviderRef<bool> ref) => false);

  static final Provider<bool> _registrationValid = Provider<bool>(
    (final ProviderRef<bool> ref) {
      final UserModel? user =
          ref.watch(userProvider.select((final _) => _.valueOrNull));
      final UserModel newUser = ref.watch(_newUser);
      return ref.watch($phoneNumberProvider.select((final _) => _ != null)) &&
          ref.watch(
            _firstNameProvider.select((final _) => _?.isNotEmpty ?? false),
          ) &&
          ref.watch(_birthdayProvider.select((final _) => _ != null)) &&
          ref.watch(_genderProvider.select((final _) => _ != null)) &&
          (user != null && user != newUser || ref.watch(_privacyPolicy));
    },
    dependencies: <ProviderOrFamily>[
      userProvider,
      $phoneNumberProvider,
      _firstNameProvider,
      _birthdayProvider,
      _genderProvider,
      _privacyPolicy,
      _newUser
    ],
  );

  static final Provider<UserModel> _newUser = Provider<UserModel>(
    (final ProviderRef<UserModel> ref) {
      final int phoneNumber = ref.watch($phoneNumberProvider)!;
      final String firstName = ref.watch(_firstNameProvider)!;
      final String? lastName = ref.watch(
        _lastNameProvider.select(
          (final String? lastName) => lastName!.isEmpty ? null : lastName,
        ),
      );
      final String? email = ref.watch(
        _emailProvider.select(
          (final String? email) => email!.isEmpty ? null : email,
        ),
      );
      final DateTime? birthday = ref.watch(_birthdayProvider);
      final bool gender = ref.watch(
        _genderProvider.select((final bool? gender) => gender ?? false),
      );
      final int familyCount = ref.watch(
        _numberOfFamilyMembersProvider.select(
          (final int? numberOfFamilyMembers) => numberOfFamilyMembers ?? 1,
        ),
      );

      final UserModel? user =
          ref.watch(userProvider.select((final _) => _.valueOrNull));
      return user != null
          ? user.copyWith(
              phoneNumber: phoneNumber,
              firstName: firstName,
              lastName: lastName,
              email: email,
              birthday: birthday,
              person: user.person
                      ?.copyWith(gender: gender, familyCount: familyCount) ??
                  PersonModel(
                    gender: gender,
                    familyCount: familyCount,
                  ),
            )
          : UserModel(
              phoneNumber: phoneNumber,
              firstName: firstName,
              lastName: lastName,
              email: email,
              birthday: birthday,
              person: PersonModel(gender: gender, familyCount: familyCount),
            );
    },
    dependencies: <ProviderOrFamily>[
      userProvider,
      $phoneNumberProvider,
      _firstNameProvider,
      _lastNameProvider,
      _emailProvider,
      _birthdayProvider,
      _genderProvider,
      _numberOfFamilyMembersProvider
    ],
  );

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = ref.watch(i18nProvider)();

    final bool Function() isMounted = useIsMounted();
    final TextEditingController firstNameController = useTextEditingController(
      text: ref.read(_firstNameProvider),
    );
    final TextEditingController lastNameController = useTextEditingController(
      text: ref.read(_lastNameProvider),
    );
    final TextEditingController emailController = useTextEditingController(
      text: ref.read(_emailProvider),
    );
    final TextEditingController birthdayController = useTextEditingController(
      text: ref.read(_birthdayProvider)?.toIso8601String(),
    );
    ref
      ..listen<DateTime?>(
        _birthdayProvider,
        (final _, final DateTime? birthday) =>
            birthdayController.text = birthday?.toIso8601String() ?? '',
      )
      ..listen<UserModel?>(userProvider.select((final _) => _.valueOrNull),
          (final UserModel? prevUser, final UserModel? user) {
        if (prevUser == null || user == null) {
          return;
        }
        if (prevUser.firstName != user.firstName) {
          ref.read(_firstNameProvider.notifier).state = user.firstName;
          firstNameController.text = user.firstName;
        }
        if (prevUser.lastName != user.lastName) {
          ref.read(_lastNameProvider.notifier).state = user.lastName;
          lastNameController.text = user.lastName ?? '';
        }
        if (prevUser.email != user.email) {
          ref.read(_emailProvider.notifier).state = user.email;
          emailController.text = user.email ?? '';
        }
        if (prevUser.birthday != user.birthday) {
          ref.read(_birthdayProvider.notifier).state = user.birthday;
        }
        if (prevUser.person?.gender != user.person?.gender) {
          ref.read(_genderProvider.notifier).state = user.person?.gender;
        }
        if (prevUser.person?.familyCount != user.person?.familyCount) {
          ref.read(_numberOfFamilyMembersProvider.notifier).state =
              user.person?.familyCount ?? 1;
        }
      });

    FutureOr<void> process() async {
      final StateController<bool> isLoading =
          ref.read(_isRegistrationLoading.notifier)..state = true;
      final UserModel? user = ref.read(userProvider).valueOrNull;
      try {
        final UserModel newUser = ref.read(_newUser);
        final SortAPI sortApi = ref.read(sortApiProvider);
        if (user != null) {
          await sortApi.put('/users', <UserModel>[newUser], userConverter);
          // await NDialog(
          //   title: Text($.alert.error.title),
          //   content: Text($.alert.error.body),
          //   actions: <Widget>[
          //     TextButton(
          //       onPressed: navigator.maybePop,
          //       child: Text($.alert.error.approve),
          //     )
          //   ],
          // ).show<void>(context);
        } else {
          await sortApi.post('/users', <UserModel>[newUser], userConverter);
        }
      } on SortAPIException catch (_) {
        try {
          await NDialog(
            title: Text($.alert.error.title),
            content: Text($.alert.error.body),
            actions: <Widget>[
              TextButton(
                onPressed: navigator.maybePop,
                child: Text($.alert.error.approve),
              )
            ],
          ).show<void>(context);
        } finally {
          rethrow;
        }
      } finally {
        isLoading.state = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: $.misc.prevPage,
          color: theme.colorScheme.onPrimary,
          onPressed: () => NDialog(
            dialogStyle: DialogStyle(titleDivider: true),
            title: Text($.alert.exitRegister.title),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                  } finally {
                    await navigator.maybePop();
                  }
                },
                child: Text($.alert.exitRegister.approve),
              ),
              TextButton(
                onPressed: navigator.maybePop,
                child: Text($.alert.exitRegister.deny),
              ),
            ],
          ).show<void>(context, transitionType: DialogTransitionType.Bubble),
        ),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: contentPadding,
          cacheExtent: double.infinity,
          children: <Widget>[
            Consumer(
              builder: (final _, final WidgetRef ref, final Widget? child) =>
                  CupertinoTextFormFieldRow(
                readOnly: true,
                padding: EdgeInsets.zero,
                placeholder: ref.watch(
                  phoneNumberProvider.select(
                    (final PhoneNumber? phoneNumber) =>
                        phoneNumber?.international ?? $.profile.phoneNumber,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: theme.colorScheme.shadow),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            CupertinoTextFormFieldRow(
              controller: firstNameController,
              placeholder: $.profile.firstName,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: theme.colorScheme.shadow),
                ),
              ),
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(64),
                FilteringTextInputFormatter.deny(trimmingRegExp)
              ],
              autovalidateMode: AutovalidateMode.always,
              validator: (final String? value) => value == null ||
                      value.isEmpty ||
                      nameRegExp.hasMatch(value.trim())
                  ? null
                  : $.profile.firstNameError,
              onChanged: (final String value) => isMounted()
                  ? ref.read(_firstNameProvider.notifier).state =
                      value.isEmpty || nameRegExp.hasMatch(value.trim())
                          ? value
                          : null
                  : null,
              toolbarOptions: const ToolbarOptions(
                copy: true,
                cut: true,
                paste: true,
                selectAll: true,
              ),
            ),
            const SizedBox(height: 48),
            CupertinoTextFormFieldRow(
              controller: lastNameController,
              placeholder: $.profile.lastName,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: theme.colorScheme.shadow),
                ),
              ),
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(64),
                FilteringTextInputFormatter.deny(trimmingRegExp)
              ],
              autovalidateMode: AutovalidateMode.always,
              validator: (final String? value) => value == null ||
                      value.isEmpty ||
                      nameRegExp.hasMatch(value.trim())
                  ? null
                  : $.profile.lastNameError,
              onChanged: (final String value) => isMounted()
                  ? ref.read(_lastNameProvider.notifier).state =
                      value.isEmpty || nameRegExp.hasMatch(value.trim())
                          ? value
                          : null
                  : null,
            ),
            const SizedBox(height: 48),
            CupertinoTextFormFieldRow(
              controller: emailController,
              placeholder: $.profile.email,
              padding: EdgeInsets.zero,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(255),
                FilteringTextInputFormatter.deny(trimmingRegExp)
              ],
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: theme.colorScheme.shadow),
                ),
              ),
              autovalidateMode: AutovalidateMode.always,
              validator: (final String? value) => value == null ||
                      value.isEmpty ||
                      EmailValidator.validate(value)
                  ? null
                  : $.profile.emailError,
              onChanged: (final String value) => isMounted()
                  ? ref.read(_emailProvider.notifier).state =
                      value.isEmpty || EmailValidator.validate(value)
                          ? value
                          : null
                  : null,
            ),
            const SizedBox(height: 48),
            CupertinoTextFormFieldRow(
              controller: birthdayController,
              readOnly: true,
              padding: EdgeInsets.zero,
              placeholder: $.profile.birthday,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: theme.colorScheme.shadow),
                ),
              ),
              onTap: () => const DialogBackground(
                dialog: _RegistrationBirthdayDialog(),
              ).show<void>(context),
            ),
            const SizedBox(height: 48),
            const _RegistrationGender(),
            const SizedBox(height: 48),
            const _RegistrationNumberOfFamilyMembers(),
            const SizedBox(height: 48),
            Consumer(
              builder: (final _, final WidgetRef ref, final Widget? child) {
                final bool userExists = ref.watch(
                  userProvider.select((final _) => _.valueOrNull != null),
                );
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (!userExists) ...<Widget>[
                      const _RegistrationPrivacyPolicy(),
                      const SizedBox(height: 48),
                    ],
                    ElevatedButton(
                      onPressed: ref.watch(_isRegistrationLoading) ||
                              !ref.watch(_registrationValid)
                          ? null
                          : process,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 0),
                      ),
                      child: Text(
                        userExists ? $.profile.update : $.profile.register,
                        style: theme.textTheme.headlineMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class _RegistrationBirthdayDialog extends HookConsumerWidget {
  const _RegistrationBirthdayDialog();

  static final StateProvider<bool> _isSelected =
      StateProvider<bool>((final _) => false);

  @override
  NAlertDialog build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18N $ = ref.watch(i18nProvider)();
    final bool Function() isMounted = useIsMounted();
    final ObjectRef<DateTime?> selection =
        useRef<DateTime?>(ref.read(RegistrationScreen._birthdayProvider));
    ref.listen<DateTime?>(
      RegistrationScreen._birthdayProvider,
      (final _, final DateTime? birthday) => selection.value = birthday,
    );
    final DateTime serverTime = useMemoized(() => ref.read(serverTimeProvider));
    return NAlertDialog(
      dialogStyle: DialogStyle(shape: outlinedBorder(theme)),
      content: Scaffold(
        primary: false,
        resizeToAvoidBottomInset: false,
        body: SfDateRangePicker(
          view: DateRangePickerView.year,
          toggleDaySelection: true,
          initialSelectedDate: selection.value,
          maxDate: DateTime(
            serverTime.year - minUserAge,
            serverTime.month,
            serverTime.day,
          ),
          minDate: DateTime(
            serverTime.year - maxUserAge,
            serverTime.month,
            serverTime.day,
          ),
          onSelectionChanged: (final _) {
            if (isMounted() && _.value is DateTime?) {
              selection.value = _.value as DateTime?;
              ref.read(_isSelected.notifier).state = _.value != null;
            }
          },
        ),
      ),
      actions: <Widget>[
        Consumer(
          builder: (final _, final WidgetRef ref, final Widget? child) =>
              TextButton(
            onPressed: ref.watch(_isSelected)
                ? () async {
                    if (isMounted()) {
                      (ref.read(RegistrationScreen._birthdayProvider.notifier))
                          .state = selection.value;
                    }
                    await navigator.maybePop();
                  }
                : null,
            child: child!,
          ),
          child: Text($.profile.birthdayConfirm),
        )
      ],
    );
  }
}

class _RegistrationGender extends HookConsumerWidget {
  const _RegistrationGender();

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final I18N $ = ref.watch(i18nProvider)();
    final bool Function() isMounted = useIsMounted();
    final ValueNotifier<bool?> gender =
        useState<bool?>(ref.read(RegistrationScreen._genderProvider));
    ref.listen<bool?>(
      RegistrationScreen._genderProvider,
      (final _, final bool? $gender) => gender.value = $gender,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          $.profile.gender,
          style: theme.textTheme.titleLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        Flexible(
          child: Row(
            children: <Widget>[
              Flexible(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Checkbox(
                        value: !(gender.value ?? true),
                        onChanged: (final _) => isMounted()
                            ? (ref.read(
                                RegistrationScreen._genderProvider.notifier,
                              )).state = gender.value = false
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Text($.profile.female),
                    const SizedBox(width: 32),
                    Flexible(
                      child: Checkbox(
                        value: gender.value ?? false,
                        onChanged: (final _) => isMounted()
                            ? (ref.read(
                                RegistrationScreen._genderProvider.notifier,
                              )).state = gender.value = true
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Text($.profile.male),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RegistrationNumberOfFamilyMembers extends HookConsumerWidget {
  const _RegistrationNumberOfFamilyMembers();

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final I18N $ = ref.watch(i18nProvider)();
    final bool Function() isMounted = useIsMounted();
    final ValueNotifier<int> $numberOfFamilyMembers = useState<int>(
      ref.read(RegistrationScreen._numberOfFamilyMembersProvider),
    );
    ref.listen(
      RegistrationScreen._numberOfFamilyMembersProvider,
      (final _, final int numberOfFamilyMembers) =>
          $numberOfFamilyMembers.value = numberOfFamilyMembers,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          $.profile.numberOfFamilyMembers,
          style: theme.textTheme.titleLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Flexible(
          child: SfSlider(
            min: 1,
            max: maxNumberOfFamilyMembers,
            interval: 1,
            stepSize: 1,
            showTicks: true,
            showLabels: true,
            value: $numberOfFamilyMembers.value,
            onChanged: (final Object? value) =>
                $numberOfFamilyMembers.value = (value! as double).toInt(),
            onChangeEnd: (final Object? value) => isMounted()
                ? (ref.read(
                    RegistrationScreen._numberOfFamilyMembersProvider.notifier,
                  )).state = (value! as double).toInt()
                : null,
          ),
        ),
      ],
    );
  }
}

class _RegistrationPrivacyPolicy extends HookConsumerWidget {
  const _RegistrationPrivacyPolicy();

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final I18N $ = ref.watch(i18nProvider)();
    final bool Function() isMounted = useIsMounted();
    final ValueNotifier<bool> privacyPolicy =
        useState<bool>(ref.read(RegistrationScreen._privacyPolicy));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Row(
            children: <Widget>[
              Checkbox(
                value: privacyPolicy.value,
                onChanged: (final _) => isMounted()
                    ? (ref.read(
                        RegistrationScreen._privacyPolicy.notifier,
                      )).state = privacyPolicy.value = !privacyPolicy.value
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Flexible(
                child: Text.rich(
                  TextSpan(
                    text: '${$.profile.privacyPolicyAgreement} ',
                    children: <InlineSpan>[
                      TextSpan(
                        text: $.profile.privacyPolicy,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
