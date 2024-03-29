import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final FaIcon _icon;
  final String _text;
  final void Function(BuildContext) _onTap;

  const AuthButton(
      {super.key,
      required FaIcon icon,
      required String text,
      required void Function(BuildContext) onTap})
      : _icon = icon,
        _text = text,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: GestureDetector(
        onTap: () => _onTap(context),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: Sizes.size1,
              color: Colors.grey.shade300,
            ),
          ),
          padding: const EdgeInsets.all(
            Sizes.size14,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: Sizes.size8,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: _icon,
              ),
              Positioned.fill(
                child: Column(
                  children: [
                    Text(
                      _text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
