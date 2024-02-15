import 'dart:async';

import 'package:cityflat/presentation/authentication/screens/login/login_screen.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../../models/user_model.dart';
import '../../../../providers/token_provider.dart';
import '../../../../services/auth_service.dart';
import '../../../../utilities/size_config.dart';
import '../../../../utilities/textFormField_validators.dart';
import '../../../shared/widgets/custom_elevated_button.dart';
import '../../../shared/widgets/custom_icons.dart';
import '../../../shared/widgets/custom_textformfield.dart';
import '../../../shared/widgets/custom_toast.dart';
import '../../../shared/widgets/text_link.dart';
import '../../widgets/auth_layout.dart';
import '../../widgets/social_logins.dart';
import '../verify_email/verify_email_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = "/signup";

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  User user = User(name: "", number: "", email: "", password: "");

  final _nameValidator = TextFormFieldValidators.nameValidator;
  final _nameKey = GlobalKey<FormFieldState>();
  bool _nameValid = false;
  bool isErrorName = false;

  final _phoneValidator = TextFormFieldValidators.phoneNumberValidator;
  final _phoneKey = GlobalKey<FormFieldState>();
  bool _phoneValid = false;
  bool isErrorPhone = false;
  CountryCode? countryCode;

  final _emailValidator = TextFormFieldValidators.emailValidator;
  final _emailKey = GlobalKey<FormFieldState>();
  bool _emailValid = false;
  bool isErrorEmail = false;

  final _passwordValidator = TextFormFieldValidators.passwordValidator;
  final _passwordKey = GlobalKey<FormFieldState>();
  bool _passwordValid = false;
  bool _obscureText = true;
  bool isErrorPassword = false;

  String? errorMsg;
  static late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void _showSuccessToast() {
    Future.delayed(const Duration(milliseconds: 500), () {
      fToast.showToast(
        child: const CustomToast(
          text: "Your account was created successfully.",
          textColor: Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Color.fromRGBO(6, 190, 86, 1),
        ),
        toastDuration: const Duration(seconds: 5),
        gravity: ToastGravity.TOP,
      );
    });
  }

  onSignup() async {
    try {
      final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
      String countryCodeString = countryCode?.dialCode! ?? "+49";
      user.number = '$countryCodeString ${user.number!}';

      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
      await EasyLoading.show(
        indicator: const CircularProgressIndicator(
          color: Color.fromRGBO(13, 178, 84, 1),
        ),
        maskType: EasyLoadingMaskType.black,
      );
      User newUser = await AuthService().registerUser(user);
      if (EasyLoading.isShow) {
        await EasyLoading.dismiss();
      }

      await tokenProvider.saveUserData(newUser);

      _showSuccessToast();

      if (mounted) {
        Navigator.of(context).pushReplacementNamed(VerifyEmailScreen.routeName);
      }
    } catch (error) {
      if (EasyLoading.isShow) {
        await EasyLoading.dismiss();
      }
      setState(() {
        isErrorName = true;
        isErrorPhone = true;
        isErrorEmail = true;
        isErrorPassword = true;
        errorMsg = error.toString();
      });
    }
  }

  @override
  void dispose() {
    fToast.removeCustomToast();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaleFactor;
    final onePercentOfHeight = SizeConfig.heightMultiplier;

    return AuthLayout(
        pageTitle: "Register",
        pageChild: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                customValidator: _nameValidator,
                customTextInputAction: TextInputAction.next,
                customKeyboardType: TextInputType.name,
                customKey: _nameKey,
                textCapitalization: TextCapitalization.words,
                customHintText: "Full Name ...",
                isError: isErrorName,
                prefixIcon: const Icon(
                  CustomIcons.user,
                  color: Colors.white,
                  size: 13.0,
                ),
                onChanged: (value) => setState(() {
                  user.name = value!;
                  isErrorName = false;
                  _nameValid = _nameKey.currentState!.validate();
                }),
              ),
              if (_nameKey.currentState != null &&
                  _nameKey.currentState!.hasError)
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 45.0, vertical: 5.0),
                  child: Text(
                    _nameKey.currentState!.errorText!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12.0 * curScaleFactor,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromRGBO(190, 6, 6, 1),
                    ),
                  ),
                ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Stack(
                  children: [
                    CustomTextFormField(
                      customValidator: _phoneValidator,
                      customTextInputAction: TextInputAction.next,
                      customKeyboardType: TextInputType.phone,
                      customKey: _phoneKey,
                      textCapitalization: TextCapitalization.none,
                      customHintText: "Gsm ...",
                      isError: isErrorPhone,
                      prefix: Container(
                        width: 100.0,
                      ),
                      onChanged: (value) => setState(() {
                        user.number = value!;
                        isErrorPhone = false;
                        _phoneValid = _phoneKey.currentState!.validate();
                      }),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 70.0, top: 25.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white.withOpacity(0.3),
                            size: 13.0,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 10.0,
                            ),
                            child: const Icon(
                              CustomIcons.phone,
                              color: Colors.white,
                              size: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20.0, top: 5.0),
                      child: CountryCodePicker(
                        padding: const EdgeInsets.all(0.0),
                        alignLeft: true,
                        onChanged: (value) {
                          countryCode = value;
                        },
                        initialSelection: 'DE',
                        favorite: const ['+49', 'DE'],
                        hideMainText: true,
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        showFlagDialog: true,
                      ),
                    ),
                  ],
                ),
              ),
              if (_phoneKey.currentState != null &&
                  _phoneKey.currentState!.hasError)
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 45.0, vertical: 5.0),
                  child: Text(
                    _phoneKey.currentState!.errorText!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12.0 * curScaleFactor,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromRGBO(190, 6, 6, 1),
                    ),
                  ),
                ),
              const SizedBox(
                height: 20.0,
              ),
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
              if (isErrorName ||
                  isErrorPassword ||
                  isErrorEmail ||
                  isErrorPassword)
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
              SizedBox(
                height: onePercentOfHeight * 2,
              ),
              CustomElevatedButton(
                buttonText: "REGISTER",
                onPressed: () async {
                  await onSignup();
                },
                condition:
                    _nameValid && _phoneValid && _emailValid && _passwordValid,
              ),
              SizedBox(
                height: onePercentOfHeight * 2,
              ),
              TextLink(
                text: "Already have an account ? ",
                textLink: "Login",
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(
                    LoginScreen.routeName,
                  );
                },
              ),
              SizedBox(
                height: onePercentOfHeight * 1,
              ),
              const SocialLogins(),
              SizedBox(
                height: onePercentOfHeight * 1,
              ),
            ],
          ),
        ));
  }
}
