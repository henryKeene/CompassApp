import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';

import '../app_router.gr.dart';

@RoutePage()
class HomeRoutePage extends StatelessWidget {
  const HomeRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage(
      onStartAdventure: () {
        context.router.push(const CompassFlowRoute());
      },
    );
  }
}
