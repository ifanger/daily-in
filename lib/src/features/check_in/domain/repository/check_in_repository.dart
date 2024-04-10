import 'package:daily_in/src/features/check_in/data/data_source/check_in_firebase_data_source.dart';
import 'package:daily_in/src/features/check_in/domain/entity/check_in_entity.dart';

abstract class CheckInRepository {
  Stream<List<CheckInEntity>> get stream;

  CheckInEntity create(CheckInEntity entity);

  Future<void> delete(String id);

  Future<void> update(CheckInEntity entity);
}

class CheckInFirebaseRepository extends CheckInRepository {
  CheckInFirebaseRepository(this._dataSource);

  final CheckInFirebaseDataSource _dataSource;

  final userId = '123';

  @override
  CheckInEntity create(CheckInEntity entity) {
    return _dataSource.create(userId, entity);
  }

  @override
  Future<void> delete(String id) async {
    _dataSource.delete(userId, id);
  }

  @override
  Stream<List<CheckInEntity>> get stream {
    return _dataSource.listen(userId);
  }

  @override
  Future<void> update(CheckInEntity entity) async {
    _dataSource.update(userId, entity);
  }
}
