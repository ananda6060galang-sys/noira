import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'root_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<Offset> _logoOffset;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _textOffset;
  late final Animation<double> _glowOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.48, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.82, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.58, curve: Curves.easeOutCubic),
      ),
    );
    _logoOffset = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0, 0.62, curve: Curves.easeOutCubic),
          ),
        );
    _textOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.38, 0.9, curve: Curves.easeOut),
    );
    _textOffset = Tween<Offset>(begin: const Offset(0, 0.22), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.38, 0.9, curve: Curves.easeOutCubic),
          ),
        );
    _glowOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 0.38), weight: 45),
      TweenSequenceItem(tween: Tween(begin: 0.38, end: 0.18), weight: 55),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
    Future.delayed(const Duration(seconds: 2), _goToHome);
  }

  void _goToHome() {
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 650),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const RootScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.15),
                  radius: 0.78,
                  colors: [
                    AppColors.accentSoft.withValues(alpha: 0.42),
                    AppColors.background,
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SlideTransition(
                  position: _logoOffset,
                  child: FadeTransition(
                    opacity: _logoOpacity,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: AnimatedBuilder(
                        animation: _glowOpacity,
                        builder: (context, child) {
                          return Container(
                            width: 154,
                            height: 154,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.accent.withValues(
                                    alpha: _glowOpacity.value,
                                  ),
                                  blurRadius: 42,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: child,
                          );
                        },
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 136,
                          height: 136,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 136,
                              height: 136,
                              decoration: const BoxDecoration(
                                color: AppColors.accentSoft,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.graphic_eq,
                                color: AppColors.accent,
                                size: 58,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SlideTransition(
                  position: _textOffset,
                  child: FadeTransition(
                    opacity: _textOpacity,
                    child: const Column(
                      children: [
                        Text(
                          'Noira',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Your mood, in sound.',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
