import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../extensions.dart';
import '../../generated/i18n.g.dart';
import '../../generated/models.g.dart';
import '../../styles.dart';
import '../../widgets/shared/shared_widgets.dart';
import '../auth/profile_screen.dart';

/// The current logged in user's profile card.
class UserCard extends StatelessWidget {
  /// The current logged in user's profile card.
  const UserCard(
    final this.user, {
    final this.canEdit = false,
    final super.key,
  });

  /// The user to show in this card.
  final UserModel user;

  /// If the controls for editing this [user] should be shown.
  final bool canEdit;

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final I18NLocale currentLocale = I18NLocalizations.of(context)!.current;
    final I18N $ = currentLocale();

    return Row(
      children: <Widget>[
        /// Avatar with Add Button
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            /// Avatar
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: GestureDetector(
                onTap: () {},
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[boxShadow(theme)],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(CupertinoIcons.person_fill, size: 32),
                  ),
                ),
              ),
            ),

            /// Add Button
            if (canEdit)
              iconButton(
                theme,
                CupertinoIcons.add,
                iconSize: 12,
                radius: 9,
                color: theme.colorScheme.onPrimary,
                iconColor: theme.colorScheme.surface,
                onTap: () {},
              )
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: marqueeText(
                  user.fullName(currentLocale.locale),
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                child: marqueeText(
                  '+${user.phoneNumber}',
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),

        /// Profile Edit
        if (canEdit) ...<Widget>[
          const SizedBox(width: 16),
          Align(
            alignment: Alignment.topRight,
            child: Tooltip(
              message: $.menu.editHint,
              child: iconButton(
                theme,
                CupertinoIcons.pencil,
                onTap: () => navigator.push(
                  PageTransition<void>(
                    type: PageTransitionType.fade,
                    child: const ProfileScreen(),
                  ),
                ),
                iconSize: 18,
                radius: 32 / 2,
              ),
            ),
          )
        ]
      ],
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties
        ..add(DiagnosticsProperty<UserModel>('user', user))
        ..add(DiagnosticsProperty<bool>('canEdit', canEdit)),
    );
    ;
  }
}
