import 'package:doing/models/todo.model.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class TodoService extends ChangeNotifier {
  /// Collection name constant
  static const remaining = "remaining";
  static const done = "done";

  /// Internal, private state of the cart.
  late Map<String, Todo> _remainingTodo;
  late Map<String, Todo> _doneTodo;

  Map<String, Todo> get remainingTodo => _remainingTodo;
  Map<String, Todo> get doneTodo => _doneTodo;

  TodoService(
      Map<String, Todo> _preloadedRemaining,
      Map<String, Todo> _preloadedDone
      ) {
    _remainingTodo = _preloadedRemaining;
    _doneTodo = _preloadedDone;
  }

  static Map<String, Todo> getTodosFromCollection(String collection) {
    final _db = Localstore.instance;
    var _preloadedTodo = <String, Todo>{};

    _db.collection(collection).stream.listen((event) {
      _preloadedTodo.putIfAbsent(event['id'], () => Todo(id: event['id'], title: event["title"], description: event["description"], isDone: collection == done));
    });
    return _preloadedTodo;
  }

  Map<String, dynamic> _toMap(Todo todo) {
    var map = <String, dynamic>{};

    map['id'] = todo.id;
    map['title'] = todo.title;
    map['description'] = todo.description;
    map['isDone'] = todo.isDone;
    return map;
  }

  String _createUniqueId(String collection) {
    return Localstore.instance
        .collection(collection)
        .doc()
        .id;
  }

  Todo _createNewTodo(String collection, String title, String description) {
    final id = _createUniqueId(collection);

    return Todo(title: title,
        description: description,
        id: id,
        isDone: collection == done);
  }

  _transferTask(String fromCollection, String toCollection,
      Todo fromTodo) async {
    final _db = Localstore.instance;
    final toTodo = _createNewTodo(
        toCollection, fromTodo.title, fromTodo.description);

    await _db.collection(fromCollection).doc(fromTodo.id).delete();
    if (toCollection == remaining) {
      _doneTodo.remove(fromTodo.id);
      _remainingTodo[toTodo.id] = toTodo;
    } else {
      _remainingTodo.remove(fromTodo.id);
      _doneTodo[toTodo.id] = toTodo;
    }
    await _db.collection(toCollection).doc(toTodo.id).set(_toMap(toTodo));
  }

  add(String collection, String title, String description) async {
    final _db = Localstore.instance;
    final todo = _createNewTodo(collection, title, description);

    if (collection == remaining) {
      _remainingTodo[todo.id] = todo;
    } else {
      _doneTodo[todo.id] = todo;
    }
    await _db.collection(collection).doc(todo.id).set(_toMap(todo));
    notifyListeners();
  }

  update(String collection, String id, String title, String description) async {
    final _db = Localstore.instance;
    late Todo? todoToUpdate;

    if (collection == remaining) {
      todoToUpdate = _remainingTodo[id];
    } else {
      todoToUpdate = _doneTodo[id];
    }
    if (todoToUpdate != null) {
      todoToUpdate.setTitle(title);
      todoToUpdate.setDescription(description);
      await _db.collection(collection).doc(id).set(_toMap(todoToUpdate));
      notifyListeners();
    }
  }

  setToDone(String id) {
    final fromTodo = _remainingTodo[id];

    if (fromTodo != null) {
      _transferTask(remaining, done, fromTodo);
      notifyListeners();
    }
  }

  setToRemaining(String id) {
    final fromTodo = _doneTodo[id];

    if (fromTodo != null) {
      _transferTask(done, remaining, fromTodo);
      notifyListeners();
    }
  }

  delete(String collection, String id) async {
    final _db = Localstore.instance;

    await _db.collection(collection).doc(id).delete();
    if (collection == remaining) {
      _remainingTodo.remove(id);
    } else {
      _doneTodo.remove(id);
    }
    notifyListeners();
  }

  deleteAll() {
    final _db = Localstore.instance;

    _remainingTodo.forEach((key, value) async {
      await _db.collection(remaining).doc(key).delete();
      _remainingTodo.remove(key);
    });
    _doneTodo.forEach((key, value) async {
      await _db.collection(done).doc(key).delete();
      _doneTodo.remove(key);
    });
    notifyListeners();
  }
}