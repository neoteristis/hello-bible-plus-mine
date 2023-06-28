import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/custom_text_field.dart';
import 'package:gpt/features/contact_us/presentation/bloc/contact_us_bloc.dart';

import '../../../../core/helper/unfocus_keyboard.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/scaffold_with_background.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode _messageFocusNode = FocusNode();
    return ScaffoldWithBackground(
      addBackgroundImage: false,
      persistentFooterButtons: [
        CustomButtonWidget(ButtonType.black).build(
          context: context,
          onPressed: () {},
          label: 'Envoyer',
        ),
      ],
      onPop: () {
        context.pop();
      },
      title: 'Nous-contacter',
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30.0,
          left: 30,
          right: 30,
        ),
        child: ListView(
          children: [
            CustomTextField(
              label: 'Objet',
              decoration: const InputDecoration(
                hintText: 'Saisissez votre objet',
              ),
              onFieldSubmitted: (_) {
                unfocusKeyboard();
                FocusScope.of(context).requestFocus(_messageFocusNode);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                context.read<ContactUsBloc>().add(ContactUsFilePicked());
              },
              child: const CustomTextField(
                label: 'Pièces jointes',
                decoration: InputDecoration(
                  hintText: 'Ajoutez des fichiers',
                  prefixIcon: Icon(
                    Icons.attach_file,
                  ),
                ),
                autofocus: false,
                enabled: false,
              ),
            ),
            BlocBuilder<ContactUsBloc, ContactUsState>(
              buildWhen: (previous, current) => previous.files != current.files,
              builder: (context, state) {
                final files = state.files;
                if (files == null || files.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...state.files!
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                            ),
                            child: Row(
                              children: [
                                Text(e.name),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.read<ContactUsBloc>().add(
                                          ContactUsFileRemoved(e),
                                        );
                                  },
                                  child: const Icon(
                                    Icons.cancel,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList()
                  ],
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              onFieldSubmitted: (_) {
                unfocusKeyboard();
              },
              focusNode: _messageFocusNode,
              label: 'Message',
              decoration: const InputDecoration(
                hintText: 'Saisissez votre message',
              ),
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}
