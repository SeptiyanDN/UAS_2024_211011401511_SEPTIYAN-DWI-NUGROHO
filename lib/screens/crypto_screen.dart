import 'package:crypto/cubits/crypto/crypto_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoMarketPage extends StatefulWidget {
  @override
  _CryptoMarketPageState createState() => _CryptoMarketPageState();
}

class _CryptoMarketPageState extends State<CryptoMarketPage> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<CryptoCubit>().fetchCrypto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Market'),
      ),
      body: <Widget>[
        BlocBuilder<CryptoCubit, CryptoState>(
          builder: (context, state) {

            print('state: $state')
            if (state is CryptoLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CryptoLoaded) {
              final cryptos = state.crypto.data;
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Market is down - 11.17%',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        Icon(Icons.search),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Coins', style: TextStyle(fontSize: 18)),
                        DropdownButton<String>(
                          value: 'INR',
                          items: <String>['INR', 'USD'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text('Market - $value'),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cryptos?.length ?? 0,
                      itemBuilder: (context, index) {
                        final crypto = cryptos![index];
                        return ListTile(
                          leading: Icon(Icons.account_balance_wallet),
                          title: Text(crypto.name ?? ''),
                          subtitle: Text(crypto.symbol ?? ''),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(''),
                              Text(
                                '${crypto.percentChange24h}%',
                                style: TextStyle(
                                  color: double.tryParse(
                                              crypto.percentChange24h ?? '') ??
                                          0 >= 0
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is CryptoError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('Unknown state'));
          },
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}

class Crypto {
  final String name;
  final String symbol;
  final double price;
  final double change;

  Crypto({
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
  });
}

class CustomNavigationBar extends StatefulWidget {
  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;

  const CustomNavigationBar({
    required this.onDestinationSelected,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: widget.onDestinationSelected,
      indicatorColor: Colors.amber,
      selectedIndex: widget.selectedIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Badge(child: Icon(Icons.notifications_sharp)),
          label: 'Notifications',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('2'),
            child: Icon(Icons.messenger_sharp),
          ),
          label: 'Messages',
        ),
      ],
    );
  }
}
