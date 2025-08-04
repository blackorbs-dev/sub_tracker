import '../../../generated/objectbox.g.dart';
import '../../wallet/data/entity/wallet_entity.dart';
import 'user_entity.dart';

class UserDao{
  final Box<UserEntity> _userBox;
  final Box<WalletEntity> _walletBox;

  UserDao(Store store):
        _userBox = store.box<UserEntity>(),
        _walletBox = store.box<WalletEntity>();

  int insert(UserEntity user) {
    final userId = _userBox.put(user);
    _walletBox.put(
        WalletEntity()..user.targetId = userId
    );
    return userId;
  }

  UserEntity? get(int id) => _userBox.get(id);

  UserEntity? getByEmail(String email) {
    return _userBox.query(UserEntity_.email.equals(email))
        .build().findFirst();
  }

  bool delete(int id) => _userBox.remove(id);
}

