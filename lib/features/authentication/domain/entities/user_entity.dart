import 'package:equatable/equatable.dart';

/// User Entity for domain layer
/// Represents core user data without implementation details
class UserEntity extends Equatable {
  final String userId;
  final String username;
  final String fullName;
  final String? buckleNo;
  final String mobile;
  final String? email;
  final String? designation;
  final String? policeStation;
  final String? district;
  final String? state;
  final String? profileImage;
  final bool isVerified;
  final String? subscriptionStatus;
  final String? subscriptionExpiry;

  const UserEntity({
    required this.userId,
    required this.username,
    required this.fullName,
    this.buckleNo,
    required this.mobile,
    this.email,
    this.designation,
    this.policeStation,
    this.district,
    this.state,
    this.profileImage,
    this.isVerified = false,
    this.subscriptionStatus,
    this.subscriptionExpiry,
  });

  @override
  List<Object?> get props => [
        userId,
        username,
        fullName,
        buckleNo,
        mobile,
        email,
        designation,
        policeStation,
        district,
        state,
        profileImage,
        isVerified,
        subscriptionStatus,
        subscriptionExpiry,
      ];

  /// Check if user has active subscription
  bool get hasActiveSubscription {
    if (subscriptionStatus == null) return false;
    return subscriptionStatus?.toLowerCase() == 'active';
  }

  /// Get full location string
  String get fullLocation {
    final parts = <String>[];
    if (policeStation != null) parts.add(policeStation!);
    if (district != null) parts.add(district!);
    if (state != null) parts.add(state!);
    return parts.join(', ');
  }
}
