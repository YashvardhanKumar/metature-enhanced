import 'package:flutter/material.dart';
import 'package:metature2/components/button/Custombutton.dart';
import 'package:metature2/components/colored_text.dart';
import 'package:metature2/components/custom_page_route.dart';
import 'package:metature2/pages/login_page.dart';
import 'package:metature2/pages/register_page.dart';
import '../constants.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryThemeColor1, //TODO: impl dark mode
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Hero(
                tag: 'color box',
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        kPrimaryThemeColor1,
                        kPrimaryThemeColor2,
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Hero(
                      tag: "logo",
                      child: Image.asset(
                        "images/Logo.png",
                      ),
                    ),
                  ),
                  Flexible(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("images/Design.png"),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(
                              addBoxShadow: false,
                              colorString: kSecondaryThemeColor1.value,
                              child: const NormalText(
                                'Login',
                                color: kSecondaryThemeColor4,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CustomPageRoute(
                                    child: const LoginPage(),
                                  ),
                                );
                              },
                            ),
                            CustomButton(
                              addBoxShadow: false,
                              child: const NormalText(
                                'Sign Up',
                                color: kSecondaryThemeColor4,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CustomPageRoute(
                                    child: const RegisterPage(), //TODO: Change back to RegisterPage()
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
