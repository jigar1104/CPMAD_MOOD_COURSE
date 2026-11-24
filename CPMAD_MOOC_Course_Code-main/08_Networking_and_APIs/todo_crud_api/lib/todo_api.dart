import 'dart:convert';

import 'package:http/http.dart' as http;

import 'todo_task.dart';

class TodoApi {
  const TodoApi(this.client);

  final http.Client client;
  static const _headers = {'Content-Type': 'application/json'};
  static const _timeout = Duration(seconds: 8);

  Uri _url(String path, [Map<String, String>? query]) =>
      Uri.https('dummyjson.com', '/todos$path', query);

  Map<String, dynamic> _decode(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP ${response.statusCode}');
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<List<TodoTask>> fetch() async {
    final response = await client
        .get(_url('', {'limit': '8'}))
        .timeout(_timeout);
    final items = _decode(response)['todos'] as List<dynamic>;
    return items
        .map((item) => TodoTask.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<TodoTask> create(String title) async {
    final response = await client
        .post(
          _url('/add'),
          headers: _headers,
          body: jsonEncode({'todo': title, 'completed': false, 'userId': 5}),
        )
        .timeout(_timeout);
    return TodoTask.fromJson(_decode(response));
  }

  Future<TodoTask> update(int id, bool completed) async {
    final response = await client
        .put(
          _url('/$id'),
          headers: _headers,
          body: jsonEncode({'completed': completed}),
        )
        .timeout(_timeout);
    return TodoTask.fromJson(_decode(response));
  }

  Future<void> delete(int id) async {
    final response = await client.delete(_url('/$id')).timeout(_timeout);
    _decode(response);
  }
}
