import 'package:cityflat/presentation/authentication/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../../../providers/token_provider.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/connectivity_service.dart';
import '../../../../utilities/size_config.dart';
import '../../../shared/widgets/custom_elevated_button.dart';
import '../../../shared/widgets/custom_textformfield_one_num.dart';
import '../../../shared/widgets/text_link.dart';
import '../../widgets/auth_layout.dart';

class VerifyEmailScreen extends StatefulWidget {
  static const routeName = "/verifyEmail";

  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  List<FocusNode>? _focusNodes;
  List<TextEditingController>? _controllers;
  String? optCode;
  final int _fieldsCount = 4;
  final List<String> _texts = List.filled(4, '');
  bool areAllFieldsFilled() {
    return _texts.every((text) => text.isNotEmpty);
  }

  List<bool> isError = List.filled(4, false);
  bool areNotError() {
    return isError.every((error) => error == true);
  }

  String? errorMsg;

  @override
  void initState() {
    super.initState();
    ConnectivityService.initConnectivity(context);
    _focusNodes = List.generate(_fieldsCount, (index) => FocusNode());
    _controllers =
        List.generate(_fieldsCount, (index) => TextEditingController());
  }

  @override
  void dispose() {
    ConnectivityService.dispose();
    for (var node in _focusNodes!) {
      node.dispose();
    }
    for (var controller in _controllers!) {
      controller.dispose();
    }
    super.dispose();
  }

  onVerifyEmail() async {
    try {
      final tokenProvider = Provider.of<TokenProvider>(context, listen: false);

      await tokenProvider.getUserData();
      String verifCode = _texts.join('');

      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await EasyLoading.show(
          indicator: const CircularProgressIndicator(
            color: Color.fromRGBO(13, 178, 84, 1),
          ),
          maskType: EasyLoadingMaskType.black,
        );
        await AuthService().verifyEmail(
            email: tokenProvider.userData!.email!, verifCode: verifCode);
        if (EasyLoading.isShow) {
          await EasyLoading.dismiss();
        }
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(
            LoginScreen.routeName,
          );
        }
      }
    } catch (error) {
      if (EasyLoading.isShow) {
        await EasyLoading.dismiss();
      }
      setState(() {
        isError = List.filled(4, true);
        errorMsg = error.toString();
      });
    }
  }

  onResendVerificationEmail() async {
    try {
      final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
      await EasyLoading.show(
        indicator: const CircularProgressIndicator(
          color: Color.fromRGBO(13, 178, 84, 1),
        ),
        maskType: EasyLoadingMaskType.black,
      );

      await tokenProvider.getUserData();
      await AuthService()
          .resendVerificationEmail(tokenProvider.userData!.email!);
      if (EasyLoading.isShow) {
        await EasyLoading.dismiss();
      }
    } catch (error) {
      if (EasyLoading.isShow) {
        await EasyLoading.dismiss();
      }
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);
    final onePercentOfWidth = SizeConfig.widthMultiplier;
    final onePercentOfHeight = SizeConfig.heightMultiplier;

    return AuthLayout(
        pageTitle: "Verification code",
        pageChild: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: onePercentOfHeight * 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: List.generate(
                    _fieldsCount,
                    (index) => Expanded(
                      child: SizedBox(
                        width: onePercentOfWidth * 30,
                        child: CustomTextFormFieldOneNumber(
                          customTextInputAction: TextInputAction.next,
                          customKeyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.none,
                          customBorderRadius: 20.0,
                          maxLength: 1,
                          customController: _controllers![index],
                          customFocusNode: _focusNodes![index],
                          isError: isError[index],
                          onChanged: (value) => setState(() {
                            if (value!.isNotEmpty && index < _fieldsCount - 1) {
                              _focusNodes![index + 1].requestFocus();
                            } else if (value.isEmpty && index > 0) {
                              _focusNodes![index - 1].requestFocus();
                            }
                            _texts[index] = value;
                            isError[index] = false;
                          }),
                          customValidator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field ${index + 1} cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (areNotError())
                SizedBox(
                  height: onePercentOfHeight * 2,
                ),
              if (areNotError())
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
                height: onePercentOfHeight * 6,
              ),
              CustomElevatedButton(
                buttonText: "CONTINUE",
                onPressed: () async {
                  await onVerifyEmail();
                },
                condition: areAllFieldsFilled(),
              ),
              SizedBox(
                height: onePercentOfHeight * 3,
              ),
              TextLink(
                text: "You Haven't Received A code ? ",
                textLink: "Resend code",
                onTap: () async {
                  await onResendVerificationEmail();
                },
              ),
              SizedBox(
                height: onePercentOfHeight * 4,
              ),
            ],
          ),
        ));
  }
}
