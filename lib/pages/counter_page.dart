import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/counter_provider.dart';
import '../providers/second_provider.dart';
import '../widgets/provider_listener.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProviderListener(
      listeners: [
        ProviderListener<Counter>(
          listener: (context, counter) {
            print('Counter page value: ${counter.count}');

            // if counter value is 5, then increment second provider
            if (counter.count == 5) {
              context.read<SecondProvider>().increment();
            }
          },
        ),
        ProviderListener<SecondProvider>(
          listener: (context, counter) {
            print('Second provider value: ${counter.count}');
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Provider Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Consumer<Counter>(
                builder: (context, counter, child) => Text(
                  '${counter.count}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<Counter>().increment();
            // context.read<SecondProvider>().increment();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
