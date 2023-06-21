part of 'social_connect_bloc.dart';

abstract class SocialConnectEvent extends Equatable {
  const SocialConnectEvent();

  @override
  List<Object> get props => [];
}

class SocialConnectAppleSubmitted extends SocialConnectEvent {}

class SocialConnectGoogleSubmitted extends SocialConnectEvent {}

class SocialConnectFacebookSubmitted extends SocialConnectEvent {}
