import '../../../../generated/objectbox.g.dart';
import '../entities/user_entity.dart';

class UserDao{
  late final Box<UserEntity> _userBox;

  UserDao(Store store){
    _userBox = store.box<UserEntity>();
  }

  int insert(UserEntity user) => _userBox.put(user);

  UserEntity? get(int id) => _userBox.get(id);

  UserEntity? getByEmail(String email) {
    return _userBox.query(UserEntity_.email.equals(email))
        .build().findFirst();
  }

  bool delete(int id) => _userBox.remove(id);

}