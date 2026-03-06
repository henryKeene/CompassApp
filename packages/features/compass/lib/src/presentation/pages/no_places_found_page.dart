import 'package:compass/src/presentation/flow/compass_flow_state.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

class NoPlacesFoundPage extends StatelessWidget {
  const NoPlacesFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
        title: const Text('Oh no!'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Oh No!! We haven't managed to find a place of this type in your area. Please select a different type and try again!"),
            ElevatedButton(onPressed: () {
              context.flow<CompassFlowState>().update((_) => SelectingCategory());
            }, child: Text('Try again'))
          ],
        ),
      ),
    );
  }
}