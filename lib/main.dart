import 'package:crypto/cubits/crypto/crypto_cubit.dart';
import 'package:crypto/services/crypto_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/crypto_screen.dart';

void main() {
  runApp(CryptoApp());
}

class CryptoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CryptoCubit(CryptoService()),
      child: MaterialApp(
        title: 'Crypto Market',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: CryptoMarketPage(),
      ),
    );
  }
}
