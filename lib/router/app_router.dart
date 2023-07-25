import 'package:go_router/go_router.dart';
import 'package:menu_app/pages/navigation/checkout_page.dart';
import 'package:menu_app/pages/responsive/main_page.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const MainPage();
      },
      routes: [
        GoRoute(
          path: 'checkout',
          builder: (context, state) {
            return const CheckoutPage();
          },
        )
      ]),
]);
