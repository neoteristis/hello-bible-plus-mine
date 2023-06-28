part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.user,
    this.status = Status.init,
    this.nameController,
    this.emailController,
    this.phoneController,
    this.updateStatus,
    this.buttonController,
    this.failure,
    this.image,
    this.updatePictureStatus = Status.init,
    required this.inputs,
  });

  final User? user;
  final Status? status;
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;
  final Status? updateStatus;
  final RoundedLoadingButtonController? buttonController;
  final Failure? failure;
  final XFile? image;
  final Status? updatePictureStatus;
  final ProfileInputs inputs;

  @override
  List<Object?> get props => [
        user,
        status,
        nameController,
        emailController,
        phoneController,
        updateStatus,
        buttonController,
        failure,
        image,
        updatePictureStatus,
        inputs,
      ];

  ProfileState copyWith({
    User? user,
    Status? status,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
    Status? updateStatus,
    RoundedLoadingButtonController? buttonController,
    Failure? failure,
    XFile? image,
    Status? updatePictureStatus,
    ProfileInputs? inputs,
  }) {
    return ProfileState(
      user: user ?? this.user,
      status: status ?? this.status,
      nameController: nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      updateStatus: updateStatus ?? this.updateStatus,
      buttonController: buttonController ?? this.buttonController,
      failure: failure ?? this.failure,
      image: image ?? this.image,
      updatePictureStatus: updatePictureStatus ?? this.updatePictureStatus,
      inputs: inputs ?? this.inputs,
    );
  }
}

class ProfileInputs with FormzMixin {
  const ProfileInputs({
    this.name = const RequiredInput.pure(),
    this.email = const EmailInput.pure(),
    this.phone = const NumberInput.pure(),
  });

  final RequiredInput name;
  final EmailInput email;
  final NumberInput phone;

  @override
  List<FormzInput> get inputs => [
        name,
        email,
        phone,
      ];

  ProfileInputs copyWith({
    RequiredInput? name,
    EmailInput? email,
    NumberInput? phone,
  }) {
    return ProfileInputs(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}
