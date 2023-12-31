part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class LoadPaymentMethod extends PaymentEvent {}

class SelectPaymentMethod extends PaymentEvent {
  final PaymentMethod paymentMethod;

  const SelectPaymentMethod({required this.paymentMethod});

  @override
  List<Object> get props => [paymentMethod];
}