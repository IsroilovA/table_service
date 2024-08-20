import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_service/order_list_screen/order_list_screen.dart';
import 'package:table_service/table_service_screen.dart/table_service_screen.dart';
import 'package:table_service/tabs/cubit/tabs_cubit.dart';
import 'package:table_service/tabs/widgets/drawer_header_text.dart';

// Main screen that handles navigation between different tabs
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  void onDrawerTapped(int index) {
    BlocProvider.of<TabsCubit>(context).selectPage(index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((TabsCubit cubit) => cubit.state);
    String pageTitle = switch (selectedTab) {
      0 => "Home",
      1 => "Order List",
      2 => "To Go",
      3 => "Quick Order",
      _ => throw UnimplementedError(),
    };

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(pageTitle),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DrawerHeaderText("Account"),
                      DrawerHeaderText(
                        "Sarah",
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DrawerHeaderText(
                        "Workplace",
                      ),
                      DrawerHeaderText("Kiosk 1"),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              onTap: () {
                onDrawerTapped(0);
              },
              leading: const Icon(Icons.room_service_outlined),
              title: const Text("Table Service"),
            ),
            ListTile(
              onTap: () {
                onDrawerTapped(2);
              },
              leading: const Icon(Icons.outbox_outlined),
              title: const Text("To Go"),
            ),
            ListTile(
              onTap: () {
                onDrawerTapped(3);
              },
              leading: const Icon(Icons.takeout_dining_outlined),
              title: const Text("Quick Order"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.delivery_dining_outlined),
              title: const Text("Delivary"),
            ),
            ListTile(
              onTap: () {
                onDrawerTapped(1);
              },
              leading: const Icon(Icons.list_alt_outlined),
              title: const Text("Order List"),
            ),
          ],
        ),
      ),
      body: BlocBuilder<TabsCubit, int>(
        builder: (context, state) {
          return IndexedStack(
            index: state,
            children: const [
              TableServiceScreen(),
              OrderListScreen(),
              Center(child: Text("To be implemented")),
              Center(child: Text("To be implemented"))
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: BlocProvider.of<TabsCubit>(context).selectPage,
        currentIndex: selectedTab,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        elevation: 2,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.room_service_outlined),
            label: "Table Service",
            activeIcon: Icon(Icons.room_service),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: "Order List",
            activeIcon: Icon(Icons.list_alt),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.outbox_outlined),
            label: "To Go",
            activeIcon: Icon(Icons.outbox),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.takeout_dining_outlined),
            label: "Quick Order",
            activeIcon: Icon(Icons.takeout_dining),
          ),
        ],
      ),
    );
  }
}
