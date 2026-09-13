import 'package:flutter/material.dart';
import 'package:muscles_builder/constants/spacings.dart';
import 'package:muscles_builder/extensions/muscles_builder_theme_context.dart';

/// A settings row: a label followed by a wrap of pill-shaped, single-select
/// options. The selected option renders as a solid [MusclesBuilderTheme.primaryAction]
/// pill; the rest render as outlined pills.
class SettingsOptionPillRow<T> extends StatelessWidget {
  const SettingsOptionPillRow({
    super.key,
    required this.label,
    required this.options,
    required this.selected,
    required this.labelBuilder,
    required this.onSelect,
  });

  final String label;
  final List<T> options;
  final T selected;
  final String Function(T option) labelBuilder;
  final ValueChanged<T> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: context.musclesBuilderTheme.primaryText,
                fontWeight: FontWeight.w600,
              ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: Spacings.contentSpacingOf8),
          child: Wrap(
            spacing: Spacings.contentSpacingOf8,
            runSpacing: Spacings.contentSpacingOf8,
            children: options
                .map(
                  (option) => _OptionPill(
                    label: labelBuilder(option),
                    selected: option == selected,
                    onTap: () => onSelect(option),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _OptionPill extends StatelessWidget {
  const _OptionPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.musclesBuilderTheme;
    return Material(
      color: selected ? theme.primaryAction : Colors.transparent,
      shape: StadiumBorder(
        side: selected ? BorderSide.none : BorderSide(color: theme.border),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacings.contentSpacingOf16,
            vertical: Spacings.contentSpacingOf10,
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: selected ? Colors.white : theme.tertiaryText,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
