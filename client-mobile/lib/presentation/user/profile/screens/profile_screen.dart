import 'dart:io';

import 'package:cityflat/models/user_model.dart';
import 'package:cityflat/presentation/shared/widgets/custom_icons2.dart';
import 'package:cityflat/providers/user_provider.dart';
import 'package:cityflat/services/user_service.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

import '../../../../providers/token_provider.dart';
import '../../../../utilities/generate_image_url.dart';
import '../../../../utilities/size_config.dart';
import '../../../../utilities/textFormField_validators.dart';
import '../../../shared/widgets/custom_alert_dialog.dart';
import '../../../shared/widgets/custom_back_button.dart';
import '../../../shared/widgets/custom_icons.dart';
import '../../../shared/widgets/custom_light_border_textforfield.dart';
import '../../../shared/widgets/custom_light_elevated_button.dart';
import '../../../shared/widgets/custom_light_neumorphic_elevated_button.dart';
import '../../../shared/widgets/custom_toast.dart';
import '../widgets/profile_appbar.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? userData;
  bool profileFetched = false;
  bool isUserSet = false;
  String? userId;

  final _formKey = GlobalKey<FormState>();
  User editedUser = User(name: "", number: "", email: "", password: "");

  final _nameValidator = TextFormFieldValidators.nameValidator;
  final _nameKey = GlobalKey<FormFieldState>();
  bool _nameValid = false;
  bool isErrorName = false;

  final _phoneValidator = TextFormFieldValidators.phoneNumberValidator;
  final _phoneKey = GlobalKey<FormFieldState>();
  bool _phoneValid = false;
  bool isErrorPhone = false;
  CountryCode? countryCode;
  String? phoneNumber;

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
  FToast? fToast;

  File? uploadedImage;

  String? noCodeNumber;
  Map<String, String>? foundCountryCode;

  Future<String> getUserId() async {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    await tokenProvider.decodeToken();
    Map<String, dynamic>? token = tokenProvider.decodedToken;
    String userId = token!["user"]["id"];
    return userId;
  }

  Future<User?>? onGetProfileData() async {
    try {
      if (userData == null) {
        String userId = await getUserId();
        userData = await UserService().getOneUser(userId);
        return userData;
      }
      return userData;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Map<String, String>? findElementByDialCode(
      List<Map<String, String>> list, String dialCode) {
    for (var element in list) {
      if (element['dial_code'] == dialCode) {
        return element;
      }
    }
    return null;
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      var fileFromImage = File(image.path);
      var basename = path.basenameWithoutExtension(fileFromImage.path);
      var fileFromPath =
          fileFromImage.path.split(path.basename(fileFromImage.path))[0];

      var filePathAndBasename = "$fileFromPath${basename}_image.jpg";
      final compressionResult = await FlutterImageCompress.compressAndGetFile(
        fileFromImage.absolute.path,
        filePathAndBasename,
        minWidth: 600,
        minHeight: 600,
        quality: 80,
      );

      setState(() {
        uploadedImage = compressionResult;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> _showSuccessToast() {
    fToast = FToast();
    fToast!.init(context);
    return Future.delayed(const Duration(milliseconds: 500), () {
      fToast!.showToast(
        child: const CustomToast(
          text: "Your profile was updated successfully.",
          textColor: Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Color.fromRGBO(6, 190, 86, 1),
        ),
        toastDuration: const Duration(seconds: 5),
        gravity: ToastGravity.TOP,
      );
    });
  }

  onUpdateProfile() async {
    try {
      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
      await EasyLoading.show(
        indicator: const CircularProgressIndicator(
          color: Color.fromRGBO(13, 178, 84, 1),
        ),
        maskType: EasyLoadingMaskType.black,
      );
      editedUser.img =
          uploadedImage != null ? uploadedImage!.path : editedUser.img;
      editedUser.number = countryCode != null
          ? "${countryCode!.dialCode!} ${phoneNumber ?? editedUser.number}"
          : phoneNumber != null
              ? "${foundCountryCode!["dial_code"]} $phoneNumber"
              : editedUser.number;
      await UserService().updateUser(editedUser);

      if (!mounted) return;
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(editedUser);
      if (EasyLoading.isShow) {
        await EasyLoading.dismiss();
      }
      await _showSuccessToast();
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        Navigator.of(context).pop();
      });
    } catch (error) {
      if (EasyLoading.isShow) {
        await EasyLoading.dismiss();
      }

      setState(() {
        errorMsg = error.toString();
      });
    }
  }

  @override
  void dispose() {
    if (fToast != null) {
      fToast!.removeCustomToast();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final mediaQueryHeight = mediaQuery.size.height;
    final bigPhoneCheck = mediaQueryHeight >= 750;
    final onePercentOfHeight = SizeConfig.heightMultiplier;
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    imageSourceDialog() async {
      await showDialog(
        context: context,
        barrierColor: const Color.fromRGBO(98, 100, 112, 0.2),
        builder: (context) => CustomAlertDialog(
          contentPadding: EdgeInsets.zero,
          content: StatefulBuilder(builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 5.0, right: 5.0, bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Image source",
                      style: TextStyle(
                        color: const Color.fromRGBO(45, 49, 54, 1),
                        fontSize: 23 * curScaleFactor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'TT Commons',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CustomLightElevatedButton(
                      buttonText: "GALLERY",
                      shadows: const [
                        BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          blurRadius: 5.2,
                          spreadRadius: 0.0,
                          offset: Offset(-4.0, -4.0),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          blurRadius: 5.2,
                          spreadRadius: 0.0,
                          offset: Offset(-4.0, -4.0),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(231, 231, 231, 71),
                          blurRadius: 3.5,
                          spreadRadius: 0.0,
                          offset: Offset(5.0, 4.0),
                        ),
                      ],
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(2, 129, 57, 1),
                            Color.fromRGBO(7, 210, 95, 1)
                          ]),
                      textColor: const Color.fromRGBO(255, 255, 255, 1),
                      onPressed: () async {
                        await pickImage(ImageSource.gallery);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      condition: true,
                      buttonIcon: false,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CustomLightElevatedButton(
                      buttonText: "CAMERA",
                      shadows: const [
                        BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          blurRadius: 5.2,
                          spreadRadius: 0.0,
                          offset: Offset(-4.0, -4.0),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          blurRadius: 5.2,
                          spreadRadius: 0.0,
                          offset: Offset(-4.0, -4.0),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(231, 231, 231, 71),
                          blurRadius: 3.5,
                          spreadRadius: 0.0,
                          offset: Offset(5.0, 4.0),
                        ),
                      ],
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(2, 129, 57, 1),
                            Color.fromRGBO(7, 210, 95, 1)
                          ]),
                      textColor: const Color.fromRGBO(255, 255, 255, 1),
                      onPressed: () async {
                        pickImage(ImageSource.camera);
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      condition: true,
                      buttonIcon: false,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      extendBody: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: onePercentOfHeight * 6),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(169, 169, 169, 0.148),
              Color.fromRGBO(255, 255, 255, 0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<User?>(
            future: userData == null ? onGetProfileData() : null,
            builder: (ctx, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            left: 5.0, right: 20.0, bottom: 20.0),
                        child: CustomBackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const Spacer(),
                      const Center(child: CircularProgressIndicator()),
                      const Spacer(),
                    ],
                  );
                case ConnectionState.done:
                default:
                  if (snapshot.hasError) {
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                              left: 5.0, right: 20.0, bottom: 20.0),
                          child: CustomBackButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const Spacer(),
                        const Center(
                          child: Text("error when getting profile."),
                        ),
                        const Spacer(),
                      ],
                    );
                  }

                  if (snapshot.hasData) {
                    if (!isUserSet) {
                      editedUser = snapshot.data!;

                      List<String> splitPhone = editedUser.number!.split(' ');
                      if (splitPhone.length > 1) {
                        noCodeNumber = splitPhone[1];
                      } else {
                        noCodeNumber =
                            countryCode != null ? countryCode!.dialCode : '';
                      }
                      foundCountryCode = findElementByDialCode(
                          const CountryCodePicker().countryList, splitPhone[0]);

                      isUserSet = true;
                    }

                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 5.0, right: 20.0, bottom: 10.0),
                          child: Builder(
                            builder: (context) => GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              child: ProfileAppbar(
                                title: "My Profile",
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            margin: const EdgeInsets.only(
                                                top: 10.0, bottom: 20.0),
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 81),
                                                  blurRadius: 5.2,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(-4.0, -4.0),
                                                ),
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      231, 231, 231, 71),
                                                  blurRadius: 3.5,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(5.0, 4.0),
                                                ),
                                              ],
                                            ),
                                            child: Container(
                                              height: onePercentOfHeight * 15,
                                              width: onePercentOfHeight * 15,
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        bigPhoneCheck
                                                            ? 25.0
                                                            : 15.0),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        bigPhoneCheck
                                                            ? 25.0
                                                            : 15.0),
                                                child: uploadedImage != null
                                                    ? Image.file(
                                                        uploadedImage!,
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : editedUser.img!
                                                            .contains("/images")
                                                        ? Image.network(
                                                            GenerateImageUrl
                                                                .getImage(
                                                                    editedUser
                                                                        .img!),
                                                            height:
                                                                double.infinity,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : SvgPicture.asset(
                                                            "assets/images/user_img.svg",
                                                            height:
                                                                double.infinity,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.cover,
                                                          ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Center(
                                              child: Container(
                                                width: 45,
                                                height: 45,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        Color.fromRGBO(
                                                            2, 129, 57, 1),
                                                        Color.fromRGBO(
                                                            7, 210, 95, 1)
                                                      ]),
                                                ),
                                                child: IconButton(
                                                  iconSize: 15,
                                                  icon: const Icon(
                                                    CustomIcons2.camera,
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    size: 15.0,
                                                  ),
                                                  onPressed: () async {
                                                    await imageSourceDialog();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CustomLightBorderTextformfield(
                                      initialValue: editedUser.name,
                                      customValidator: _nameValidator,
                                      customTextInputAction:
                                          TextInputAction.next,
                                      customKeyboardType: TextInputType.name,
                                      customKey: _nameKey,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      customHintText: "Full Name ...",
                                      isError: isErrorName,
                                      prefixIcon: const Icon(
                                        CustomIcons.user,
                                        color: Color.fromRGBO(188, 188, 188, 1),
                                        size: 16.0,
                                      ),
                                      onChanged: (value) => setState(() {
                                        editedUser.name = value;
                                        _nameValid =
                                            _nameKey.currentState!.validate();
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
                                            color: const Color.fromRGBO(
                                                190, 6, 6, 1),
                                          ),
                                        ),
                                      ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20.0),
                                      child: Stack(
                                        children: [
                                          CustomLightBorderTextformfield(
                                            initialValue: noCodeNumber,
                                            customValidator: _phoneValidator,
                                            customTextInputAction:
                                                TextInputAction.next,
                                            customKeyboardType:
                                                TextInputType.phone,
                                            customKey: _phoneKey,
                                            textCapitalization:
                                                TextCapitalization.none,
                                            customHintText: "Mobile ...",
                                            prefix: Container(
                                              width: 100.0,
                                            ),
                                            onChanged: (value) => setState(() {
                                              isErrorPhone = false;
                                              phoneNumber = value;
                                              _phoneValid = _phoneKey
                                                  .currentState!
                                                  .validate();
                                            }),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 70.0, top: 15.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Color.fromRGBO(
                                                      188, 188, 188, 1),
                                                  size: 20.0,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10.0, bottom: 5.0),
                                                  child: const Icon(
                                                    CustomIcons.phone,
                                                    color: Color.fromRGBO(
                                                        188, 188, 188, 1),
                                                    size: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              left: 20.0,
                                            ),
                                            child: CountryCodePicker(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              alignLeft: true,
                                              onChanged: (value) {
                                                countryCode = value;
                                              },
                                              initialSelection:
                                                  foundCountryCode!["code"],
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
                                            color: const Color.fromRGBO(
                                                190, 6, 6, 1),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    CustomLightBorderTextformfield(
                                      initialValue: editedUser.email,
                                      customValidator: _emailValidator,
                                      customTextInputAction:
                                          TextInputAction.next,
                                      customKeyboardType:
                                          TextInputType.emailAddress,
                                      customKey: _emailKey,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      customHintText: "Email ...",
                                      isError: isErrorEmail,
                                      prefixIcon: const Icon(
                                        CustomIcons.email,
                                        color: Color.fromRGBO(188, 188, 188, 1),
                                        size: 16.0,
                                      ),
                                      onChanged: (value) => setState(() {
                                        isErrorEmail = false;
                                        editedUser.email = value;
                                        _emailValid =
                                            _emailKey.currentState!.validate();
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
                                            color: const Color.fromRGBO(
                                                190, 6, 6, 1),
                                          ),
                                        ),
                                      ),
                                    SizedBox(
                                      height: onePercentOfHeight * 2,
                                    ),
                                    CustomLightBorderTextformfield(
                                      customValidator: _passwordValidator,
                                      customTextInputAction:
                                          TextInputAction.done,
                                      customKeyboardType:
                                          TextInputType.visiblePassword,
                                      customKey: _passwordKey,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      customHintText: "Password ...",
                                      prefixIcon: const Icon(
                                        CustomIcons.key,
                                        color: Color.fromRGBO(188, 188, 188, 1),
                                        size: 16.0,
                                      ),
                                      obscureText: _obscureText,
                                      suffixIcon: Container(
                                        margin:
                                            const EdgeInsets.only(right: 5.0),
                                        child: IconButton(
                                          icon: Icon(
                                            _obscureText
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: const Color.fromRGBO(
                                                188, 188, 188, 1),
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
                                        editedUser.password = value;
                                        _passwordValid = _passwordKey
                                            .currentState!
                                            .validate();
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
                                            color: const Color.fromRGBO(
                                                190, 6, 6, 1),
                                          ),
                                        ),
                                      ),
                                    SizedBox(
                                      height: onePercentOfHeight * 2,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child:
                                                CustomLightNeumrphicElevatedButton(
                                              buttonText: "CANCEL",
                                              border: Border.all(
                                                color: const Color.fromRGBO(
                                                    13, 178, 84, 1),
                                                width: 1,
                                              ),
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  blurRadius: 5.2,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(-4.0, -4.0),
                                                ),
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  blurRadius: 5.2,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(-4.0, -4.0),
                                                ),
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      231, 231, 231, 0.71),
                                                  blurRadius: 3.5,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(5.0, 4.0),
                                                ),
                                              ],
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              textColor: const Color.fromRGBO(
                                                  13, 178, 84, 1),
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                              },
                                              condition: true,
                                              margin: const EdgeInsets.only(
                                                  left: 10.0, right: 5.0),
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomLightElevatedButton(
                                              buttonText: "CHANGE",
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  blurRadius: 5.2,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(-4.0, -4.0),
                                                ),
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  blurRadius: 5.2,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(-4.0, -4.0),
                                                ),
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      231, 231, 231, 71),
                                                  blurRadius: 3.5,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(5.0, 4.0),
                                                ),
                                              ],
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: (_nameValid ||
                                                              _phoneValid ||
                                                              _emailValid) &&
                                                          _passwordValid
                                                      ? [
                                                          const Color.fromRGBO(
                                                              2, 129, 57, 1),
                                                          const Color.fromRGBO(
                                                              7, 210, 95, 1)
                                                        ]
                                                      : [
                                                          const Color.fromRGBO(
                                                              2, 129, 57, 0.5),
                                                          const Color.fromRGBO(
                                                              7, 210, 95, 0.5)
                                                        ]),
                                              textColor: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              onPressed: () async {
                                                await onUpdateProfile();
                                              },
                                              condition: (_nameValid ||
                                                      _phoneValid ||
                                                      _emailValid) &&
                                                  _passwordValid,
                                              buttonIcon: false,
                                              margin: const EdgeInsets.only(
                                                  left: 5.0, right: 10.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                              left: 5.0, right: 20.0, bottom: 20.0),
                          child: CustomBackButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const Spacer(),
                        const Center(
                          child: Text("error when getting profile."),
                        ),
                        const Spacer(),
                      ],
                    );
                  }
              }
            }),
      ),
    );
  }
}
