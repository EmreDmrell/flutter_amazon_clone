import 'package:flutter_dotenv/flutter_dotenv.dart';

//String homeIpAddress = "http://192.168.1.176:3000";

String homeIpAddress =  dotenv.env['API_URL']!;

//Cloudinary Presets

String CLOUD_NAME =  dotenv.env['CLOUD_NAME']!;
String UPLOAD_PRESET = dotenv.env['UPLOAD_RESET']!;

/// Sample configuration for Apple Pay. Contains the same content as the file
/// under `assets/default_payment_profile_apple_pay.json`.

const String defaultApplePay = '''{
  "provider": "apple_pay",
  "data": {
    "merchantIdentifier": "merchant.com.sams.fish",
    "displayName": "Sam's Fish",
    "merchantCapabilities": ["3DS", "debit", "credit"],
    "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
    "countryCode": "US",
    "currencyCode": "USD",
    "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber", "postalAddress"],
    "requiredShippingContactFields": [],
    "shippingMethods": [
      {
        "amount": "0.00",
        "detail": "Available within an hour",
        "identifier": "in_store_pickup",
        "label": "In-Store Pickup"
      },
      {
        "amount": "4.99",
        "detail": "5-8 Business Days",
        "identifier": "flat_rate_shipping_id_2",
        "label": "UPS Ground"
      },
      {
        "amount": "29.99",
        "detail": "1-3 Business Days",
        "identifier": "flat_rate_shipping_id_1",
        "label": "FedEx Priority Mail"
      }
    ]
  }
}''';


/// Sample configuration for Google Pay. Contains the same content as the file
/// under `assets/default_payment_profile_google_pay.json`.
  const String defaultGooglePay = '''{
  "provider": "google_pay",
  "data": {
    "environment": "TEST",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "example",
            "gatewayMerchantId": "gatewayMerchantId"
          }
        },
        "parameters": {
          "allowedCardNetworks": ["VISA", "MASTERCARD"],
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "billingAddressRequired": true,
          "billingAddressParameters": {
            "format": "FULL",
            "phoneNumberRequired": false
          }
        }
      }
    ],
    "merchantInfo": {
      "merchantName": "Example Merchant Name"
    },
    "transactionInfo": {
      "countryCode": "TR",
      "currencyCode": "TRY"
    }
  }
}''';