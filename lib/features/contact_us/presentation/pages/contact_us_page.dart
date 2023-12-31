import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/custom_text_field.dart';
import 'package:gpt/features/contact_us/presentation/bloc/contact_us_bloc.dart';
import 'package:gpt/features/container/pages/section/presentation/pages/section_page.dart';

import '../../../../core/helper/unfocus_keyboard.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../../../../l10n/function.dart';

class ContactUsPage extends StatefulWidget {
  static const String route = 'contact';

  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final FocusNode _messageFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      addBackgroundImage: false,
      persistentFooterButtons: [
        CustomButtonWidget(ButtonType.black).build(
          context: context,
          onPressed: () {},
          label: dict(context).send,
        ),
      ],
      onPop: () {
        context.pop();
      },
      title: dict(context).contactUs,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30.0,
          left: 30,
          right: 30,
        ),
        child: ListView(
          children: [
            CustomTextField(
              label: dict(context).object,
              decoration: InputDecoration(
                hintText: dict(context).enterYourSubject,
                filled: true,
                fillColor: const Color(0xFFF3F5F7),
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
              child: CustomTextField(
                label: dict(context).attachments,
                decoration: InputDecoration(
                  hintText: dict(context).addFiles,
                  filled: true,
                  fillColor: const Color(0xFFF3F5F7),
                  prefixIcon: const Icon(
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
              label: dict(context).message,
              decoration: InputDecoration(
                hintText: dict(context).enterYourMessage,
                filled: true,
                fillColor: const Color(0xFFF3F5F7),
              ),
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}
