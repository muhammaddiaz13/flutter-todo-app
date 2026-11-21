import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pertemuan6_firebase/models/todo.dart';

class FirestoreService {
  final CollectionReference _todosCollection = 
      FirebaseFirestore.instance.collection('todos');

// Menamnbahkan tugas/Todo baru dari firestore
Future<void> addTodo(String taskName) async {
  final newTodo = Todo(
    id: '',
    task: taskName, 
    isDone: false,
  );
  await _todosCollection.add(newTodo.toMap());
}

Stream<List<Todo>> getTodos() {
  return _todosCollection
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList());
}

  // Update status tugas/Todo di firestore
  Future<void> updateTodoStatus(String todoId, bool currentStatus) async {
  await _todosCollection.doc(todoId).update({'isDone': !currentStatus});
  }

  //Delete tugas/Todo dari firestore
  Future<void> deleteTodo(String todoId) async {
  await _todosCollection.doc(todoId).delete();
  }
}