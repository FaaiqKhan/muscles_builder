import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';

class JoinUs extends StatelessWidget {
  const JoinUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Join Us",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacings.contentSpacingOf12),
          child: Column(
            children: [
              Text("OK")
            ],
          ),
        ),
      ),
    );
  }
}