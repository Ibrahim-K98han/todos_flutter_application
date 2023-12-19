import 'package:get/get.dart';
import 'package:todos_flutter_application/screens/auth/login_screen.dart';
import 'package:todos_flutter_application/screens/auth/signup_screen.dart';

class Routes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';

  static List<GetPage> routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => SignupScreen(),
    ),
  ];
}
