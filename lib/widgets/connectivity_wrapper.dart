import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'offline_screen.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({
    super.key,
    required this.child,
  });

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  bool _isOffline = false;
  bool _checking = true;

  @override
  void initState() {
    super.initState();

    _checkConnection();

    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      final hasConnection =
      results.any((result) => result != ConnectivityResult.none);

      if (hasConnection) {
        _checkConnection();
      } else {
        if (mounted) {
          setState(() {
            _isOffline = true;
            _checking = false;
          });
        }
      }
    });
  }

  Future<void> _checkConnection() async {
    if (mounted) {
      setState(() {
        _checking = true;
      });
    }

    final results = await Connectivity().checkConnectivity();

    final hasConnection =
    results.any((result) => result != ConnectivityResult.none);

    if (!mounted) return;

    setState(() {
      _isOffline = !hasConnection;
      _checking = false;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_checking) {
      return const _AppSkeleton();
    }

    if (_isOffline) {
      return OfflineScreen(
        onRetry: _checkConnection,
      );
    }

    return widget.child;
  }
}

class _AppSkeleton extends StatelessWidget {
  const _AppSkeleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              _SkeletonBox(
                width: 160,
                height: 30,
              ),

              const SizedBox(height: 30),

              _SkeletonBox(
                width: double.infinity,
                height: 25,
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  _SkeletonBox(
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(width: 15),
                  _SkeletonBox(
                    width: 150,
                    height: 150,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              _SkeletonBox(
                width: 200,
                height: 25,
              ),

              const SizedBox(height: 20),

              _SkeletonBox(
                width: double.infinity,
                height: 100,
              ),

              const SizedBox(height: 15),

              _SkeletonBox(
                width: double.infinity,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double width;
  final double height;

  const _SkeletonBox({
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}