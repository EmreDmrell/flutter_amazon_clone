import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_text_field.dart';
import 'package:flutter_amazon_clone/constants/config.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/address/services/address_services.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  final String totalAmount;
  static const String routeName = "/address";
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressSignUpFormKey = GlobalKey<FormState>();
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  /// Sample [PaymentConfiguration] for Apple Pay
  final defaultApplePayConfig =
      PaymentConfiguration.fromJsonString(defaultApplePay);

  /// Sample [PaymentConfiguration] for Google Pay
  final defaultGooglePayConfig =
      PaymentConfiguration.fromJsonString(defaultGooglePay);

  List<PaymentItem> paymentItems = [];
  String addressToBeUsed = '';
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalAmount: double.parse(widget.totalAmount),
    );
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalAmount: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = '';

    bool isFormFilled = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isFormFilled) {
      if (_addressSignUpFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${pincodeController.text}, ${cityController.text}';
      } else {
        throw Exception('Please fill the form');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 20,
            children: [
              if (address.isNotEmpty)
                Column(
                  spacing: 20,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              Form(
                  key: _addressSignUpFormKey,
                  child: Column(
                    spacing: 10,
                    children: [
                      CustomTextField(
                        controller: flatBuildingController,
                        hintText:
                            'Flat, House No., Building, Company, Apartment',
                        keyboardType: TextInputType.text,
                      ),
                      CustomTextField(
                        controller: areaController,
                        hintText: 'Area, Colony, Street, Sector, Village',
                        keyboardType: TextInputType.text,
                      ),
                      CustomTextField(
                        controller: pincodeController,
                        hintText: 'Pincode',
                        keyboardType: TextInputType.text,
                      ),
                      CustomTextField(
                        controller: cityController,
                        hintText: 'Town/City',
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  )),
              if (Theme.of(context).platform == TargetPlatform.iOS)
                ApplePayButton(
                  onPressed: () {
                    payPressed(address);
                    onApplePayResult(null);
                  },
                  paymentConfiguration:
                      PaymentConfiguration.fromJsonString(defaultApplePay),
                  paymentItems: paymentItems,
                  style: ApplePayButtonStyle.black,
                  type: ApplePayButtonType.buy,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: onApplePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              GooglePayButton(
                onPressed: () {
                  payPressed(address);
                },
                width: double.maxFinite,
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString(defaultGooglePay),
                paymentItems: paymentItems,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
