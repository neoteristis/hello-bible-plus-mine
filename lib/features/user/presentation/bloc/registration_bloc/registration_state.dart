part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    this.registrationInputs = const RegistrationInputs(),
    this.registrationBtnController,
    this.status = Status.init,
    this.checkEmailBtnController,
    this.confirmPassordError,
    this.updateStatus = Status.init,
    this.updateUserBtnController,
    this.image,
    this.email = const EmailInput.pure(),
    this.password = const RequiredInput.pure(),
    this.confirmPassword = const RequiredInput.pure(),
    this.name = const RequiredInput.pure(),
    this.failure,
    this.emailCheckStatus = Status.init,
    this.pickPictureStatus = Status.init,
  });

  final RegistrationInputs registrationInputs;
  final RoundedLoadingButtonController? registrationBtnController;
  final Status? status;
  final RoundedLoadingButtonController? checkEmailBtnController;
  final RoundedLoadingButtonController? updateUserBtnController;
  final String? confirmPassordError;
  final Status? updateStatus;
  final XFile? image;
  final EmailInput email;
  final RequiredInput password;
  final RequiredInput confirmPassword;
  final RequiredInput name;
  final Failure? failure;
  final Status? emailCheckStatus;
  final Status? pickPictureStatus;

  @override
  List<Object?> get props => [
        registrationInputs,
        registrationBtnController,
        status,
        checkEmailBtnController,
        confirmPassordError,
        updateStatus,
        updateUserBtnController,
        image,
        email,
        password,
        confirmPassword,
        name,
        failure,
        emailCheckStatus,
        pickPictureStatus,
      ];

  RegistrationState copyWith({
    RegistrationInputs? registrationInputs,
    RoundedLoadingButtonController? registrationBtnController,
    Status? status,
    RoundedLoadingButtonController? checkEmailBtnController,
    bool clearConfirmPasswordError = false,
    String? confirmPassordError,
    Status? updateStatus,
    RoundedLoadingButtonController? updateUserBtnController,
    XFile? image,
    EmailInput? email,
    RequiredInput? password,
    RequiredInput? confirmPassword,
    RequiredInput? name,
    Failure? failure,
    Status? emailCheckStatus,
    Status? pickPictureStatus,
  }) {
    return RegistrationState(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      registrationInputs: registrationInputs ?? this.registrationInputs,
      registrationBtnController:
          registrationBtnController ?? this.registrationBtnController,
      status: status ?? this.status,
      checkEmailBtnController:
          checkEmailBtnController ?? this.checkEmailBtnController,
      confirmPassordError: clearConfirmPasswordError
          ? null
          : confirmPassordError ?? this.confirmPassordError,
      updateStatus: updateStatus ?? this.updateStatus,
      updateUserBtnController:
          updateUserBtnController ?? this.updateUserBtnController,
      image: image ?? this.image,
      failure: failure ?? this.failure,
      emailCheckStatus: emailCheckStatus ?? this.emailCheckStatus,
      pickPictureStatus: pickPictureStatus ?? this.pickPictureStatus,
    );
  }
}

class RegistrationInputs with FormzMixin {
  const RegistrationInputs({
    this.name = const RequiredInput.pure(),
    this.firstname = const RequiredInput.pure(),
    this.email = const EmailInput.pure(),
    this.country = const RequiredInput.pure(),
    this.code = const UnrequiredInput.pure(),
    this.password = const RequiredInput.pure(),
    this.confirmPassword = const RequiredInput.pure(),
  });

  final RequiredInput name;
  final RequiredInput firstname;
  final RequiredInput password;
  final RequiredInput confirmPassword;
  final EmailInput email;
  final RequiredInput country;
  final UnrequiredInput code;

  @override
  List<FormzInput> get inputs => [
        name,
        firstname,
        email,
        country,
        code,
        password,
        confirmPassword,
      ];

  RegistrationInputs copyWith({
    RequiredInput? name,
    RequiredInput? firstname,
    RequiredInput? password,
    RequiredInput? confirmPassword,
    EmailInput? email,
    RequiredInput? country,
    UnrequiredInput? code,
  }) {
    return RegistrationInputs(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      email: email ?? this.email,
      country: country ?? this.country,
      code: code ?? this.code,
    );
  }
}
