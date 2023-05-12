import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interview_demo_application/models/todo.dart';

class TodoController extends ChangeNotifier {
  bool isLoading = false;
  Task? task;

  Future<void> addTask(
      String title, String? description, String dateTime) async {
    isLoading = true;
    notifyListeners();
    final docRef = FirebaseFirestore.instance.collection('tasks').doc();
    final task = Task(
      id: docRef.id,
      title: title,
      description: description,
      dateTime: dateTime,
    );
    final json = task.toJson();

    await docRef.set(json);
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTaskById(String id) async {
    final docRef = FirebaseFirestore.instance.collection('tasks').doc(id);
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      task = Task.fromJson(snapshot.data()!);
      notifyListeners();
    }
  }

  Future<void> updateTask({
    required String id,
    required String title,
    String? description,
    required String dateTime,
  }) async {
    isLoading = true;
    notifyListeners();
    final docRef = FirebaseFirestore.instance.collection('tasks').doc(id);
    final task = Task(
      id: docRef.id,
      title: title,
      description: description,
      dateTime: dateTime,
    );
    final json = task.toJson();
    await docRef.update(json);
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTaskById(String id) async {
    final docRef = FirebaseFirestore.instance.collection('tasks').doc(id);
    await docRef.delete();
  }

  Stream<List<Task>> fetchTasks() =>
      FirebaseFirestore.instance.collection('tasks').snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Task.fromJson(
                    doc.data(),
                  ),
                )
                .toList(),
          );
}
