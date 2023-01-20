import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Screens/Login/login_screen.dart';
import 'package:sos_app/Presentation/Screens/SignUp/signup_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import '../../Constants/app_assets.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class CanvasPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(rect);
    canvas.save();
    canvas.translate(100.0, 50.0);
    canvas.drawCircle(
        const Offset(20, -20), 100.0, Paint()..color = primaryColor);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CanvasPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, 200.0);
    canvas.clipRect(rect);
    canvas.save();
    canvas.translate(50.0, 100.0);
    canvas.drawCircle(const Offset(-10, 20), 100.0, Paint()..color = bubbles);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightwhite,
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.topRight,
                child: SizedBox(
                    width: size.width / 1.7,
                    height: size.height / 5,
                    child: CustomPaint(
                      painter: CanvasPainter(),
                      child: Container(),
                    ))),
            Container(
                padding: const EdgeInsets.all(0.0),
                margin: const EdgeInsets.fromLTRB(50.0, 40.0, 50.0, 30.0),
                child: Image.asset(
                  sosLogoImage,
                  width: size.width / 2,
                  height: size.height / 4,
                )),
            const Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: ' SAVE OUR ',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 30.0,
                          color: bubbles)),
                  TextSpan(
                      text: 'SKIN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: primaryColor)),
                ],
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            MaterialButton(
                elevation: 6.0,
                color: primaryColor,
                padding: EdgeInsets.symmetric(
                    vertical: size.height / 50, horizontal: size.width / 15),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return LoginScreen();
                  }));
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: white,
                    fontSize: formButtonFont,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(
              height: size.height / 30,
            ),
            MaterialButton(
                elevation: 6.0,
                color: primaryColor,
                padding: EdgeInsets.symmetric(
                    vertical: size.height / 50, horizontal: size.width / 15),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return const SignUpScreen();
                  }));
                },
                child: const Text(
                  'SignUp',
                  style: TextStyle(
                    color: white,
                    fontSize: formButtonFont,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Container(
                alignment: Alignment.topLeft,
                child: SizedBox(
                    width: size.width / 1.7,
                    height: size.height / 5,
                    child: CustomPaint(
                      painter: CanvasPaint(),
                      child: Container(),
                    ))),
          ],
        ),
      )),
    );
  }
}
