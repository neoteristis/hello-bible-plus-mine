import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/widgets/custom_text_field.dart';
import 'input_base_page.dart';

class EmailInputPage extends StatelessWidget {
  const EmailInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InputBasePage(
      field: const CustomTextField(
        label: 'Renseigner mon email',
        decoration: InputDecoration(
          hintText: 'exemple@mondomaine.fr',
        ),
      ),
      onContinue: () {
        context.go(RouteName.password);
      },
    );
  }
}
