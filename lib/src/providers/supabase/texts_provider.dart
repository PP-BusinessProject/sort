// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../../generated/i18n.g.dart';
// import '../../generated/models.g.dart';
// import '../database/model_providers.dart';

// class I18NLocalizations {
//   const I18NLocalizations._(this._i18n);

//   final I18N _i18n;

//   static I18N of(final BuildContext context) {
//     final I18NLocalizations? i18n =
//         Localizations.of<I18NLocalizations>(context, I18NLocalizations);
//     assert(
//       () {
//         if (i18n == null) {
//           throw FlutterError.fromParts(<DiagnosticsNode>[
//             ErrorSummary('No I18NLocalizations found.'),
//             ErrorDescription(
//               '${context.widget.runtimeType} widgets require I18NLocalizations '
//               'to be provided by a Localizations widget ancestor.',
//             ),
//             ErrorDescription(
//               'The widgets library uses Localizations to generate messages, '
//               'labels, and abbreviations.',
//             ),
//             ErrorHint(
//               'To introduce a I18NLocalizations, add a Localization widget '
//               'with a I18NLocalizations delegate.',
//             ),
//             ...context.describeMissingAncestor(
//               expectedAncestorType: I18NLocalizations,
//             ),
//           ]);
//         }
//         return true;
//       }(),
//       '',
//     );
//     return i18n!._i18n;
//   }

//   static I18NLocalizationsDelegate delegate(final WidgetRef ref) =>
//       I18NLocalizationsDelegate(ref);
// }

// class I18NLocalizationsDelegate
//     extends LocalizationsDelegate<I18NLocalizations> {
//   const I18NLocalizationsDelegate(this._ref);

//   final WidgetRef _ref;

//   @override
//   bool isSupported(final Locale locale) => true;

//   @override
//   Future<I18NLocalizations> load(final Locale locale) async {
//     final Iterable<LocaleModel>? locales =
//         await _ref.read(localesProvider.future);
//     final LocaleModel? $locale = locales?.firstWhere(
//       (final LocaleModel $locale) =>
//           locale == Locale($locale.languageCode, $locale.countryCode),
//     );
//     return I18NLocalizations._(
//       I18N.fromMap(
//         <String, Object?>{
//           ...?await _ref.read(rpcTextFull(null).future),
//           if ($locale != null) ...?await _ref.read(rpcTextFull($locale).future)
//         },
//       ),
//     );
//   }

//   @override
//   bool shouldReload(final I18NLocalizationsDelegate old) => false;
// }

// final FutureProviderFamily<Map<String, Object?>?, LocaleModel?> rpcTextFull =
//     FutureProvider.family<Map<String, Object?>?, LocaleModel?>(
//   (
//     final FutureProviderRef<Map<String, Object?>?> ref,
//     final LocaleModel? locale,
//   ) =>
//       Supabase.instance.client.rest
//           .rpc(
//             'text_full',
//             params: locale != null
//                 ? <String, Object?>{
//                     'language_code': locale.languageCode,
//                     'country_code': locale.countryCode
//                   }
//                 : null,
//           )
//           .withConverter<Map<String, Object?>?>(
//             (final Object? value) =>
//                 value is Map<String, Object?> ? value : null,
//           ),
// );
