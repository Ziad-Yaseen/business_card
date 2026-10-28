import 'package:business_card/features/contacts/screens/contacts_view.dart';
import 'package:business_card/features/home/screens/home_view.dart';
import 'package:business_card/features/main_layout/cubit/main_layout_nav_cubit.dart';
import 'package:business_card/features/main_layout/widgets/bottom_nav_bar.dart';
import 'package:business_card/features/scan/screens/scan_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainLayoutNavCubit(),
      child: const _MainLayoutScaffold(),
    );
  }
}

class _MainLayoutScaffold extends StatefulWidget {
  const _MainLayoutScaffold();

  @override
  State<_MainLayoutScaffold> createState() => _MainLayoutScaffoldState();
}

class _MainLayoutScaffoldState extends State<_MainLayoutScaffold> {
  static const _items = [
    AppBottomNavItem(icon: Iconsax.cards, label: 'Cards'),
    AppBottomNavItem(
      icon: Iconsax.scan_barcode,
      label: 'Scan',
      isPrimary: true,
    ),
    AppBottomNavItem(icon: Iconsax.profile_2user, label: 'Contacts'),
  ];

  static const _pages = <Widget>[HomeView(), ScanView(), ContactsView()];

  final PageController _controller = PageController();

  bool _animating = false;
  int _navToken = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _goTo(int index) async {
    final cubit = context.read<MainLayoutNavCubit>();
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
    context.read<MainLayoutNavCubit>().select(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutNavCubit, int>(
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
