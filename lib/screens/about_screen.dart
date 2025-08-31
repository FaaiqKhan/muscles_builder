import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.musclesBuilderTheme.background,
        title: Text(
          "About",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: context.musclesBuilderTheme.primaryText),
        ),
        iconTheme: IconThemeData(
          color: context.musclesBuilderTheme.primaryText,
        ),
      ),
      backgroundColor: context.musclesBuilderTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacings.contentSpacingOf12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${context.read<SettingsCubit>().appVersion}-${context.read<SettingsCubit>().appBuildNumber}",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: context.musclesBuilderTheme.primaryText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
