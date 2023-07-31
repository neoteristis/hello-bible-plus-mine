import 'package:flutter/material.dart';
import 'package:gpt/core/widgets/custom_drawer.dart';
import 'package:gpt/features/container/pages/home/presentation/widgets/custom_home_app_bar.dart';

class SectionPage extends StatefulWidget {
  static const String route = 'section';

  const SectionPage({super.key});

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHomeAppBar(),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Text(
                      'Verset du jour',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      '"L\'Éternel combattra pour toi, et toi, garde le silence." - Exode 14:14. Je suis tellement encouragé par ce verset de la Bible, Toky. Il nous rappelle que lorsque nous sommes confrontés à des situations difficiles, Dieu est à nos côtés…',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Text(
                      'Verset du jour',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      '"L\'Éternel combattra pour toi, et toi, garde le silence." - Exode 14:14. Je suis tellement encouragé par ce verset de la Bible, Toky. Il nous rappelle que lorsque nous sommes confrontés à des situations difficiles, Dieu est à nos côtés…',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Text(
                      'Verset du jour',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      '"L\'Éternel combattra pour toi, et toi, garde le silence." - Exode 14:14. Je suis tellement encouragé par ce verset de la Bible, Toky. Il nous rappelle que lorsque nous sommes confrontés à des situations difficiles, Dieu est à nos côtés…',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
