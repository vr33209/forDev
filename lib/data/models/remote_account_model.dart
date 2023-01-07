import 'package:fordev/data/http/http_error.dart';
import 'package:fordev/domain/entities/account_entity.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map<dynamic, dynamic>? json) {
    if (json != null) {
      if (!json.containsKey('accessToken')) {
        throw HttpError.invalidData;
      }
      return RemoteAccountModel(json['accessToken']);
    } else {
      throw HttpError.serverError;
    }
  }

  AccountEntity toEntity() => AccountEntity(accessToken);
}
