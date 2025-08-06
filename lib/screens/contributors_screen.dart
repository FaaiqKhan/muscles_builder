import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:url_launcher/url_launcher.dart';

class ContributorsScreen extends StatelessWidget {
  const ContributorsScreen({super.key});

  Widget contributorContent(
    BuildContext context, {
    required String item,
    required String link,
  }) {
    return Padding(
      padding: const EdgeInsets.all(
        Spacings.contentSpacingOf16,
      ),
      child: Column(
        children: [
          Text(
            item,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: context.musclesBuilderTheme.primaryText),
          ),
          GestureDetector(
            onTap: () {
              launchUrl(
                Uri.parse(link),
              );
            },
            child: Text(
              link,
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: context.musclesBuilderTheme.primaryText,
                decorationColor: Theme.of(context).colorScheme.onPrimaryFixed,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.musclesBuilderTheme.background,
        title: Text(
          "Contributors",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: context.musclesBuilderTheme.primaryText),
        ),
        iconTheme:
            IconThemeData(color: context.musclesBuilderTheme.primaryText),
      ),
      backgroundColor: context.musclesBuilderTheme.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: Text(
                "Icons",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: context.musclesBuilderTheme.primaryText),
              ),
            ),
            contributorContent(
              context,
              item: "Gallery icons created by Anggara - Flaticon",
              link: "https://www.flaticon.com/authors/anggara",
            ),
          ],
        ),
      ),
    );
  }
}
