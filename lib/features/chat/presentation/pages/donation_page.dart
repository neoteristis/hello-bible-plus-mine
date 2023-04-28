import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/chat/presentation/bloc/donation_bloc/donation_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  late WebViewController? controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            print('------------Started');
            // context.read<DonationBloc>().add(DonationPageProgressed());
          },
          onProgress: (int progress) {
            // Update loading bar.
            context
                .read<DonationBloc>()
                .add(DonationPageProgressed(value: progress));
          },
          onPageFinished: (String url) {
            print('------------finished');
            context.read<DonationBloc>().add(DonationPageLoaded());
          },
          onWebResourceError: (WebResourceError error) {
            print('------------error : $error');
            context.read<DonationBloc>().add(DonationPageFailed());
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://donorbox.org/embed/donner-pour-hellobible',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<DonationBloc, DonationState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.loading:
                return Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: LinearProgressIndicator(
                      // color: Colors.white,
                      color: Theme.of(context).primaryColor,
                      // backgroundColor: Colors.white,
                      // value: state.progressValue?.toDouble(),
                    ),
                  ),
                );
              case Status.loaded:
                return Stack(
                  children: [
                    WebViewWidget(
                      controller: controller!,
                    ),
                    Positioned(
                      top: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              case Status.failed:
                return const Center(
                  child: Text('Une erreur s\'est produite'),
                );
              default:
                return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
