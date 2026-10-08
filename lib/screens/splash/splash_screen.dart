import 'dart:async';

import 'package:flutter/material.dart';
import '../nav/bottom_nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  String _displayedText = '';

  final List<String> _typingText = [
    'm',
    'a',
    'd',
    'e',
    ' ',
    'w',
    'i',
    't',
    'h',
    ' ',
    'l',
    'o',
    'v',
    'e',
    ' ',
    '🫶🏻',
    ' ',
    'j',
    'u',
    's',
    't',
    ' ',
    'f',
    'o',
    'r',
    ' ',
    'y',
    'o',
    'u',
    ' ',
    '👉🏻'
    '👈🏻',
  ];
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();

    // Logo animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    );

    _logoController.forward();

    // Start typing after logo appears
    Future.delayed(const Duration(milliseconds: 700), () {
      _startTyping();
    });
  }

  void _startTyping() {
    int index = 0;

    _typingTimer = Timer.periodic(
      const Duration(milliseconds: 65),
          (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (index < _typingText.length) {
          setState(() {
            _displayedText += _typingText[index];
          });

          index++;
        } else {
          timer.cancel();

          Future.delayed(const Duration(milliseconds: 900), () {
            if (!mounted) return;

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const BottomNavView(),
              ),
            );
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF3F00),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _logoAnimation,
              child: Image.asset(
                'images/Jevlis Ka logo Splash.png',
                width: 220,
              ),
            ),

            const SizedBox(height: 28),

            Text(
              _displayedText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}