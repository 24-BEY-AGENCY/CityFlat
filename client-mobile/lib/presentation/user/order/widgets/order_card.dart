import 'package:cityflat/models/order_model.dart';
import 'package:cityflat/services/order_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../shared/widgets/custom_icons2.dart';
import '../../../shared/widgets/custom_toast.dart';
import '../screens/one_order_dialog.dart';

class OrderCard extends StatefulWidget {
  final Order? order;

  const OrderCard({super.key, this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  FToast? fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  void _showFailureToast() {
    Future.delayed(const Duration(milliseconds: 500), () {
      fToast!.showToast(
        child: const CustomToast(
          text: "An error has occurred. Please retry.",
          textColor: Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Color.fromRGBO(190, 6, 6, 1),
        ),
        toastDuration: const Duration(seconds: 5),
        gravity: ToastGravity.TOP,
      );
    });
  }

  openOrderDialog() async {
    try {
      await EasyLoading.show(
        indicator: const CircularProgressIndicator(
          color: Color.fromRGBO(13, 178, 84, 1),
        ),
        maskType: EasyLoadingMaskType.black,
      );
      final oneOrder =
          await OrderService().getOneOrderByUser(widget.order!.id!);
      if (EasyLoading.isShow) {
        await EasyLoading.dismiss();
      }
      if (!mounted) return;
      await showDialog(
        context: context,
        barrierColor: const Color.fromRGBO(98, 100, 112, 0.2),
        builder: (context) => OneOrderDialog(order: oneOrder),
      );
    } catch (error) {
      if (EasyLoading.isShow) {
        await EasyLoading.dismiss();
      }
      _showFailureToast();
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
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    return GestureDetector(
      onTap: () async {
        await openOrderDialog();
      },
      child: Neumorphic(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20.0)),
          border:
              const NeumorphicBorder(color: Color.fromRGBO(222, 222, 222, 1)),
          depth: -4,
          intensity: 0.6,
          lightSource: LightSource.topLeft,
          color: const Color.fromRGBO(247, 247, 247, 1),
          shadowDarkColorEmboss: const Color.fromRGBO(0, 0, 0, 0.5),
          shadowLightColorEmboss: const Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Container(
          padding: const EdgeInsets.all(21.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(13, 178, 84, 0.07),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(
                  CustomIcons2.invoice,
                  color: Color.fromRGBO(13, 178, 84, 1),
                  size: 17.0,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                "Invoice",
                style: TextStyle(
                  color: const Color.fromRGBO(45, 49, 54, 1),
                  fontSize: 14 * curScaleFactor,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(2, 129, 57, 1),
                        Color.fromRGBO(7, 210, 95, 1)
                      ]),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: IconButton(
                  iconSize: 15,
                  icon: SvgPicture.asset(
                    "assets/icons/svg/eye.svg",
                    fit: BoxFit.fitWidth,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  onPressed: () async {
                    await openOrderDialog();
                  },
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
