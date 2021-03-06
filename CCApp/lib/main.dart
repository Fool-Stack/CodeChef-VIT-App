import 'package:CCApp/providers/meeting.dart';
import 'package:CCApp/providers/profile.dart';
import 'package:CCApp/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:CCApp/screens/login.dart';
import 'package:CCApp/providers/reg.dart';
import 'package:CCApp/providers/projects.dart';
import 'loading_screen.dart';
import './providers/memberdata.dart';
import 'package:CCApp/providers/expenses.dart';

void main() {
  runApp(
    RestartWidget(
      child: MyApp(),
    ),
  );
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Reg(),
        ),
        ChangeNotifierProvider.value(
          value: Profile(),
        ),
        ChangeNotifierProvider.value(
          value: MemberData(),
        ),
        ChangeNotifierProvider.value(
          value: MeetingData(),
        ),
        ChangeNotifierProvider.value(
          value: Project(),
        ),
        ChangeNotifierProvider.value(
          value: Expense(),
        )
      ],
      child: Consumer<Reg>(
        builder: (context, reg, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: reg.isReg
                ? HomePage(
                    currentIndex: 0,
                  )
                : FutureBuilder(
                    future: reg.tryAutoLogin(),
                    builder: (context, res) {
                      if (res.connectionState == ConnectionState.waiting) {
                        return LoadingScreen();
                      } else {
                        if (res.data) {
                          return HomePage(
                            currentIndex: 0,
                          );
                        } else {
                          return LoginScreen();
                        }
                      }
                    })),
      ),
    );
  }
}
