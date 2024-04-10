import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_in/src/features/check_in/domain/entity/check_in_entity.dart';

class CheckInFirebaseDataSource {
  final _firestore = FirebaseFirestore.instance;

  static const _kDateField = 'date';
  static const _kCompletedField = 'completed';
  static const _kCreatedAtField = 'createdAt';
  static const _kUpdatedAtField = 'updatedAt';

  CheckInEntity create(String userId, CheckInEntity entity) {
    final document = _collection(userId).doc();
    document.set(entity);

    return entity.copyWith(id: document.id);
  }

  Future<void> delete(String userId, String id) async {
    await _collection(userId).doc(id).delete();
  }

  Stream<List<CheckInEntity>> listen(String userId) {
    return _collection(userId)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  Future<void> update(String userId, CheckInEntity entity) async {
    await _collection(userId).doc(entity.id).set(entity);
  }

  CollectionReference<CheckInEntity> _collection(String userId) =>
      _firestore.collection('users/$userId/checkins').withConverter(
            fromFirestore: (document, snapshot) {
              final Map<String, dynamic> map = document.data()!;

              return CheckInEntity(
                id: document.id,
                date: (map[_kDateField] as Timestamp).toDate(),
                completed: map[_kCompletedField] as bool,
              );
            },
            toFirestore: (entity, options) => {
              _kDateField: Timestamp.fromDate(entity.date),
              _kCompletedField: entity.completed,
              _kCreatedAtField: DateTime.now().toUtc(),
              _kUpdatedAtField: DateTime.now().toUtc(),
            },
          );
}
