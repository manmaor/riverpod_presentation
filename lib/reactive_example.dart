import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

final counterProvider = StateProvider((_) => 0);

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int value = ref.watch(counterProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('You have pushed the button this many times:'),
              Text(
                '$value',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              OutlinedButton(onPressed: () {
                ref.read(counterProvider.notifier).state++;
              }, child: const Text('Increment')),
            ],
          ),
        ),
      ),
    );
  }
}