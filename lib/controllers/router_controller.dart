import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/controllers/auth_controller.dart';
import 'package:so_hoa_vung_trong/models/auth_model.dart';
import 'package:so_hoa_vung_trong/pages/ErrorPage.dart';
import 'package:so_hoa_vung_trong/pages/HomePage.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/components/page_transition.dart';
import 'package:so_hoa_vung_trong/pages/LoadingPage.dart';
import 'package:so_hoa_vung_trong/pages/LoginPage.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  final List<String> loginPages = ["/login"];

  RouterNotifier(this._ref) {
    _ref.listen(authControllerProvider, 
    (_, __) => notifyListeners());
  }

  String? _redirectLogin(_, GoRouterState state) {
    return '/';
    final auth = _ref.read(authControllerProvider);
    
    if (auth.authState == AuthState.initial) return null;

    final areWeLoginIn = loginPages.indexWhere((e) => e == state.subloc);

    if (auth.authState != AuthState.login) {
      return areWeLoginIn >= 0 ? null : loginPages[0];
    }

    if (areWeLoginIn >= 0 || state.subloc == "/loading") {
      return '/';
    }

    return null;    
  }

  List<RouteBase> get _routers => [
    GoRoute(
      name: "loading",
      path: "/loading",
      builder: (context, state) => const LoadingPage(),
    ),
    GoRoute(
      name: "login",
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),

    // pages logged
    ShellRoute(
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: "home",
          path: "/",
          // builder: (context, state) => const HomeStudentPage(),
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, 
            state: state, 
            child: const HomePage(),
          ),
          routes: [
          ]
        ),
      ]
    ),
  ];
}

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    initialLocation: "/loading",
    debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: router._redirectLogin,
    routes: router._routers,
    errorBuilder: ((context, state) => const ErrorPage() ),
  );
});