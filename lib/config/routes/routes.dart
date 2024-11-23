import 'package:facebook/core/screens/error_screen.dart';
import 'package:facebook/features/auth/presentation/screens/create_account_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../core/screens/home_screen.dart';
import '../../features/posts/presentation/screens/create_post_screen.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CreateAccountScreen.routeName:
        return _cupertinoRoute(const CreateAccountScreen());
      case HomeScreen.routeName:
        return _cupertinoRoute(const HomeScreen());
      case CreatePostScreen.routeName:
        return _cupertinoRoute(const CreatePostScreen());
      default:
        return _cupertinoRoute(
          ErrorScreen(error: 'Wrong Route provided ${settings.name}'),
        );
    }
  }

  static Route _cupertinoRoute(Widget view) => CupertinoPageRoute(
        builder: (_) => view,
      );

  Routes._();
}
