import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required bool isDisabled,
    required void Function() onTap,
    String title = '다음',
  })  : _isDisabled = isDisabled,
        _onTap = onTap,
        _title = title;

  final bool _isDisabled;
  final Function() _onTap;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size3),
            color: _isDisabled
                ? Colors.grey.shade400
                : Theme.of(context).primaryColor,
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              color: _isDisabled ? Colors.grey.shade500 : Colors.white,
              fontSize: Sizes.size16,
              fontWeight: FontWeight.bold,
            ),
            child: Text(
              _title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
