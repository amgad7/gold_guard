import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/alert_model.dart';

class AlertFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const String _collection = 'price_alerts';

  String? get currentUserId => _auth.currentUser?.uid;

  Future<void> addAlert(AlertModel alert) async {
    try {
      final docRef = _firestore.collection(_collection).doc();

      final alertWithId = alert.copyWith(id: docRef.id);

      await docRef.set(alertWithId.toJson());
    } catch (e) {
      throw Exception('Failed to add alert: $e');
    }
  }

  Future<List<AlertModel>> getUserAlerts() async {
    try {
      if (currentUserId == null) {
        throw Exception('User not logged in');
      }

      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: currentUserId)
          .get();

      final alerts = snapshot.docs
          .map((doc) => AlertModel.fromJson(doc.data()))
          .toList();

      alerts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return alerts;
    } catch (e) {
      throw Exception('Failed to get alerts: $e');
    }
  }

  Future<List<AlertModel>> getActiveAlerts() async {
    try {
      if (currentUserId == null) {
        throw Exception('User not logged in');
      }

      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: currentUserId)
          .where('isActive', isEqualTo: true)
          .where('isTriggered', isEqualTo: false)
          .get();

      return snapshot.docs
          .map((doc) => AlertModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get active alerts: $e');
    }
  }

  Future<void> updateAlertStatus({
    required String alertId,
    required bool isActive,
  }) async {
    try {
      await _firestore.collection(_collection).doc(alertId).update({
        'isActive': isActive,
      });
    } catch (e) {
      throw Exception('Failed to update alert: $e');
    }
  }

  Future<void> markAlertAsTriggered(String alertId) async {
    try {
      await _firestore.collection(_collection).doc(alertId).update({
        'isTriggered': true,
        'isActive': false,
      });
    } catch (e) {
      throw Exception('Failed to mark alert as triggered: $e');
    }
  }

  Future<void> deleteAlert(String alertId) async {
    try {
      await _firestore.collection(_collection).doc(alertId).delete();
    } catch (e) {
      throw Exception('Failed to delete alert: $e');
    }
  }

  Future<void> deleteAllUserAlerts() async {
    try {
      if (currentUserId == null) return;

      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: currentUserId)
          .get();

      final batch = _firestore.batch();

      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to delete all alerts: $e');
    }
  }

  Stream<List<AlertModel>> watchActiveAlerts() {
    if (currentUserId == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: currentUserId)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => AlertModel.fromJson(doc.data()))
              .toList();
        });
  }
}
