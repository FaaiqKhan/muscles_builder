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
      decoration: TextDecoration.none,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: style.copyWith(color: context.musclesBuilderTheme.accentText),
        ),
        Text(value, style: style.copyWith(color: Colors.white)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(
          Spacings.contentSpacingOf16,
          Spacings.contentSpacingOf8,
          Spacings.contentSpacingOf16,
          0,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: Colors.white.withValues(alpha: 0.25),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: Spacings.contentSpacingOf12,
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
                        const SizedBox(height: 2),
                        titleWidget(
                          context,
                          title: AppLocalizations.of(context).timeTitle,
                          value: state.exerciseTime.toStringAsFixed(0),
                        ),
                        const SizedBox(height: 2),
                        titleWidget(
                          context,
                          title: AppLocalizations.of(context).warmupTitle,
                          value: state.warmupTime.toStringAsFixed(0),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: onPause,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(
                        width: 42,
                        height: 42,
                      ),
                      icon: const _PauseGlyph(),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.white.withValues(alpha: 0.92),
                        ),
                        shape: WidgetStateProperty.all(const CircleBorder()),
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

/// Two rounded bars, matching the pause glyph in the design.
class _PauseGlyph extends StatelessWidget {
  const _PauseGlyph();

  @override
  Widget build(BuildContext context) {
    Widget bar() => Container(
      width: 2.7,
      height: 9.3,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(1),
      ),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [bar(), const SizedBox(width: 2.7), bar()],
    );
  }
}
