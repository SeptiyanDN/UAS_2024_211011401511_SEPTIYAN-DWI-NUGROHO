part of 'crypto_cubit.dart';

@immutable
abstract class CryptoState {}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoLoaded extends CryptoState {
  final Crypto crypto;

  CryptoLoaded(this.crypto);
}

class CryptoError extends CryptoState {
  final String message;

  CryptoError(this.message);
}
