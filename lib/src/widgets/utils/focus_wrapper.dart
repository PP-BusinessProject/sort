import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math_64.dart';

/// Unfocus primary focus node on action.
class FocusWrapper extends StatelessWidget {
  /// Unfocus primary focus node on action.
  const FocusWrapper({
    required final this.child,
    final this.unfocus = true,
    final this.unfocussableKeys =
        const Iterable<GlobalKey<State<StatefulWidget>>>.empty(),
    final super.key,
  });

  /// The child of this widget.
  final Widget child;

  /// If this widget should unfocus.
  final bool unfocus;

  /// The keys of the widgets that should not trigger unfocus operation.
  /// For example, fields themselves.
  final Iterable<GlobalKey<State<StatefulWidget>>> unfocussableKeys;

  @override
  Widget build(final BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    void _unfocus(final PointerEvent event) {
      if (unfocussableKeys.every(
            (final GlobalKey<State<StatefulWidget>> key) =>
                !(key.globalPaintBounds?.contains(event.position) ?? false),
          ) &&
          !currentFocus.hasPrimaryFocus &&
          currentFocus.focusedChild != null) {
        currentFocus.focusedChild?.unfocus();
      }
    }

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: unfocus ? _unfocus : null,
      child: child,
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(
      properties
        ..add(DiagnosticsProperty<bool>('unfocus', unfocus))
        ..add(
          IterableProperty<GlobalKey>(
            'unfocussableKeys',
            unfocussableKeys,
          ),
        ),
    );
  }
}

/// The extension on [GlobalKey] to return its current paint bounds.
extension GlobalPaintBounds on GlobalKey<Object?> {
  /// Return current paint bounds of this key.
  Rect? get globalPaintBounds {
    final RenderObject? renderObject = currentContext?.findRenderObject();
    final Vector3? translation =
        renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject != null) {
      final Offset offset = Offset(translation.x, translation.y);
      return renderObject.paintBounds.shift(offset);
    }
    return null;
  }
}
