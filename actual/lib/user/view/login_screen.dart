import 'dart:convert';
import 'dart:io';

import 'package:actual/common/component/custom_text_form_field.dart';
import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    // localhost
    final emulatorIp = '10.0.2.2:3000';
    final simulatorIp = '127.0.0.1:3000';

    final ip = Platform.isIOS ? simulatorIp : emulatorIp;

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(height: 16.0),
                _Subtitle(),
                Image.asset(
                  "asset/img/misc/logo.png",
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                  hintText: "이메일을 입력해주세요",
                  onChanged: (String value) {},
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 5.0,
                ),
                CustomTextFormField(
                  hintText: "비밀번호를 입력해주세요",
                  obscureText: true,
                  onChanged: (String value) {},
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                    onPressed: () async {
                      // ID : 비밀번호
                      final rawString = 'test@codefactoty.ai:testtest';

                      // Base64 로 인코딩하기
                      Codec<String, String> stringToBase64 = utf8.fuse(base64);

                      String token = stringToBase64.encode(rawString);

                      final resp = await dio.post('http://$ip/auth/login',
                        options: Options(
                          headers: {
                            'Authorization': 'Basic $token',
                          },
                        ),
                      );
                      print(resp.data);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                    ),
                    child: Text("로그인")),
                TextButton(
                  onPressed: () async {
                    final refreshToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTY3NTI2MTQwNiwiZXhwIjoxNjc1MzQ3ODA2fQ.UqJH9dG_DtpnvAwLLSkHr83yV4RRX8VMn_mXQ3Gvdys';
                    final resp = await dio.post('http://$ip/auth/token',
                      options: Options(
                        headers: {
                          'Authorization': 'Bearer $refreshToken',
                        },
                      ),
                    );
                    print(resp.data);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text("회원가입"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "환영합니다.",
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길!",
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
