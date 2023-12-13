import 'package:ecommerce_app/models/checkout_model.dart';

abstract class BaseCheckoutRepository {
  Future<void> addCheckout(Checkout checkout);
}