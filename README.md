<p align="center">
<img src="https://raw.githubusercontent.com/jamescardona11/argo/3c265cd83ffd14c3d11c30dbfa484df96c7a0ed3/img/argo_logo.svg" height="250" alt="Argo Package" />
</p>

---

Widgets and tools for make it easy to create responsive apps for mobile, tablet and web. To handle visibility, orientation and handle diferent layout depend of screen.

Special thanks to:

1. [filledstacks](https://www.filledstacks.com/)
2. [Codelessly](https://www.github.com/Codelessly)
3. [GskinnerTeam](https://www.github.com/gskinnerTeam)

---

## Quick Start

Import this library into your project:

```yaml
argo: ^latest_version
```

Add `ResponsiveWrapper` to your MaterialApp or CupertinoApp.
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResponsiveWrapper(
        wrapConfig: WrapperConfig(
          globalBreakpoints: ScreenBreakpoints(
            mobile: 321,
            tablet: 650,
            desktop: 1100,
          ),
        ),
        child: Home(),
      ),
    );
  }
}
```

Or Add `ResponsiveWrapper.builder` to your MaterialApp or CupertinoApp.
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        wrapConfig: WrapperConfig(
          globalBreakpoints: ScreenBreakpoints(
            mobile: 321,
            tablet: 650,
            desktop: 1100,
          ),
        ),
        builder: (ctx, themeDataRule) => child!,
      ),
      home: Home(),
    );
  }
}
```
That's it!
This widget allows to configurate the `WrapperConfig`.
You can make the manage for `Responsive Theme`

### ScreenBreakpoints
Are the control points that tells `ResponsiveWrapper` to change the `DeviceScreen`.
This is an upper or lower limit depends on how it is configured compared with `Size.width`.

Also it serves to do comparisons with the `Condition` class.
`SBValue` save a value that means `Size.width`.


## Responsive Widgets

### ResponsiveVisibility
Widget to show or hide a `child` depending of the `Condition`.
You can override the globalBreakpoints for localBreakpoints

```dart
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

```
You can change the condition type and improve the versatility of conditions with `ConditionBreakpoint`, and make result for VisibleWhen or HiddenWhen.

```dart
const List<ConditionBreakpoint<bool>> conditions = [
  ConditionBreakpoint<bool>.equals(
    screenType: DeviceScreen.mobile,
    value: true,
  ),
  ConditionBreakpoint<bool>.smallerThan(
    screenType: DeviceScreen.desktop,
    value: true,
  ),
  ConditionBreakpoint<bool>.equals(
    screenType: DeviceScreen.tablet,
    value: false,
  ),
  ConditionBreakpoint<bool>.largerThan(
    value: true,
    breakpoint: 950,
  ),
];

ResponsiveVisibility.conditions(
  visibleWhen: conditions,
  child: Container(
    color: Colors.red,
    width: 50,
    height: 50
  ),
),

```


### ResponsiveLayoutWidget

This widget show different widget depending of `screen` type, the condition configuration in `ResponsiveWrapper`, 
you can override the globalBreakpoints for localBreakpoints.

```dart
ResponsiveLayoutWidget(
  mobile: MobileChild(),
  tablet: TabletChild(),
  desktop: DesktopChild(),
)

```

In some moments you return and `RBuilder`, this typedef have the context and `ResponsiveInformation`.
With `ResponsiveInformation` allows change the basic structure and improve the versatility.

```dart
ResponsiveLayoutWidget.builder(
  mobile: (ctx, info) => MobileChild(),
  tablet: (ctx, info) => TabletChild(),
  desktop:(ctx, info) => DesktopChild(),
)

```


### ResponsiveBuilder

This generic widget to handle responsive builder, this widget return the context and `ResponsiveInformation`.
`ResponsiveInformation` is data class to handle `responsive` information for the widget.
ResponsiveInformation have orientation, localSize, ScreenSize, currentBreakpoints and `DeviceScreen`.

```dart
ResponsiveBuilder(
  builder: (ctx, info) { 
    if(info.localSize.width > 300 && info.deviceScreen.isTablet()){
      return Container(
                color: Colors.red,
                width: 50,
                height: 50
              );
    }else{
      return const SizedBox();
    }
  }
)

```



### OrientationLayoutBuilder

This widget is it create views depending of their `orientation`.
The widget is build with `RBuilder`, this typedef have the context and `ResponsiveInformation`.

```dart
OrientationLayoutBuilder(
  portrait: (ctx, info) => PortraitChild(),
  landscape: (ctx, info) => LandscapeChild(),
)

```


## TOOLS

### valueFromConditionByBreakpoints

You can get single value from `ConditionBreakpoint` List
It's goal is to have more modular conditions compared it with differents `breakpoint` we can use this to create more complex conditions. And you have three different construtors: 
`ConditionBreakpoint.equals` `ConditionBreakpoint.largerThan`, `ConditionBreakpoint.smallerThan`

```dart
const List<ConditionBreakpoint<bool>> conditions = [
  ConditionBreakpoint<bool>.equals(
    screenType: DeviceScreen.mobile,
    value: true,
  ),
  ConditionBreakpoint<bool>.smallerThan(
    screenType: DeviceScreen.desktop,
    value: true,
  ),
  ConditionBreakpoint<bool>.equals(
    screenType: DeviceScreen.tablet,
    value: false,
  ),
  ConditionBreakpoint<bool>.largerThan(
    value: true,
    breakpoint: 950,
  ),
];

final value = valueFromConditionByBreakpoints<bool>(
  context: context,
  condition: conditions,
  localBreakpoints: screenBreakpoints,
  defaultValue: true,
);

```

### valueFromConditionByBreakpoints

You can get single value from `ConditionScreen`,
It's goal is to have conditional value for the tree screen types `mobile`, `tablet`, `desktop`.

```dart
const condition = ConditionScreen(
  mobile: 'Apple',
  tablet: 'Orange',
  desktop: 'Watermelon',
);

final value = valueFromConditionByScreen<String>(
  context: context,
  condition: condition,
  localBreakpoints: screenBreakpoints,
  defaultValue: 'Lemon',
);

```

### ResponsiveContext Extension

You can get from the context info for make it easy the responsive apps

```dart
  context.widthPx = Returns same as MediaQuery.of(context).size.width
  context.heightPx = Returns same as MediaQuery.of(context).size.height
  context.theme = Getting Theme
  context.widthPct(10) = Returns percent (1-100) of screen width in pixels
  ...

```

### Responsive Theme 

Data class to handle the `theme responsive` information, this class may be used from `ResponsiveWrapper`
It's used from `ResponsiveWrapper` to get the value for the currentBreakpoints
Use differents `conditions` to store the themes.

The advantage is that you can create all the classes with `IThemeDataRule` for the configurations the app need.

It basic use:
```dart
ResponsiveTheme.screen(
   conditionScreen: ConditionScreen(
     mobile: MyThemesApp(),
     tablet: MyThemesTablet(),
     desktop: MyThemesWeb(),
   ),
 )
```

This is an example of a configuration:
```Dart


class MyThemesApp with IThemeDataRule {
  @override
  ThemeData getThemeByRule(ThemeRule rule) {
    switch (rule) {
      case ThemeRule.light:
        return lightTheme;
      case ThemeRule.dark:
        return darkTheme;
      case ThemeRule.custom:
        return darkerTheme;
      default:
        return lightTheme;
    }
  }
}

// This is a themeData for LightTheme is a normal object
final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blueGrey,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline1: headline1.copyWith(fontSize: 26),
      headline2: headline2.copyWith(fontSize: 18),
    ),
  );


```
For more information and understand the ThemeResponsive check the Documentation and the Example.




### Examples

1. [ArgoExample](https://github.com/jamescardona11/argo/tree/main/example/argo_example): Simple example of use the argo library
2. [ThemingExample](https://github.com/jamescardona11/argo/tree/main/example/argo_example): Basic use for the ResponsiveTheming
3. [MyPortfolioApp](https://github.com/jamescardona11/my_portfolio_web): TODO



Flutter is a game-changing technology that will revolutionize not just development, but software itself. A big thank you to the Flutter team for building such an amazing platform 💙 

<a href="https://github.com/flutter/flutter">
  <img alt="Flutter"
       src="https://github.com/jamescardona11/argo/blob/main/img/flutter_logo.png?raw=true" />
</a>


## Maintainers

- [James Cardona](https://github.com/jamescardona11)

You are welcome to contribute :3

## License

    MIT License
    Copyright (c) 2021 James Cardona

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.