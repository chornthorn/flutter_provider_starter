import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/counter_provider.dart';
import '../widgets/provider_listener.dart';
import 'counter_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProviderListener(
      listeners: [
        ProviderListener<Counter>(
          listener: (context, counter) {
            print('Counter value: ${counter.count}');

            // show loading dialog
            if (counter.isLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              // hide loading dialog
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          },
        ),
        ProviderListener<AuthProvider>(
          listener: (context, model) {
            // show loading dialog
            if (model.isLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              // hide loading dialog
              Navigator.of(context).pop();
            }

            // redirect to home page if user is authenticated
            if (!model.isAuthenticated) {
              context.read<Counter>().reset();
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login',
                (route) => false,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Provider Demo'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthProvider>().logout();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CounterPage(),
                    ),
                  );
                },
                child: const Text('Go to Counter Page'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<Counter>().increment(),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
