import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kanban_app/features/dashboared/bloc/kanban_bloc.dart';
import 'package:kanban_app/features/dashboared/page/dashboread.dart';
import 'package:kanban_app/core/utils/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [...DevicePreview.defaultTools],
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KanbanBloc(),
      child: BlocBuilder<KanbanBloc, KanbanState>(
        builder: (context, state) {
          return ShadApp(
            locale: DevicePreview.locale(context),
            theme: AppTheme.lightMode,
            darkTheme: AppTheme.darkMode,
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            title: 'Flutter Demo',
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: BouncingScrollWrapper.builder(context, child!),
              breakpoints: [
                Breakpoint(start: 0, end: 759, name: MOBILE),
                Breakpoint(start: 759, end: 1200, name: TABLET),
                Breakpoint(start: 1201, end: 1300, name: DESKTOP),
                Breakpoint(start: 1301, end: double.infinity, name: '4K'),
                //  Breakpoint(start: 1920, end: double.infinity, name: '4K'),
              ],
            ),

            home: Dashboread(),
          );
        },
      ),
    );
  }
}
