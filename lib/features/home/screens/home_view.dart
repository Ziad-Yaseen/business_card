import 'package:business_card/features/home/cubit/home_nav_cubit.dart';
import 'package:business_card/features/home/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeNavCubit(),
      child: const _HomeScaffold(),
    );
  }
}

class _HomeScaffold extends StatefulWidget {
  const _HomeScaffold();

  @override
  State<_HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<_HomeScaffold> {
  static const _items = [
    AppBottomNavItem(icon: Icons.style_outlined, label: 'Cards'),
    AppBottomNavItem(
      icon: Icons.qr_code_2_rounded,
      label: 'Scan',
      isPrimary: true,
    ),
    AppBottomNavItem(icon: Icons.group_outlined, label: 'Contacts'),
  ];

  static const _pages = <Widget>[
    _KeepAlive(child: _TabPlaceholder('My cards')),
    _KeepAlive(child: _TabPlaceholder('Scan')),
    _KeepAlive(child: _TabPlaceholder('Contacts')),
  ];

  final PageController _controller = PageController();

  bool _animating = false;
  int _navToken = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _goTo(int index) async {
    final cubit = context.read<HomeNavCubit>();
    if (index == cubit.state) return;

    HapticFeedback.selectionClick();
    cubit.select(index);

    final token = ++_navToken;
    _animating = true;
    await _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
    if (mounted && token == _navToken) _animating = false;
  }

  void _onPageChanged(int index) {
    if (_animating) return;
    context.read<HomeNavCubit>().select(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavCubit, int>(
      builder: (context, index) {
        return PopScope(
          canPop: index == 0,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) _goTo(0);
          },
          child: Scaffold(
            body: PageView(
              controller: _controller,
              onPageChanged: _onPageChanged,
              children: _pages,
            ),
            bottomNavigationBar: AppBottomNavBar(
              currentIndex: index,
              items: _items,
              onTap: _goTo,
            ),
          ),
        );
      },
    );
  }
}

class _KeepAlive extends StatefulWidget {
  const _KeepAlive({required this.child});

  final Widget child;

  @override
  State<_KeepAlive> createState() => _KeepAliveState();
}

class _KeepAliveState extends State<_KeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

class _TabPlaceholder extends StatelessWidget {
  const _TabPlaceholder(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
