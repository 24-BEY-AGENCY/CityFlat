import 'package:cityflat/presentation/authentication/screens/login/login_screen.dart';
import 'package:cityflat/presentation/authentication/screens/verify_email/verify_email_screen.dart';
import 'package:cityflat/providers/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/user/user_wrapper/user_wrapper.dart';

class AuthFutureBuilder extends StatelessWidget {
  const AuthFutureBuilder({super.key});

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

    return FutureBuilder<String?>(
      future: getTokenFromStorage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<bool>(
              future: isUserVerified(),
              builder: (context, verifySnapshot) {
                if (verifySnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (verifySnapshot.hasData &&
                      verifySnapshot.data != null &&
                      verifySnapshot.data == false) {
                    return const VerifyEmailScreen();
                  } else if (verifySnapshot.hasData &&
                      verifySnapshot.data != null &&
                      verifySnapshot.data == true) {
                    return const UserWrapper();
                  } else {
                    return Center(
                        child: Container(
                            child: const Text('Something went wrong')));
                  }
                }
              },
            );
          } else {
            return const LoginScreen();
          }
        }
      },
    );
  }
}
