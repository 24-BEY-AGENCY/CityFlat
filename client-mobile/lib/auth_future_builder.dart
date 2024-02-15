import 'package:cityflat/presentation/admin/home/screens/admin_home_screen.dart';
import 'package:cityflat/presentation/authentication/screens/login/login_screen.dart';
import 'package:cityflat/presentation/authentication/screens/verify_email/verify_email_screen.dart';
import 'package:cityflat/providers/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/user/user_wrapper/user_wrapper.dart';

class AuthFutureBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);

    Future<String?>? getTokenFromStorage() async {
      try {
        await tokenProvider.decodeToken();
        String? token = tokenProvider.token;
        return token;
      } catch (err) {
        return null;
      }
    }

    Future<bool>? isUserVerified() async {
      await tokenProvider.getUserData();
      bool isVerified = (tokenProvider.userData != null
          ? tokenProvider.userData!.isVerified
          : false)!;

      return isVerified;
    }

    Future<String>? getUserRole() async {
      await tokenProvider.getUserData();
      String? role = tokenProvider.userData!.role;
      return role!;
    }

    return FutureBuilder<String?>(
      future: getTokenFromStorage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<bool>(
              future: isUserVerified(),
              builder: (context, verifySnapshot) {
                if (verifySnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  if (verifySnapshot.hasData &&
                      verifySnapshot.data != null &&
                      verifySnapshot.data == false) {
                    return VerifyEmailScreen();
                  } else if (verifySnapshot.hasData &&
                      verifySnapshot.data != null &&
                      verifySnapshot.data == true) {
                    return FutureBuilder<String>(
                      future: getUserRole(),
                      builder: (context, roleSnapshot) {
                        if (roleSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          if (roleSnapshot.hasData) {
                            if (roleSnapshot.data == 'USER') {
                              return UserWrapper();
                            } else if (roleSnapshot.data == 'ADMIN') {
                              return AdminHomeScreen();
                            }
                          }
                          return Center(
                              child: Container(
                                  child: Text('Something went wrong')));
                        }
                      },
                    );
                  } else {
                    return Center(
                        child: Container(child: Text('Something went wrong')));
                  }
                }
              },
            );
          } else {
            return LoginScreen();
          }
        }
      },
    );
  }
}
