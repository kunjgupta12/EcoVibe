import 'package:flutter/foundation.dart';

import '../../../Models/Other/EnumToString.dart';
import '../../../Models/Other/Enums.dart';
import '../../../Models/Other/StringToEnum.dart';

class Payment {
  PaymentStatus? paymentStatus;
  late PaymentMode paymentMode;
  late double amount;

  Payment({
    required this.paymentStatus,
    required this.paymentMode,
    required this.amount,
  });

  Payment.fromMap(Map<String, dynamic> map) {
    this.paymentMode = String2Enum.getPaymentMode(map["paymentMode"]);
    this.paymentStatus = String2Enum.getPaymentStatus(map["paymentStatus"]);
    this.amount = (map["amount"]).toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      "paymentStatus": Enum2String.getPaymentStatus(this.paymentStatus!),
      "paymentMode": Enum2String.getPaymentMode(this.paymentMode!),
      "amount": this.amount,
    };
  }

  @override
  String toString() {
    return 'Payment{paymentStatus: $paymentStatus, paymentMode: $paymentMode, amount: $amount}';
  }
}
