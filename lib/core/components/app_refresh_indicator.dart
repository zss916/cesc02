import 'package:flutter/material.dart';

class AppRefreshIndicator extends StatelessWidget {
  final Widget child;
  final RefreshCallback onRefresh;
  final ScrollNotificationPredicate? notificationPredicate;
  const AppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.notificationPredicate,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Color(0xFF3978F6),
      backgroundColor: Colors.white,
      notificationPredicate:
          (notificationPredicate ?? defaultScrollNotificationPredicate),
      onRefresh: onRefresh,
      child: child,
    );
  }
}
