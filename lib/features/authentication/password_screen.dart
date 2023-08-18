import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/regexps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String _password = '';
  bool isPasswordLengthValid = false;
  bool isPasswordRegExpValid = false;
  bool isObsecurePassword = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    if (_password.isEmpty || !_isPasswordValid()) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _onObsecurePasswordTap() {
    isObsecurePassword = !isObsecurePassword;
    setState(() {});
  }

  void _onPasswordLengthValid(bool isValid) {
    isPasswordLengthValid = isValid;
    setState(() {});
  }

  void _onPasswordRegExpValid(bool isValid) {
    isPasswordRegExpValid = isValid;
    setState(() {});
  }

  /// validatePassword Rules
  /// 1. TextField가 비어 있을땐, validate X
  /// 2. 8글자보다 많아야한다.
  /// 3. 알파벳과 숫자를 포함해야 한다.
  /// 4. 적어도 1개 이상의 특수문자를 포함해야 한다.
  bool _isPasswordValid() {
    if (_password.isEmpty || _password.length < 8) {
      _onPasswordLengthValid(false);
      return false;
    }
    _onPasswordLengthValid(true);
    if (!passwordRegExp.hasMatch((_password))) {
      _onPasswordRegExpValid(false);
      return false;
    }
    _onPasswordRegExpValid(true);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '가입하기',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                '비밀번호',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v48,
              TextField(
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: isObsecurePassword,
                autocorrect: false,
                onEditingComplete: _onNextTap,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  hintText: '강력한 비밀번호를 적어주세요.',
                  // errorText: isPasswordValid(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h12,
                      GestureDetector(
                        onTap: _onObsecurePasswordTap,
                        child: FaIcon(
                          isObsecurePassword
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gaps.v10,
              const Text(
                '비밀번호는 이 규칙들을 지켜야 합니다.',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: isPasswordLengthValid
                        ? Colors.green
                        : Colors.grey.shade500,
                  ),
                  Gaps.h5,
                  const Text('8글자 이상입니다.'),
                ],
              ),
              Gaps.v4,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: isPasswordRegExpValid
                        ? Colors.green
                        : Colors.grey.shade500,
                  ),
                  Gaps.h5,
                  const Text('영문자와 숫자, 특수문자 1개 이상이 포함됩니다.'),
                ],
              ),
              Gaps.v32,
              FormButton(
                onTap: _onNextTap,
                isDisabled: !_isPasswordValid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
