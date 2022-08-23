import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

/// The mockup of the dialog that should sign out the user.
NDialog dialog(
  final ThemeData theme, {
  required final String title,
  required final String approve,
  final String body = '',
  final String deny = '',
  final VoidCallback? onApprove,
  final VoidCallback? onDeny,
}) =>
    NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text(title),
      content: body.isNotEmpty ? Text(body) : null,
      actions: <Widget>[
        TextButton(
          style: theme.textButtonTheme.style?.copyWith(
            shape: MaterialStateProperty.all<OutlinedBorder?>(
              const RoundedRectangleBorder(),
            ),
          ),
          onPressed: onApprove,
          child: Text(
            approve,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        if (deny.isNotEmpty)
          TextButton(
            style: theme.textButtonTheme.style?.copyWith(
              shape: MaterialStateProperty.all<OutlinedBorder?>(
                const RoundedRectangleBorder(),
              ),
            ),
            onPressed: onDeny,
            child: Text(
              deny,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
      ],
    );

NDialog locationDeniedDialog(
  final ThemeData theme, {
  required final String title,
  required final String approve,
  final String deny = '',
  final VoidCallback? onApprove,
  final VoidCallback? onDeny,
}) =>
    NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text(title),
      actions: <Widget>[
        TextButton(
          style: theme.textButtonTheme.style?.copyWith(
            shape: MaterialStateProperty.all<OutlinedBorder?>(
              const RoundedRectangleBorder(),
            ),
          ),
          onPressed: onApprove,
          child: Text(
            approve,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        if (deny.isNotEmpty)
          TextButton(
            style: theme.textButtonTheme.style?.copyWith(
              shape: MaterialStateProperty.all<OutlinedBorder?>(
                const RoundedRectangleBorder(),
              ),
            ),
            onPressed: onDeny,
            child: Text(
              deny,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
      ],
    );
