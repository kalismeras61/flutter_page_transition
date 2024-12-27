# Flutter Page Transition Package

A Flutter package that provides beautiful page transitions with an easy-to-use API.

[![flutter platform](https://img.shields.io/badge/Platform-Flutter-yellow.svg)](https://flutter.io)
[![pub package](https://img.shields.io/pub/v/page_transition.svg)](https://pub.dartlang.org/packages/page_transition)
[![BSD-2-Clause](https://img.shields.io/badge/BSD-2-Clause.svg?style=flat-square)](https://opensource.org/licenses/)

## Installation

```yaml
dependencies:
  page_transition: ^latest_version
```

## Usage

### Using Extensions (Recommended)

```dart
// Simple transition
context.pushTransition(
  type: PageTransitionType.fade,
  child: DetailScreen(),
);

// Using builder pattern
context.pushTransition(
  type: PageTransitionType.fade,
  childBuilder: (context) => DetailScreen(
    id: someId,
    title: someTitle,
  ),
);

// Push replacement
context.pushReplacementTransition(
  type: PageTransitionType.rightToLeft,
  child: DetailScreen(),
);

// Push and remove until
context.pushAndRemoveUntilTransition(
  type: PageTransitionType.fade,
  child: HomePage(),
  predicate: (route) => false,
);

// Named route with transition
context.pushNamedTransition(
  routeName: '/detail',
  type: PageTransitionType.fade,
  arguments: {'id': 1},
);
```

### Traditional Usage

```dart
Navigator.push(
  context,
  PageTransition(
    type: PageTransitionType.fade,
    child: DetailScreen(),
  ),
);

// Or using builder pattern
Navigator.push(
  context,
  PageTransition(
    type: PageTransitionType.fade,
    childBuilder: (context) => DetailScreen(id: someId),
  ),
);
```

### Using with Route Generation (GoRouter, AutoRoute, etc.)

```dart
MaterialApp(
  onGenerateRoute: (settings) {
    switch (settings.name) {
      case '/details':
        return PageTransition(
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: context.currentRoute, // Get current route widget
          child: DetailsPage(),
          settings: settings,
        );

      case '/shared-axis':
        // Example of shared axis transition
        return PageTransition(
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: context.currentRoute,
          child: SharedAxisPage(),
          settings: settings,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 400),
        );
    }
  },
);
```

### Using with GoRouter

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/details/:id',
      pageBuilder: (context, state) {
        return PageTransition(
          type: PageTransitionType.rightToLeftJoined,
          childCurrent: context.currentRoute,
          child: DetailsPage(id: state.params['id']),
          settings: RouteSettings(name: state.location),
        );
      },
    ),
  ],
);
```

## Available Transition Types

- `fade`
- `rightToLeft`
- `leftToRight`
- `topToBottom`
- `bottomToTop`
- `scale` (with alignment)
- `rotate` (with alignment)
- `size` (with alignment)
- `rightToLeftWithFade`
- `leftToRightWithFade`
- `leftToRightJoined`
- `rightToLeftJoined`
- `topToBottomJoined`
- `bottomToTopJoined`
- `leftToRightPop`
- `rightToLeftPop`
- `topToBottomPop`
- `bottomToTopPop`

## Additional Features

### iOS Swipe Back

Enable iOS-style swipe back gesture:

```dart
context.pushTransition(
  type: PageTransitionType.rightToLeft,
  child: DetailScreen(),
  isIos: true,
);
```

Note: iOS swipe back works only with `rightToLeft` and `fade` transitions.

### Inherit Theme

Use the parent's theme in the transition:

```dart
context.pushTransition(
  type: PageTransitionType.rightToLeft,
  child: DetailScreen(),
  inheritTheme: true,
);
```

### Custom Duration and Curve

```dart
context.pushTransition(
  type: PageTransitionType.fade,
  child: DetailScreen(),
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
);
```

## Video Tutorial

Check out [Johannes Milke's tutorial](https://www.youtube.com/watch?v=q-e5t3qnB_M) for a detailed walkthrough.

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

## License

[BSD 2-Clause](https://opensource.org/licenses/BSD-2-Clause)
