import 'package:event_app/providers/theme_provider.dart';
import 'package:event_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CustomLoadingItem extends StatefulWidget {
  final bool initialVisible;

  const CustomLoadingItem({
    super.key,
    this.initialVisible = false,
  });

  @override
  CustomLoadingItemState createState() => CustomLoadingItemState();
}

class CustomLoadingItemState extends State<CustomLoadingItem>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late bool _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = widget.initialVisible;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    if (_isVisible) {
      _controller.repeat();
    }
  }

  void show() {
    if (!_isVisible) {
      setState(() {
        _isVisible = true;
      });
      _controller.repeat();
    }
  }

  void hide() {
    if (_isVisible) {
      setState(() {
        _isVisible = false;
      });
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (!_isVisible) return const SizedBox.shrink();

    return Center(
      child: SpinKitWave(
        color: themeProvider.currentTheme == ThemeMode.light
            ? AppColors.blueColor
            : AppColors.whiteColor,
        size: 80.0,
        controller: _controller,
      ),
    );
  }
}
