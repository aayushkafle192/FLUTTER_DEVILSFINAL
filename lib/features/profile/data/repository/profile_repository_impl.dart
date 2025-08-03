import 'package:dartz/dartz.dart';
import 'package:rolo/app/shared_pref/token_shared_pref.dart';
import 'package:rolo/core/error/failure.dart';
import 'package:rolo/features/auth/domain/entity/user_entity.dart';
import 'package:rolo/features/order/data/model/shipping_address_api_model.dart';
import 'package:rolo/features/profile/data/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:rolo/features/profile/domain/entity/profile_entity.dart';
import 'package:rolo/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements IProfileRepository {
  final IProfileRemoteDataSource _remoteDataSource;
  final TokenSharedPrefs _tokenSharedPrefs;

  ProfileRepositoryImpl({
    required IProfileRemoteDataSource remoteDataSource,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _remoteDataSource = remoteDataSource,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, ProfileEntity>> getUserProfile() async {
    try {
      final results = await Future.wait([
        _remoteDataSource.getUserProfile(),
        _remoteDataSource.getLastShippingAddress(),
      ]);

      final profileResponse = results[0] as ProfileApiResponse;
      final lastAddressModel = results[1] as ShippingAddressApiModel?;

      final profileEntity = ProfileEntity(
        user: profileResponse.user.toEntity(),
        orders: profileResponse.orders.map((o) => o.toEntity()).toList(),
        lastShippingAddress: lastAddressModel?.toEntity(),
      );
      return Right(profileEntity);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _tokenSharedPrefs.deleteToken();
      return const Right(unit);
    } catch (e) {
      return Left(SharedPreferencesFailure(message: 'Failed to log out: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserProfile({
    required String firstName,
    required String lastName,
  }) async {
    try {
      final userProfileModel = await _remoteDataSource.updateUserProfile(
        firstName: firstName,
        lastName: lastName,
      );
      return Right(userProfileModel.toEntity());
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.changePassword(
        currentPassword: oldPassword,
        newPassword: newPassword,
      );
      return const Right(unit);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}

