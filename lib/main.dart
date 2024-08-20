import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_service/services/locator.dart';
import 'package:table_service/tabs/cubit/tabs_cubit.dart';
import 'package:table_service/tabs/tabs_screen.dart';

// Theme for the light mode
final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(
        213, 0, 4, 255), // Primary color for the light theme
    brightness: Brightness.light, // Brightness setting for the light theme
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialiseLocator();
  // print((await locator<TestDraftRepository>().getAllTables())!
  //     .last
  //     .getListOfEntries);
  runApp(const App());
}

// Root widget of the application
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: BlocProvider(
        create: (context) => TabsCubit(),
        child: const TabsScreen(),
      ),
    );
  }
}
