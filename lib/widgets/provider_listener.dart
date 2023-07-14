import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// A widget that allows listening to multiple providers at once.
///
/// This widget is a subclass of `MultiProvider` and accepts a list of `SingleChildWidget` listeners
/// and a child widget. It can be used to listen to multiple providers at once and rebuild the widget tree
/// when any of the providers change.
///
/// Example:
///
/// ```dart
/// MultiProviderListener(
///   listeners: [
///     ProviderListener<MyProvider1>(
///       listener: (context, provider) {
///         // Do something when MyProvider1 changes
///       },
///     ),
///     ProviderListener<MyProvider2>(
///       listener: (context, provider) {
///         // Do something when MyProvider2 changes
///       },
///     ),
///   ],
///   child: MyWidget(),
/// )
/// ```
class MultiProviderListener extends MultiProvider {
  MultiProviderListener({
    Key? key,
    required List<SingleChildWidget> listeners,
    required Widget child,
  }) : super(key: key, providers: listeners, child: child);
}

/// Signature for a function that takes a [BuildContext] and a generic type [S] and returns nothing.
///
/// This function is used as a listener for a [ChangeNotifier] provider.
typedef ProviderWidgetListener<S> = void Function(
    BuildContext context, S state);

/// Signature for a function that takes two generic types [S] and returns a boolean value.
///
/// This function is used to determine whether a [ChangeNotifier] provider should notify its listeners.
typedef ProviderListenerCondition<S> = bool Function(S previous, S current);

abstract class ProviderListenerBase<P extends ChangeNotifier>
    extends SingleChildStatefulWidget {
  const ProviderListenerBase({
    Key? key,
    this.child,
    required this.listener,
  }) : super(key: key, child: child);

  final Widget? child;

  final ProviderWidgetListener<P> listener;

  @override
  SingleChildState<ProviderListenerBase> createState() =>
      _ProviderListenerBaseState<P>();
}

class _ProviderListenerBaseState<P extends ChangeNotifier>
    extends SingleChildState<ProviderListenerBase<P>> {
  late P _provider;

  @override
  void initState() {
    super.initState();
    _provider = context.read<P>();
    _provider.addListener(_listener);
  }

  @override
  void didUpdateWidget(ProviderListenerBase<P> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child != oldWidget.child) {
      _provider.removeListener(_listener);
      _provider = context.read<P>();
      _provider.addListener(_listener);
    }
  }

  @override
  void dispose() {
    _provider.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    widget.listener(context, _provider);
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return child ?? const SizedBox();
  }
}

/// A widget that listens to a [ChangeNotifier] provider and rebuilds its descendants when the provider changes.
///
/// This widget is a subclass of [ProviderListenerBase] and provides a more concise way to listen to a [ChangeNotifier] provider.
///
/// The [ProviderListener] widget takes a [listener] function that is called whenever the provider changes. The [listener] function takes a [BuildContext] and the generic type [P] and returns nothing.
///
/// The [ProviderListener] widget can also take an optional [child] widget that is used as the parent widget for the descendants of this widget.
///
/// Example:
///
/// ```dart
/// ProviderListener<MyProvider>(
///   listener: (context, myProvider) {
///     // Do something when the provider changes
///   },
///   child: MyChildWidget(),
/// )
/// ```
class ProviderListener<P extends ChangeNotifier>
    extends ProviderListenerBase<P> {
  const ProviderListener({
    Key? key,
    Widget? child,
    required ProviderWidgetListener<P> listener,
  }) : super(key: key, child: child, listener: listener);
}
