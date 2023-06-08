import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/controllers/auth_controller.dart';
import 'package:so_hoa_vung_trong/models/auth_model.dart';
import 'package:so_hoa_vung_trong/pages/ErrorPage.dart';
import 'package:so_hoa_vung_trong/pages/expert/topic/TopicDetails.dart';
import 'package:so_hoa_vung_trong/pages/home/HomePage.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/components/PageTransition.dart';
import 'package:so_hoa_vung_trong/pages/LoadingPage.dart';
import 'package:so_hoa_vung_trong/pages/LoginPage.dart';
import 'package:so_hoa_vung_trong/pages/action/ActionPage.dart';
import 'package:so_hoa_vung_trong/pages/expert/ExpertPage.dart';
import 'package:so_hoa_vung_trong/pages/home/diary/DiaryEditAddPage.dart';
import 'package:so_hoa_vung_trong/pages/home/diary/DiaryPage.dart';
import 'package:so_hoa_vung_trong/pages/home/diary/diaryLog/DiaryLogEditAddPage.dart';
import 'package:so_hoa_vung_trong/pages/home/nguyen-lieu/NguyenLieuDetailsPage.dart';
import 'package:so_hoa_vung_trong/pages/home/nguyen-lieu/NguyenLieuPage.dart';
import 'package:so_hoa_vung_trong/pages/home/search/SearchSettings.dart';
import 'package:so_hoa_vung_trong/pages/settings/SettingsEditPage.dart';
import 'package:so_hoa_vung_trong/pages/settings/SettingsPage.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  final List<String> loginPages = ["/login"];

  RouterNotifier(this._ref) {
    _ref.listen(authControllerProvider, 
    (_, __) => notifyListeners());
  }

  String? _redirectLogin(_, GoRouterState state) {
    final auth = _ref.read(authControllerProvider);
    
    if (auth.authState == AuthState.initial) return null;

    final areWeLoginIn = loginPages.indexWhere((e) => e == state.matchedLocation);

    if (auth.authState != AuthState.login) {
      return areWeLoginIn >= 0 ? null : loginPages[0];
    }

    if (areWeLoginIn >= 0 || state.matchedLocation == "/loading") {
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
            GoRoute(
              name: "diary-edit-add",
              path: "diary/edit-add",
              builder: (context, state) => DiaryEditAddPage(Oid: state.queryParameters['Oid'] ?? ""),
            ),
            GoRoute(
              name: "diary",
              path: "diary/:id",
              builder: (context, state) => DiaryPage(id: state.pathParameters['id'] ?? ""),
              routes: [
                GoRoute(
                  name: "diary-log-edit-add",
                  path: "edit-add",
                  builder: (context, state) => DiaryLogEditAddPage(Oid: state.queryParameters['Oid'] ?? ""),
                ),
              ]
            ),

            GoRoute(
              name: "nguyen-lieu",
              path: "nguyen-lieu",
              builder: (context, state) => const NguyenLieuPage(),
              routes: [
                GoRoute(
                  name: "nguyen-lieu-details",
                  path: ":id",
                  builder: (context, state) => NguyenLieuDetailsPage(Oid: state.pathParameters['id'] ?? ""),
                ),
              ]
            ),
          ]
        ),
        GoRoute(
          name: "settings",
          path: "/settings",
          // builder: (context, state) => const HomeStudentPage(),
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, 
            state: state, 
            child: const SettingsPage(),
          ),
          routes: [
            GoRoute(
              name: "settings-edit",
              path: "edit",
              builder: (context, state) => const SettingsEditPage(),
            ),
          ]
        ),
        GoRoute(
          name: "action",
          path: "/action",
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, 
            state: state, 
            child: const ActionPage(),
          ),
        ),
        GoRoute(
          name: "expert",
          path: "/expert",
          // builder: (context, state) => const ExpertPage(),
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, 
            state: state, 
            child: const ExpertPage(),
          ),
          
          routes: [
            GoRoute(
              name: "topic-details",
              path: ":id",
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                restorationId: state.pageKey.value,
                child: TopicDetails(id: state.pathParameters['id'] ?? ""),
              ),
              // builder: (context, state) => TopicDetails(id: state.pathParameters['id'] ?? ""),
            ),
          ]
        ),
        GoRoute(
          name: "search",
          path: "/search",
          // builder: (context, state) => const HomeStudentPage(),
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, 
            state: state, 
            child: const SearchPage(),
          ),
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