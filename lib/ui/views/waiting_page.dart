import 'package:flutter/material.dart';
import 'package:fractal_technical_interview/main.dart';
import 'package:fractal_technical_interview/models/user.dart';
import 'package:fractal_technical_interview/ui/views/login_page.dart';

const _duration = Duration(milliseconds: 500);

enum WaitingPageState { initial, start, end }

class WaitingPage extends StatefulWidget {
  final void Function(bool action) setSubmit;
  final VoidCallback onAnimationStarted;
  final Animation<double> progressAnimation;
  final void Function() resetUserProps;
  final Null Function() animationReset;
  final User? user;
  const WaitingPage(
      {super.key,
      required this.onAnimationStarted,
      required this.progressAnimation,
      required this.setSubmit,
      required this.resetUserProps,
      required this.animationReset,
      this.user});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  WaitingPageState _currentState = WaitingPageState.initial;

  void _validation() {
    _currentState = WaitingPageState.start;
    widget.onAnimationStarted();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: _currentState == WaitingPageState.end
                  ? TweenAnimationBuilder(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: _duration,
                      builder: (_, value, child) => Opacity(
                        opacity: value,
                        child: child,
                      ),
                      child: ProgressCounter(widget.progressAnimation),
                    )
                  : TweenAnimationBuilder(
                      tween: Tween(
                          begin: 1.0,
                          end: _currentState != WaitingPageState.initial
                              ? 0.0
                              : 1.0),
                      duration: _duration,
                      onEnd: () => setState(() {
                        _currentState = WaitingPageState.end;
                      }),
                      builder: (_, value, child) => Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0.0, 20 * value),
                          child: child,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Iniciar sesión con el usuario con DNI',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.user!.dni,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 2),
                        ],
                      ),
                    ),
            ),
            AnimatedSwitcher(
                duration: _duration,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  child: _currentState == WaitingPageState.initial
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  widget.resetUserProps();
                                  widget.setSubmit(false);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const LoginPage()));
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                                  0.1 -
                                              12),
                                  child: const Text(
                                    'Cancelar',
                                    style: TextStyle(color: mainBackupColor),
                                  ),
                                )),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainBackupColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: _validation,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.1),
                                child: const Text(
                                  'Iniciar Sesión',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : OutlinedButton(
                          onPressed: () {
                            widget.animationReset();
                            setState(() {
                              _currentState = WaitingPageState.initial;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(color: mainBackupColor),
                          )),
                )),
          ],
        ),
      ),
    );
  }
}

class ProgressCounter extends AnimatedWidget {
  const ProgressCounter(Animation<double> animation, {super.key})
      : super(listenable: animation);

  double get value => (listenable as Animation).value;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value > 0.5 ? 'Validando datos ...' : 'Validando registros ...',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${(value * 100).truncate().toString()}%',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 52,
            ),
          ),
        ],
      );
}
