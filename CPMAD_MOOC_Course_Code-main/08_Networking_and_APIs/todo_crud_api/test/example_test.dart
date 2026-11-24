import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:todo_crud_api/todo_api.dart';

void main() {
  test('sends GET, POST, PUT and DELETE with the expected paths', () async {
    final requests = <http.Request>[];
    final client = MockClient((request) async {
      requests.add(request);
      const item = {'id': 1, 'todo': 'Practice Flutter', 'completed': true};
      return http.Response(
        jsonEncode(
          request.method == 'GET'
              ? {
                  'todos': [item],
                }
              : item,
        ),
        request.method == 'POST' ? 201 : 200,
      );
    });
    addTearDown(client.close);
    final api = TodoApi(client);

    expect((await api.fetch()).single.id, 1);
    expect((await api.create('Practice Flutter')).title, 'Practice Flutter');
    expect((await api.update(1, true)).isCompleted, isTrue);
    await api.delete(1);
    expect(requests.map((request) => '${request.method} ${request.url.path}'), [
      'GET /todos',
      'POST /todos/add',
      'PUT /todos/1',
      'DELETE /todos/1',
    ]);
    expect(jsonDecode(requests[1].body)['todo'], 'Practice Flutter');
    expect(jsonDecode(requests[2].body), {'completed': true});
  });

  test('rejects unsuccessful writes', () async {
    final client = MockClient((_) async => http.Response('{}', 404));
    addTearDown(client.close);
    final api = TodoApi(client);
    await expectLater(api.update(99, true), throwsException);
    await expectLater(api.delete(99), throwsException);
  });
}
