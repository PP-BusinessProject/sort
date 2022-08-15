import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_converters_lite/json_converters_lite.dart';
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
class ProfileScreen extends HookConsumerWidget {
  /// The screen for a user to fill in his personal data.
  const ProfileScreen({final super.key});

  /// The padding of the main content on this screen.
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(horizontal: 24);

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
      userProvider.select((final UserModel? user) => user?.firstName ?? ''),
    ),
    dependencies: <ProviderOrFamily>[userProvider],
  );

  static final StateProvider<String?> _lastNameProvider =
      StateProvider<String?>(
    (final StateProviderRef<String?> ref) => ref.watch(
      userProvider.select((final UserModel? user) => user?.lastName ?? ''),
    ),
    dependencies: <ProviderOrFamily>[userProvider],
  );

  static final StateProvider<String?> _emailProvider = StateProvider<String?>(
    (final StateProviderRef<String?> ref) => ref.watch(
      userProvider.select((final UserModel? user) => user?.email ?? ''),
    ),
    dependencies: <ProviderOrFamily>[userProvider],
  );

  static final StateProvider<DateTime?> _birthdayProvider =
      StateProvider<DateTime?>(
    (final StateProviderRef<DateTime?> ref) => ref.watch(
      userProvider.select((final UserModel? user) => user?.birthday),
    ),
    dependencies: <ProviderOrFamily>[userProvider],
  );

  static final StateProvider<bool> _genderProvider = StateProvider<bool>(
    (final StateProviderRef<bool> ref) => ref.watch(
      userProvider
          .select((final UserModel? user) => user?.person?.gender ?? false),
    ),
    dependencies: <ProviderOrFamily>[userProvider],
  );

  static final StateProvider<int> _numberOfFamilyMembersProvider =
      StateProvider<int>(
    (final StateProviderRef<int> ref) => ref.watch(
      userProvider.select(
        (final UserModel? user) => user?.person?.familyCount ?? 1,
      ),
    ),
    dependencies: <ProviderOrFamily>[userProvider],
  );

  static final StateProvider<bool> _privacyPolicy =
      StateProvider<bool>((final StateProviderRef<bool> ref) => false);

  static final Provider<bool> _registrationValid = Provider<bool>(
    (final ProviderRef<bool> ref) {
      final UserModel? user = ref.watch(userProvider);
      return ref.watch($phoneNumberProvider.select((final _) => _ != null)) &&
          ref.watch(
            _firstNameProvider.select((final _) => _?.isNotEmpty ?? false),
          ) &&
          ref.watch(_birthdayProvider.select((final _) => _ != null)) &&
          ((user != null && user != ref.watch(_newUser)) ||
              ref.watch(_privacyPolicy));
    },
    dependencies: <ProviderOrFamily>[
      $phoneNumberProvider,
      userProvider,
      _firstNameProvider,
      _birthdayProvider,
      _privacyPolicy,
      _newUser,
    ],
  );

  static final Provider<UserModel?> _newUser = Provider<UserModel?>(
    (final ProviderRef<UserModel?> ref) {
      final int? phoneNumber = ref.watch($phoneNumberProvider);
      if (phoneNumber == null) {
        return null;
      }
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

      final UserModel? user = ref.watch(userProvider);
      return user?.copyWith(
            phoneNumber: phoneNumber,
            firstName: firstName,
            lastName: lastName,
            email: email,
            birthday: birthday,
            person: user.person
                    ?.copyWith(gender: gender, familyCount: familyCount) ??
                PersonModel(gender: gender, familyCount: familyCount),
          ) ??
          UserModel(
            phoneNumber: phoneNumber,
            firstName: firstName,
            lastName: lastName,
            email: email,
            birthday: birthday,
            person: PersonModel(gender: gender, familyCount: familyCount),
          );
    },
    dependencies: <ProviderOrFamily>[
      $phoneNumberProvider,
      userProvider,
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
      text: ref.read(_birthdayProvider)?.toIso8601String().split('T').first,
    );
    useMemoized(
      () => ref
        ..refresh(_firstNameProvider)
        ..refresh(_lastNameProvider)
        ..refresh(_emailProvider)
        ..refresh(_birthdayProvider)
        ..refresh(_genderProvider)
        ..refresh(_numberOfFamilyMembersProvider),
    );
    ref
      ..listen<DateTime?>(
        _birthdayProvider,
        (final _, final DateTime? birthday) => birthdayController.text =
            birthday?.toIso8601String().split('T').first ?? '',
      )
      ..listen<UserModel?>(userProvider,
          (final UserModel? prevUser, final UserModel? user) {
        if (prevUser?.firstName != user?.firstName) {
          ref.read(_firstNameProvider.notifier).state = user?.firstName;
          firstNameController.text = user?.firstName ?? '';
        }
        if (prevUser?.lastName != user?.lastName) {
          ref.read(_lastNameProvider.notifier).state = user?.lastName;
          lastNameController.text = user?.lastName ?? '';
        }
        if (prevUser?.email != user?.email) {
          ref.read(_emailProvider.notifier).state = user?.email;
          emailController.text = user?.email ?? '';
        }
        if (prevUser?.birthday != user?.birthday) {
          ref.read(_birthdayProvider.notifier).state = user?.birthday;
          birthdayController.text =
              user?.birthday?.toIso8601String().split('T').first ?? '';
        }
        if (prevUser?.person?.gender != user?.person?.gender) {
          ref.read(_genderProvider.notifier).state =
              user?.person?.gender ?? false;
        }
        if (prevUser?.person?.familyCount != user?.person?.familyCount) {
          ref.read(_numberOfFamilyMembersProvider.notifier).state =
              user?.person?.familyCount ?? 1;
        }
      });

    FutureOr<void> process() async {
      final StateController<bool> isLoading =
          ref.read(_isRegistrationLoading.notifier)..state = true;
      final UserModel? user = ref.read(userProvider);
      try {
        final UserModel newUser = ref.read(_newUser)!;
        final Iterable<UserModel>? response = await (user != null
            ? sortApi.put
            : sortApi.post)<Iterable<UserModel>>(
          '/users',
          <UserModel>[newUser],
          toJson: (final Iterable<UserModel> users) =>
              const IterableConverter(userConverter)
                  .toJson(users)
                  .toList(growable: false),
          fromJson: (final Object? value) =>
              const IterableConverter(userConverter).fromJson(
            (value! as Iterable<Object?>).cast<Map<String, Object?>>(),
          ),
        );
        if (!isMounted() || response == null || response.isEmpty) {
          throw Exception('User response is empty.');
        }
        ref.read(userProvider.notifier).state = response.first;
        // ignore: use_build_context_synchronously
        await NDialog(
          title: Text($.alert.success.title),
          content: Text($.alert.success.body),
          actions: <Widget>[
            TextButton(
              style: theme.textButtonTheme.style?.copyWith(
                shape: MaterialStateProperty.all<OutlinedBorder?>(
                  const RoundedRectangleBorder(),
                ),
              ),
              onPressed: navigator.maybePop,
              child: Text($.alert.success.approve),
            )
          ],
        ).show<void>(context);
      } on Exception catch (_) {
        try {
          if (isMounted()) {
            await NDialog(
              title: Text($.alert.error.title),
              content: Text($.alert.error.body),
              actions: <Widget>[
                TextButton(
                  style: theme.textButtonTheme.style?.copyWith(
                    shape: MaterialStateProperty.all<OutlinedBorder?>(
                      const RoundedRectangleBorder(),
                    ),
                  ),
                  onPressed: navigator.maybePop,
                  child: Text($.alert.error.approve),
                )
              ],
            ).show<void>(context);
          }
        } finally {
          rethrow;
        }
      } finally {
        isLoading.state = false;
      }
    }

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        heroTag: 'profile_screen',
        transitionBetweenRoutes: false,
        border: const Border(
          bottom: BorderSide(width: 0, color: Color(0x33000000)),
        ),
        padding: const EdgeInsetsDirectional.only(start: 4),
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: $.misc.prevPage,
          color: theme.colorScheme.onPrimary,
          onPressed: () => NDialog(
            dialogStyle: DialogStyle(titleDivider: true),
            title: Text($.alert.exitRegister.title),
            actions: <Widget>[
              TextButton(
                style: theme.textButtonTheme.style?.copyWith(
                  shape: MaterialStateProperty.all<OutlinedBorder?>(
                    const RoundedRectangleBorder(),
                  ),
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                  } finally {
                    await navigator.maybePop();
                  }
                },
                child: Text(
                  $.alert.exitRegister.approve,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
              TextButton(
                style: theme.textButtonTheme.style?.copyWith(
                  shape: MaterialStateProperty.all<OutlinedBorder?>(
                    const RoundedRectangleBorder(),
                  ),
                ),
                onPressed: navigator.maybePop,
                child: Text(
                  $.alert.exitRegister.deny,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            ],
          ).show<void>(
            context,
            transitionType: DialogTransitionType.Bubble,
          ),
        ),
      ),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: contentPadding,
          cacheExtent: double.infinity,
          children: <Widget>[
            const CupertinoNavigationBar(border: Border()),
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
                    bottom: BorderSide(color: theme.colorScheme.surfaceTint),
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
                  bottom: BorderSide(color: theme.colorScheme.surfaceTint),
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
                  bottom: BorderSide(color: theme.colorScheme.surfaceTint),
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
                  bottom: BorderSide(color: theme.colorScheme.surfaceTint),
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
                  bottom: BorderSide(color: theme.colorScheme.surfaceTint),
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
                final bool userExists =
                    ref.watch(userProvider.select((final _) => _ != null));
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (!userExists) ...<Widget>[
                      const _RegistrationPrivacyPolicy(),
                      const SizedBox(height: 48),
                    ],
                    ElevatedButton.icon(
                      onPressed: ref.watch(_isRegistrationLoading) ||
                              !ref.watch(_registrationValid)
                          ? null
                          : process,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 0),
                      ),
                      icon: ref.watch(_isRegistrationLoading)
                          ? const CircularProgressIndicator.adaptive()
                          : const SizedBox.shrink(),
                      label: Text(
                        userExists ? $.profile.update : $.profile.register,
                        style: theme.textTheme.headlineSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 48),
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
        useRef<DateTime?>(ref.read(ProfileScreen._birthdayProvider));
    ref.listen<DateTime?>(
      ProfileScreen._birthdayProvider,
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
                      (ref.read(ProfileScreen._birthdayProvider.notifier))
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
        useState<bool?>(ref.read(ProfileScreen._genderProvider));
    ref.listen<bool?>(
      ProfileScreen._genderProvider,
      (final _, final bool? $gender) => gender.value = $gender,
    );
    return Material(
      child: Column(
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
                          activeColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          value: !(gender.value ?? true),
                          onChanged: (final _) => isMounted()
                              ? (ref.read(
                                  ProfileScreen._genderProvider.notifier,
                                )).state = gender.value = false
                              : null,
                        ),
                      ),
                      Text($.profile.female),
                      const SizedBox(width: 32),
                      Flexible(
                        child: Checkbox(
                          activeColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          value: gender.value ?? false,
                          onChanged: (final _) => isMounted()
                              ? (ref.read(
                                  ProfileScreen._genderProvider.notifier,
                                )).state = gender.value = true
                              : null,
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
      ),
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
      ref.read(ProfileScreen._numberOfFamilyMembersProvider),
    );
    ref.listen(
      ProfileScreen._numberOfFamilyMembersProvider,
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
                    ProfileScreen._numberOfFamilyMembersProvider.notifier,
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
        useState<bool>(ref.read(ProfileScreen._privacyPolicy));
    return Material(
      child: Column(
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
                          ProfileScreen._privacyPolicy.notifier,
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
      ),
    );
  }
}
