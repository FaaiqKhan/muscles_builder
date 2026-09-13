import 'dart:ui';

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

  // The HUD always floats over the gameplay canvas's fixed dark arcade
  // background, so it keeps one glass-card look regardless of the app's
  // light/dark theme setting.
  Widget titleWidget(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    const style = TextStyle(
      fontFamily: "JetBrains Mono",
      fontSize: 13,
      fontWeight: FontWeight.w700,
      height: 1.4,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: style.copyWith(color: context.musclesBuilderTheme.accentText),
        ),
        Text(
          value,
          style: style.copyWith(color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Spacings.contentSpacingOf16,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: Colors.white.withValues(alpha: 0.25),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacings.contentSpacingOf12,
              vertical: Spacings.contentSpacingOf10,
            ),
            color: const Color(0xFF0F110D).withValues(alpha: 0.55),
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
                        icon: const Icon(
                          Icons.pause,
                          color: Colors.black87,
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.resolveWith<Color>(
                            (_) => Colors.white.withValues(alpha: 0.92),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
