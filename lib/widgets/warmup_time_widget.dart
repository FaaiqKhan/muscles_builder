import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/enums.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';

/// Preview of the upcoming warmup-time setting. Disabled: not wired to
/// [GameSettingsRepository] yet, purely a "coming soon" placeholder.
class WarmupTimeWidget extends StatelessWidget {
  const WarmupTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.musclesBuilderTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context).warmupTime,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: theme.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: Spacings.contentSpacingOf8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacings.contentSpacingOf8,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: theme.surface2,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                AppLocalizations.of(context).soon,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: theme.mutedText,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      letterSpacing: 0.4,
                    ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: Spacings.contentSpacingOf8),
          child: Wrap(
            spacing: Spacings.contentSpacingOf8,
            runSpacing: Spacings.contentSpacingOf8,
            children: WarmupTime.values
                .map(
                  (option) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacings.contentSpacingOf16,
                      vertical: Spacings.contentSpacingOf10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.borderStrong,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      option.value,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: theme.mutedText,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
