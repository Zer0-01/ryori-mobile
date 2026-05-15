import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ryori/core/logger/app_logger.dart';

class AppRouterObserver extends AutoRouteObserver {
  final AppLogger _logger = AppLogger(tag: 'AppRouterObserver');
  @override
  void didPush(Route route, Route? previousRoute) {
    _logger.i('New route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _logger.i('Route popped: ${route.settings.name}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    _logger.i('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    _logger.i('Tab route re-visited: ${route.name}');
  }
}
