import 'package:bloc/bloc.dart';
import 'package:crypto/models/cryipto_model.dart';
import 'package:crypto/services/crypto_service.dart';
import 'package:meta/meta.dart';

part 'crypto_state.dart';

class CryptoCubit extends Cubit<CryptoState> {
  final CryptoService _cryptoService;

  CryptoCubit(this._cryptoService) : super(CryptoInitial());

  Future<void> fetchCrypto() async {
    try {
      emit(CryptoLoading());
      final crypto = await _cryptoService.fetchCrypto();
      emit(CryptoLoaded(crypto));
    } catch (e) {
      emit(CryptoError("Failed to fetch data"));
    }
  }
}
