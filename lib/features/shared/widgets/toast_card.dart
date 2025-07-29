import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ToastCard extends StatefulWidget {
  final String message;

  const ToastCard({super.key, required this.message});

  @override
  State<ToastCard> createState() => _ToastCardState();
}

class _ToastCardState extends State<ToastCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, -2), // Slide from top
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if(!_disposed) {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 20,
      right: 20,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(8),
          color: theme.colorScheme.tertiary,
          child: Container(
            margin: const EdgeInsets.only(left: 4),
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 14),
                child: SvgPicture.asset('assets/icons/ic_check_circle.svg')
              ),
              Expanded(child: Text(
                widget.message,
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 15),
              )),
              IconButton(
                  onPressed: _controller.reverse,
                  icon: const Icon(Icons.close)
              )
            ])
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _disposed = true;
    super.dispose();
  }
}