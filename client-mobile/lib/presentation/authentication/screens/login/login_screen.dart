import 'package:cityflat/presentation/authentication/screens/forgot_password/forgot_password_screen.dart';
import 'package:cityflat/presentation/authentication/screens/signup/signup_screen.dart';
import 'package:cityflat/presentation/authentication/screens/verify_email/verify_email_screen.dart';
import 'package:cityflat/presentation/user/user_wrapper/user_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../../../models/user_model.dart';
import '../../../../providers/token_provider.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/connectivity_service.dart';
import '../../../../utilities/size_config.dart';
import '../../../../utilities/textFormField_validators.dart';
import '../../../shared/widgets/custom_elevated_button.dart';
import '../../../shared/widgets/custom_icons.dart';
import '../../../shared/widgets/custom_textformfield.dart';
import '../../../shared/widgets/text_link.dart';
import '../../widgets/auth_layout.dart';
import '../../widgets/social_logins.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  User user = User(email: "", password: "");

  final _emailValidator = TextFormFieldValidators.emailValidator;
  final _emailKey = GlobalKey<FormFieldState>();
  bool _emailValid = false;

  final _passwordValidator = TextFormFieldValidators.passwordValidator;
  final _passwordKey = GlobalKey<FormFieldState>();
  bool _passwordValid = false;

  bool _obscureText = true;

  bool isErrorEmail = false;
  bool isErrorPassword = false;
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    ConnectivityService.initConnectivity(context);
  }

  @override
  void dispose() {
    ConnectivityService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);
    final onePercentOfHeight = SizeConfig.heightMultiplier;

    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);

    onLogin() async {
      try {
        if (_formKey.currentState != null &&
            _formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          await EasyLoading.show(
            indicator: const CircularProgressIndicator(
              color: Color.fromRGBO(13, 178, 84, 1),
            ),
            maskType: EasyLoadingMaskType.black,
          );
          User loggedUser = await AuthService().loginUser(user);
          if (EasyLoading.isShow) {
            await EasyLoading.dismiss();
          }

          await tokenProvider.saveToken(loggedUser.token!);
          await tokenProvider.getToken();
          tokenProvider.token;

          await tokenProvider.saveUserData(loggedUser);
          await tokenProvider.getUserData();

          if (!context.mounted) return;

          Navigator.of(context).pushReplacementNamed(
            UserWrapper.routeName,
          );
        }
      } catch (error) {
        if (EasyLoading.isShow) {
          await EasyLoading.dismiss();
        }
        if (error == "email not verified !") {
          await tokenProvider.saveUnverfiedUserData(user.email!);

          if (!context.mounted) return;
          Navigator.of(context).pushReplacementNamed(
            VerifyEmailScreen.routeName,
          );
        }
        setState(() {
          isErrorEmail = true;
          isErrorPassword = true;
          errorMsg = error.toString();
        });
      }
    }

    return AuthLayout(
        pageTitle: "Login",
        pageChild: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                customValidator: _emailValidator,
                customTextInputAction: TextInputAction.next,
                customKeyboardType: TextInputType.emailAddress,
                customKey: _emailKey,
                textCapitalization: TextCapitalization.none,
                customHintText: "Email ...",
                isError: isErrorEmail,
                prefixIcon: const Icon(
                  CustomIcons.email,
                  color: Colors.white,
                  size: 13.0,
                ),
                onChanged: (value) => setState(() {
                  user.email = value!;
                  isErrorEmail = false;
                  _emailValid = _emailKey.currentState!.validate();
                }),
              ),
              if (_emailKey.currentState != null &&
                  _emailKey.currentState!.hasError)
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 45.0, vertical: 5.0),
                  child: Text(
                    _emailKey.currentState!.errorText!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12.0 * curScaleFactor,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromRGBO(190, 6, 6, 1),
                    ),
                  ),
                ),
              SizedBox(
                height: onePercentOfHeight * 2,
              ),
              CustomTextFormField(
                customValidator: _passwordValidator,
                customTextInputAction: TextInputAction.done,
                customKeyboardType: TextInputType.visiblePassword,
                customKey: _passwordKey,
                textCapitalization: TextCapitalization.none,
                customHintText: "Password ...",
                isError: isErrorPassword,
                prefixIcon: const Icon(
                  CustomIcons.key,
                  color: Colors.white,
                  size: 13.0,
                ),
                obscureText: _obscureText,
                suffixIcon: Container(
                  margin: const EdgeInsets.only(right: 5.0),
                  child: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: const Color.fromRGBO(89, 85, 85, 1),
                      size: 19.0,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                onChanged: (value) => setState(() {
                  isErrorPassword = false;
                  user.password = value!;
                  _passwordValid = _passwordKey.currentState!.validate();
                }),
              ),
              if (_passwordKey.currentState != null &&
                  _passwordKey.currentState!.hasError)
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 45.0, vertical: 5.0),
                  child: Text(
                    _passwordKey.currentState!.errorText!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12.0 * curScaleFactor,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromRGBO(190, 6, 6, 1),
                    ),
                  ),
                ),
              SizedBox(
                height: onePercentOfHeight * 2,
              ),
              if (isErrorEmail || isErrorPassword)
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 45.0, vertical: 5.0),
                  child: Text(
                    errorMsg.toString(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12.0 * curScaleFactor,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromRGBO(190, 6, 6, 1),
                    ),
                  ),
                ),
              Container(
                margin: const EdgeInsets.only(right: 20.0),
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text(
                    "Forgot Your Password ?",
                    style: TextStyle(
                      fontFamily: 'TT Commons',
                      fontWeight: FontWeight.w500,
                      fontSize: 13 * curScaleFactor,
                      color: const Color.fromRGBO(27, 230, 115, 1),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      ForgotPasswordScreen.routeName,
                    );
                  },
                ),
              ),
              SizedBox(
                height: onePercentOfHeight * 4,
              ),
              CustomElevatedButton(
                buttonText: "LOGIN",
                onPressed: () async {
                  await onLogin();
                },
                condition: _emailValid && _passwordValid,
              ),
              SizedBox(
                height: onePercentOfHeight * 3,
              ),
              TextLink(
                text: "You Don't Have An Account ? ",
                textLink: "Create An Account",
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(
                    SignupScreen.routeName,
                  );
                },
              ),
              SizedBox(
                height: onePercentOfHeight * 4,
              ),
              const SocialLogins(),
            ],
          ),
        ));
  }
}
