import '../../shared/data/user_entity.dart';
import '../domain/auth_info.dart';

extension ToEntity on AuthInfo{
  UserEntity toUserEntity() => UserEntity(
      name: name,
      email: email,
      password: password
  );
}