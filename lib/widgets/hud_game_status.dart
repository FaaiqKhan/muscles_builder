import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/cubits/hud_game_status/hud_game_status_cubit.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';
import 'package:muscles_builder/l10n/translations/app_localizations.dart';

class HudGameStatusWidget extends StatelessWidget {
  static const String id = "hud_game_status_widget";

  const HudGameStatusWidget({super.key, required this.onPause});

  final VoidCallback onPause;

  Widget titleWidget(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: context.musclesBuilderTheme.muscleGrowthBar),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: context.musclesBuilderTheme.background),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Spacings.contentSpacingOf24,
        ),
        padding: const EdgeInsets.all(Spacings.contentSpacingOf8),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Theme.of(context).colorScheme.onPrimaryFixed,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          color: Theme.of(context).colorScheme.secondary.withAlpha(125),
        ),
        child: BlocBuilder<HudGameStatusCubit, HudGameStatusState>(
          builder: (context, state) {
            return Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleWidget(
                      context,
                      title: AppLocalizations.of(context).scoreTitle,
                      value: state.score.toString(),
                    ),
                    titleWidget(
                      context,
                      title: AppLocalizations.of(context).timeTitle,
                      value: state.exerciseTime.toStringAsFixed(0),
                    ),
                    titleWidget(
                      context,
                      title: AppLocalizations.of(context).warmupTitle,
                      value: state.warmupTime.toStringAsFixed(0),
                    ),
                  ],
                ),
                Flexible(
                  child: IconButton(
                    onPressed: onPause,
                    icon: Icon(
                      Icons.pause,
                      color: context.musclesBuilderTheme.background,
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (_) => context.musclesBuilderTheme.primaryText,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
