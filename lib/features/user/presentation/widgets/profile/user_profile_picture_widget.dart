import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/l10n/function.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/widgets/icon_text_row_recognizer.dart';
import '../../bloc/profile_bloc/profile_bloc.dart';

class UserProfilePictureWidget extends StatelessWidget {
  const UserProfilePictureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
          context: context,
          builder: (ctx) => SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconTextRowRecognizer(
                  label: dict(context).camera,
                  icon: Icon(
                    Icons.camera,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () {
                    context.read<ProfileBloc>().add(
                          const ProfilePicturePicked(
                            source: ImageSource.camera,
                          ),
                        );
                    context.pop();
                  },
                ),
                IconTextRowRecognizer(
                  label: dict(context).files,
                  icon: Icon(
                    Icons.folder,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () {
                    context.read<ProfileBloc>().add(
                          const ProfilePicturePicked(
                            source: ImageSource.gallery,
                          ),
                        );
                    context.pop();
                  },
                )
              ],
            ),
          ),
        ),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) =>
              previous.updatePictureStatus != current.updatePictureStatus,
          builder: (context, state) {
            switch (state.updatePictureStatus) {
              case Status.loading:
                return CircleAvatar(
                  radius: 70,
                  child: Text(dict(context).loading),
                );
              default:
                return Stack(
                  children: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                      buildWhen: (previous, current) =>
                          previous.user != current.user,
                      builder: (context, state) {
                        final user = state.user;
                        return CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            user?.photo != null
                                ? '${dotenv.env['BASE_URL']!}/${user?.photo}'
                                : 'https://ui-avatars.com/api/?name=${user?.lastName ?? 'A+N'}',
                          ),
                        );
                      },
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        // radius: 20,
                        backgroundColor: Color(0xFF007AFF),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          // size: 1,
                        ),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
