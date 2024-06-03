import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: MainPage(),
      ),
    );
  }
}

final catFactProvider = FutureProvider.autoDispose((ref) async {
  await Future.delayed(const Duration(seconds: 5));
  final response = await http.get(Uri.https('catfact.ninja', '/fact'));
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  return json['fact'];
});

class MainPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Fact'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CatFactPage()));
            }, child: const Text('Get Cat Fact')),
          ],
        ),
      ),
    );
  }
}

// cat fact widget
class CatFactPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fact = ref.watch(catFactProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Fact'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(fact.when(
              skipLoadingOnRefresh: false,
              data: (data) => data.toString(),
              loading: () => 'Loading...',
              error: (error, stack) => 'Error: $error',
            )),
            OutlinedButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: const Text('Back')),
          ],
        ),
      ),
    );
  }

}

