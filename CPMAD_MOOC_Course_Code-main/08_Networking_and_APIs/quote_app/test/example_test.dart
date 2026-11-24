import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quote_app/main.dart';

void main() {
  test('decodes the quote returned by the random endpoint', () async {
    final client = MockClient((request) async {
      expect(request.method, 'GET');
      expect(request.url.path, '/quotes/random');
      return http.Response(
        '{"quote":"Learn by building.","author":"Taylor"}',
        200,
      );
    });
    addTearDown(client.close);
    final quote = await fetchQuote(client);
    expect(quote.content, 'Learn by building.');
    expect(quote.author, 'Taylor');
  });

  test('propagates HTTP failure', () async {
    final client = MockClient((_) async => http.Response('', 503));
    addTearDown(client.close);
    await expectLater(fetchQuote(client), throwsException);
  });
}
