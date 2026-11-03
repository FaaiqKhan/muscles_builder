import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/settings/settings_cubit.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.musclesBuilderTheme.background,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.chevron_left,
            color: context.musclesBuilderTheme.primaryText,
          ),
        ),
        title: Text(
          AppLocalizations.of(context).about,
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(color: context.musclesBuilderTheme.primaryText),
        ),
        iconTheme: IconThemeData(
          color: context.musclesBuilderTheme.primaryText,
        ),
      ),
      backgroundColor: context.musclesBuilderTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacings.contentSpacingOf24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                margin: const EdgeInsets.only(
                  bottom: Spacings.contentSpacingOf16,
                ),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1F181A20),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.asset('assets/icons/app_icon.png'),
              ),
              Text(
                AppLocalizations.of(context)
                    .appVersion(context.read<SettingsCubit>().appVersion),
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: context.musclesBuilderTheme.primaryText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
