import 'package:cityflat/l10n/l10n.dart';
import 'package:cityflat/presentation/authentication/screens/signup/signup_screen.dart';
import 'package:cityflat/presentation/authentication/screens/verify_email/verify_email_screen.dart';
import 'package:cityflat/presentation/user/home/screens/home_screen.dart';
import 'package:cityflat/presentation/user/user_wrapper/user_wrapper.dart';
import 'package:cityflat/providers/localization_provider.dart';
import 'package:cityflat/providers/notification_provider.dart';
import 'package:cityflat/providers/order_provider.dart';
import 'package:cityflat/providers/wishlist_provider.dart';
import 'package:cityflat/utilities/theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cityflat/presentation/admin/home/screens/admin_home_screen.dart';
import 'package:cityflat/presentation/user/notification/screens/notification_list_screen.dart';
import 'package:cityflat/presentation/user/notification/screens/one_notification_screen.dart';
import 'package:cityflat/presentation/order/screens/order_list_screen.dart';
import 'package:cityflat/providers/apartment_provider.dart';
import 'package:cityflat/providers/review_provider.dart';
import 'package:cityflat/providers/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'auth_future_builder.dart';
import 'presentation/admin/apartment/screens/admin_apartment_list_screen.dart';
import 'presentation/admin/help/screens/admin_help_message_list_screen.dart';
import 'presentation/admin/order/screens/admin_order_list.dart';
import 'presentation/admin/reservation/screens/admin_reservation_list_screen.dart';
import 'presentation/admin/service/screens/admin_service_list_screen.dart';
import 'presentation/admin/user/screens/admin_user_list_screen.dart';
import 'presentation/authentication/screens/forgot_password/forgot_password_screen.dart';
import 'presentation/authentication/screens/login/login_screen.dart';
import 'presentation/user/account/screens/account_screen.dart';
import 'presentation/user/apartment/screens/one_apartment_screen.dart';
import 'presentation/user/favorite/screens/favorite_screen.dart';
import 'presentation/user/home/screens/filter_results_screen.dart';
import 'presentation/user/reservation/screens/user_reservation_list_screen.dart';
import 'presentation/user/wishlist/screens/wishlist_screen.dart';
import 'providers/help_message_provider.dart';
import 'providers/reservation_provider.dart';
import 'providers/service_provider.dart';
import 'providers/user_provider.dart';
import 'utilities/size_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = const Color.fromRGBO(0, 0, 0, 1)
    ..backgroundColor = const Color.fromRGBO(0, 0, 0, 1)
    ..indicatorColor = const Color.fromRGBO(0, 0, 0, 1)
    ..textColor = const Color.fromRGBO(0, 0, 0, 1)
    ..maskColor = const Color.fromRGBO(0, 0, 0, 1)
    ..userInteractions = true
    ..dismissOnTap = true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TokenProvider(),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => ApartmentProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (_) => HelpProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ReservationProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: Consumer<LocalizationProvider>(builder: (context, locale, child) {
        return LayoutBuilder(builder: (context, constraints) {
          SizeConfig().init(constraints);
          return MaterialApp(
              title: 'Cityflat',
              debugShowCheckedModeBanner: false,
              // locale: const Locale("fr"),
              locale: locale.locale,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: L10n.all,
              theme: AppTheme.lightTheme,
              home: AuthFutureBuilder(),
              builder: EasyLoading.init(),
              routes: {
                SignupScreen.routeName: (context) => const SignupScreen(),
                VerifyEmailScreen.routeName: (context) =>
                    const VerifyEmailScreen(),
                LoginScreen.routeName: (context) => const LoginScreen(),
                ForgotPasswordScreen.routeName: (context) =>
                    const ForgotPasswordScreen(),
                OneApartmentScreen.routeName: (context) =>
                    const OneApartmentScreen(),
                NotificationListScreen.routeName: (context) =>
                    const NotificationListScreen(),
                OneNotificationScreen.routeName: (context) =>
                    const OneNotificationScreen(),
                OrderListScreen.routeName: (context) => const OrderListScreen(),
                AdminHomeScreen.routeName: (context) => const AdminHomeScreen(),
                AdminApartmentListScreen.routeName: (context) =>
                    const AdminApartmentListScreen(),
                AdminServiceListScreen.routeName: (context) =>
                    const AdminServiceListScreen(),
                AdminHelpMessageListScreen.routeName: (context) =>
                    const AdminHelpMessageListScreen(),
                WishlistScreen.routeName: (context) => const WishlistScreen(),
                AdminOrderScreen.routeName: (context) =>
                    const AdminOrderScreen(),
                AdminUserListScreen.routeName: (context) =>
                    const AdminUserListScreen(),
                AccountScreen.routeName: (context) => const AccountScreen(),
                UserReservationListScreen.routeName: (context) =>
                    const UserReservationListScreen(),
                AdminReservationListScreen.routeName: (context) =>
                    const AdminReservationListScreen(),
                FavoriteScreen.routeName: (context) => const FavoriteScreen(),
                FilterResultsScreen.routeName: (context) =>
                    FilterResultsScreen(),
                UserWrapper.routeName: (context) => const UserWrapper(),
              });
        });
      }),
    );
  }
}
