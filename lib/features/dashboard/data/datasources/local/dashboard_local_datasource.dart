import 'dart:convert';

import 'package:manifesto/common/core/utils/errors/exceptions.dart';
import 'package:manifesto/common/core/utils/logger/app_logger.dart';
import 'package:manifesto/common/resources/storage_resources/local_client.dart';
import 'package:manifesto/common/resources/storage_resources/local_keys.dart';
import 'package:manifesto/features/dashboard/data/models/family_model.dart';
import 'package:manifesto/features/dashboard/data/models/user_model.dart';

abstract class DashboardLocalDataSource {
  Future<void> setAccessToken(String accessToken);
  Future<void> setUserId(String userId);
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> cacheFamily(FamilyModel family);
  Future<FamilyModel?> getCachedFamily();
  Future<void> clearAll();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  @override
  Future<void> setAccessToken(String accessToken) async {
    try {
      await LocalClient.saveString(
        key: LocalKeys.accessToken,
        value: accessToken,
      );
      Log.info("Access token saved successfully");
    } catch (e, stackTrace) {
      Log.error("Error saving access token", e, stackTrace);
      throw const StorageException(message: "Failed to save access token");
    }
  }

  @override
  Future<void> setUserId(String userId) async {
    try {
      await LocalClient.saveString(
        key: LocalKeys.userId,
        value: userId,
      );
      Log.info("User ID saved successfully");
    } catch (e, stackTrace) {
      Log.error("Error saving user ID", e, stackTrace);
      throw const StorageException(message: "Failed to save user ID");
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await LocalClient.saveString(
        key: LocalKeys.cachedUser,
        value: jsonEncode(user.toJson()),
      );
    } catch (e, stackTrace) {
      Log.error("Error caching user", e, stackTrace);
      throw const StorageException(message: "Failed to cache user");
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final raw = await LocalClient.getString(key: LocalKeys.cachedUser);
      if (raw.isEmpty) return null;
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      return UserModel.fromJson(Map<String, dynamic>.from(decoded));
    } catch (e, stackTrace) {
      Log.error("Error reading cached user", e, stackTrace);
      return null;
    }
  }

  @override
  Future<void> cacheFamily(FamilyModel family) async {
    try {
      await LocalClient.saveString(
        key: LocalKeys.cachedFamily,
        value: jsonEncode(family.toJson()),
      );
    } catch (e, stackTrace) {
      Log.error("Error caching family", e, stackTrace);
      throw const StorageException(message: "Failed to cache family");
    }
  }

  @override
  Future<FamilyModel?> getCachedFamily() async {
    try {
      final raw = await LocalClient.getString(key: LocalKeys.cachedFamily);
      if (raw.isEmpty) return null;
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      return FamilyModel.fromJson(Map<String, dynamic>.from(decoded));
    } catch (e, stackTrace) {
      Log.error("Error reading cached family", e, stackTrace);
      return null;
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await LocalClient.clearAll();
      Log.info("Local data cleared successfully");
    } catch (e, stackTrace) {
      Log.error("Error clearing local data", e, stackTrace);
      throw const StorageException(message: "Failed to clear local data");
    }
  }
}
