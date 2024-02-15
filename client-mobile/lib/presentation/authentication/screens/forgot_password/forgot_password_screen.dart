import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../services/auth_service.dart';
import '../../../../utilities/size_config.dart';
import '../../../../utilities/textFormField_validators.dart';
import '../../../shared/widgets/custom_elevated_button.dart';
import '../../../shared/widgets/custom_icons.dart';
import '../../../shared/widgets/custom_textformfield.dart';
import '../../widgets/auth_layout.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = "/forgotPassword";

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email;

  final _emailValidator = TextFormFieldValidators.emailValidator;
  final _emailKey = GlobalKey<FormFieldState>();
  bool _emailValid = false;
  bool isErrorEmail = false;
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaleFactor;
    final onePercentOfHeight = SizeConfig.heightMultiplier;

    onSendEmail() async {
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
          await AuthService().resetPasswordByEmail(email!);
          if (EasyLoading.isShow) {
            await EasyLoading.dismiss();
          }
        }
      } catch (error) {
        if (EasyLoading.isShow) {
          await EasyLoading.dismiss();
        }
        setState(() {
          isErrorEmail = true;
          errorMsg = error.toString();
        });
      }
    }

    return AuthLayout(
        pageTitle: "Forgot password",
        pageChild: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                customValidator: _emailValidator,
                customTextInputAction: TextInputAction.done,
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
                  email = value!;
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
              if (isErrorEmail)
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
              SizedBox(
                height: onePercentOfHeight * 4,
              ),
              CustomElevatedButton(
                buttonText: "SEND",
                onPressed: () async {
                  await onSendEmail();
                },
                condition: _emailValid,
              ),
              SizedBox(
                height: onePercentOfHeight * 3,
              ),
            ],
          ),
        ));
  }
}
