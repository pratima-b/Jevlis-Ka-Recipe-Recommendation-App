import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/screens/favorite_screen/favorite_screen.dart';
import 'package:app/screens/home_screen/bloc/homerecipes_bloc.dart';
import 'package:app/screens/home_screen/home_screen.dart';
import 'package:app/screens/more/more.dart';
import 'package:app/screens/search_page/cubit/search_page_cubit.dart';
import 'package:app/screens/search_page/search_page.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  int _currentIndex = 0;

  late final List<Widget> _screens = [
    BlocProvider(
      create: (_) => HomeRecipesBloc(),
      child: const HomeRecipeScreen(),
    ),
    BlocProvider(
      create: (_) => SearchPageCubit(),
      child: const SearchPage(),
    ),
    const FavoriteScreen(),
    const More(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFFF3F00),
        unselectedItemColor: Colors.black,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill, size: 20),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search, size: 20),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.suit_heart, size: 20),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet_indent, size: 20),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
