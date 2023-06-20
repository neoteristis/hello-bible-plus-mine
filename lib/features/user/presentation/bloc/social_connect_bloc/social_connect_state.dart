part of 'social_connect_bloc.dart';

class SocialConnectState extends Equatable {
  const SocialConnectState({
    this.appleBtnController,
    this.fbBtnController,
    this.googleBtnController,
    this.failure,
    this.status = Status.init,
  });

  final RoundedLoadingButtonController? appleBtnController;
  final RoundedLoadingButtonController? fbBtnController;
  final RoundedLoadingButtonController? googleBtnController;
  final Failure? failure;
  final Status? status;

  @override
  List<Object?> get props => [
        appleBtnController,
        fbBtnController,
        googleBtnController,
        failure,
        status,
      ];

  SocialConnectState copyWith({
    RoundedLoadingButtonController? appleBtnController,
    RoundedLoadingButtonController? fbBtnController,
    RoundedLoadingButtonController? googleBtnController,
    Failure? failure,
    Status? status,
  }) {
    return SocialConnectState(
      appleBtnController: appleBtnController ?? this.appleBtnController,
      fbBtnController: fbBtnController ?? this.fbBtnController,
      googleBtnController: googleBtnController ?? this.googleBtnController,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
