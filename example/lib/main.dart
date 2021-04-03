// Basic Use
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Argo Example App',
      debugShowCheckedModeBanner: false,
      home: ResponsiveWrapper(
        wrapConfig: WrapperConfig(
          globalBreakpoints: ScreenBreakpoints(
            mobile: 321,
            tablet: 650,
            desktop: 1100,
          ),
        ),
        child: MainScreen(),
      ),
    );
  }
}

// ResponsiveLayoutBuilder
ResponsiveLayoutWidget.builder(
  mobile: (ctx, info) => MobileChild(),
  tablet: (ctx, info) => TabletChild(),
  desktop:(ctx, info) => DesktopChild(),
)

// ResponsiveVisibility
ResponsiveVisibility.screen(
  conditionScreen: ConditionScreen(
    mobile: true,
    tablet: true,
    desktop: false,
  ),
  child: Container(
    color: Colors.red,
    width: 50,
    height: 50
  ),
),


// ResponsiveTheme
ResponsiveTheme.screen(
   conditionScreen: ConditionScreen(
     mobile: MyThemesApp(),
     tablet: MyThemesTablet(),
     desktop: MyThemesWeb(),
   ),
 )