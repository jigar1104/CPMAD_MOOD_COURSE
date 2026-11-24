import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const QuoteApp());

class Quote {
  const Quote({required this.content, required this.author});

  final String content;
  final String author;

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      content: json['quote'] as String,
      author: json['author'] as String,
    );
  }
}

Future<Quote> fetchQuote(http.Client client) async {
  final response = await client
      .get(Uri.https('dummyjson.com', '/quotes/random'))
      .timeout(const Duration(seconds: 8));
  if (response.statusCode != 200) {
    throw Exception('HTTP ${response.statusCode}');
  }
  return Quote.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
}

class QuoteController extends GetxController {
  final _client = http.Client();
  final quote = Rxn<Quote>();
  final loading = false.obs;
  final error = RxnString();

  @override
  void onInit() {
    super.onInit();
    refreshQuote();
  }

  Future<void> refreshQuote() async {
    if (loading.value) return;
    loading.value = true;
    error.value = null;
    try {
      quote.value = await fetchQuote(_client);
    } catch (exception) {
      error.value = 'Could not load a quote. $exception';
    } finally {
      loading.value = false;
    }
  }

  @override
  void onClose() {
    _client.close();
    super.onClose();
  }
}

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quote App',
      initialBinding: BindingsBuilder(() => Get.lazyPut(QuoteController.new)),
      home: const QuoteScreen(),
    );
  }
}

class QuoteScreen extends GetView<QuoteController> {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quote App')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Obx(() {
            if (controller.loading.value) {
              return const CircularProgressIndicator();
            }

            final quote = controller.quote.value;
            final error = controller.error.value;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (quote != null) ...[
                  Text(
                    '“${quote.content}”',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(quote.author),
                ],
                if (error != null) Text(error, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: controller.refreshQuote,
                  child: Text(error == null ? 'Get another quote' : 'Retry'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
