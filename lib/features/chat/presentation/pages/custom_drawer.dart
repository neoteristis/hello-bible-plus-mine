import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/widgets/logo_widget.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/categories_widget.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          children: [
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(color: ColorConstants.background),
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      dividerTheme:
                          const DividerThemeData(color: Colors.transparent),
                    ),
                    child: DrawerHeader(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/bible.webp',
                              ),
                              fit: BoxFit.cover)),
                      child: Stack(
                        children: [
                          const Center(
                            child: LogoWidget(size: 40),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close_rounded,
                                color: ColorConstants.secondary,
                                size: 25,
                              ),
                              onPressed: () {
                                context
                                    .read<ChatBloc>()
                                    .scaffoldKey
                                    .currentState
                                    ?.closeDrawer();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const CategoriesWidget(),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5),
                  //       color: Colors.white,
                  //       // boxShadow: [
                  //       //   BoxShadow(
                  //       //     color: const Color(0xFF202040).withOpacity(0.08),
                  //       //     offset: const Offset(0, 8),
                  //       //     blurRadius: 16,
                  //       //     spreadRadius: 0,
                  //       //   ),
                  //       // ],
                  //     ),
                  //     child: TextButton.icon(
                  //       onPressed: () {
                  //         Navigator.of(context).push(
                  //           MaterialPageRoute(
                  //             builder: (context) => const DonationPage(),
                  //           ),
                  //         );
                  //       },
                  //       icon: Icon(
                  //         Icons.favorite_border_rounded,
                  //         color: Theme.of(context).primaryColor,
                  //       ),
                  //       label: Text(
                  //         'Faire un don',
                  //         style: TextStyle(
                  //             color: Theme.of(context).primaryColor,
                  //             fontSize: 15),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
