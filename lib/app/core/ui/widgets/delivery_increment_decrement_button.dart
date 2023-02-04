import 'package:flutter/material.dart';

import '../styles/colors_app.dart';
import '../styles/text_styles.dart';

class DeliveryIncrementDecrementButton extends StatelessWidget {
  final bool _compat;
  final int amout;
  final VoidCallback incrementTab;
  final VoidCallback decrementTab;

  const DeliveryIncrementDecrementButton({
    super.key,
    required this.amout,
    required this.incrementTab,
    required this.decrementTab,
  }) : _compat = false;

  const DeliveryIncrementDecrementButton.compat({
    super.key,
    required this.amout,
    required this.incrementTab,
    required this.decrementTab,
  }) : _compat = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _compat ? const EdgeInsets.all(5) : null,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: decrementTab,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '-',
                style: context.textStyles.textMedium
                    .copyWith(fontSize: _compat ? 10 : 22, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              amout.toString(),
              style: context.textStyles.textRegular.copyWith(
                fontSize: _compat ? 13 : 17,
                color: context.colors.second,
              ),
            ),
          ),
          InkWell(
            onTap: incrementTab,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '+',
                style: context.textStyles.textMedium
                    .copyWith(fontSize: _compat ? 10 : 22, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
