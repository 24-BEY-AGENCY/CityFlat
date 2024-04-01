import 'package:cityflat/l10n/l10n.dart';
import 'package:cityflat/presentation/authentication/screens/signup/signup_screen.dart';
import 'package:cityflat/presentation/authentication/screens/verify_email/verify_email_screen.dart';
import 'package:cityflat/presentation/user/order/screens/order_list_screen.dart';
import 'package:cityflat/presentation/user/user_wrapper/user_wrapper.dart';
import 'package:cityflat/providers/localization_provider.dart';
import 'package:cityflat/providers/order_provider.dart';
import 'package:cityflat/providers/wishlist_provider.dart';
import 'package:cityflat/utilities/theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cityflat/providers/apartment_provider.dart';
import 'package:cityflat/providers/review_provider.dart';
import 'package:cityflat/providers/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'auth_future_builder.dart';
import 'presentation/authentication/screens/forgot_password/forgot_password_screen.dart';
import 'presentation/authentication/screens/login/login_screen.dart';
import 'presentation/user/favorite/screens/favorite_screen.dart';
import 'presentation/user/profile/screens/profile_screen.dart';
import 'presentation/user/apartment/screens/one_apartment_screen.dart';
import 'presentation/user/favorite/screens/favorite_screen_tab.dart';
import 'presentation/user/home/screens/filter_results_screen.dart';
import 'presentation/user/rental/screens/rental_list_screen.dart';
import 'presentation/user/rental/screens/rental_list_screen_tab.dart';
import 'presentation/user/reservation_confirm/screens/reservation_confirm_screen.dart';
import 'presentation/user/reservation_calendar/screens/reservation_calendar_screen.dart';
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
    ..backgroundColor = Colors.transparent
    ..boxShadow = <BoxShadow>[]
    ..indicatorColor = const Color.fromRGBO(0, 0, 0, 1)
    ..textColor = const Color.fromRGBO(0, 0, 0, 1)
    ..maskColor = Colors.transparent
    ..userInteractions = true
    ..dismissOnTap = true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
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
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ReservationProvider()),
      ],
      child: Consumer<LocalizationProvider>(builder: (context, locale, child) {
        return LayoutBuilder(builder: (context, constraints) {
          SizeConfig().init(constraints);
          return MaterialApp(
              title: 'Cityflat',
              debugShowCheckedModeBanner: false,
              locale: locale.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: L10n.all,
              theme: AppTheme.lightTheme,
              home: const AuthFutureBuilder(),
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
                OrderListScreen.routeName: (context) => const OrderListScreen(),
                RentalListScreen.routeName: (context) =>
                    const RentalListScreen(),
                RentalListScreenTab.routeName: (context) =>
                    const RentalListScreenTab(),
                ProfileScreen.routeName: (context) => const ProfileScreen(),
                FavoriteScreen.routeName: (context) => const FavoriteScreen(),
                FavoriteScreenTab.routeName: (context) =>
                    const FavoriteScreenTab(),
                FilterResultsScreen.routeName: (context) =>
                    const FilterResultsScreen(),
                UserWrapper.routeName: (context) => const UserWrapper(),
                ReservationCalendarScreen.routeName: (context) =>
                    const ReservationCalendarScreen(),
                ReservationConfirmScreen.routeName: (context) =>
                    const ReservationConfirmScreen(),
              });
        });
      }),
    );
  }
}
