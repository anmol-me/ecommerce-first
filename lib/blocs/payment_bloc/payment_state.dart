part of 'payment_bloc.dart';

@immutable
sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final PaymentMethod paymentMethod;

  const PaymentLoaded({
    this.paymentMethod = PaymentMethod.google_pay,
  });

  @override
  List<Object> get props => [paymentMethod];
}