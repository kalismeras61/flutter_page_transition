# Flutter Page Transition Package

This package gives you beautiful page transitions. 

[![pub package](https://img.shields.io/pub/v/page_transition.svg)](https://pub.dartlang.org/packages/page_transition)

## Demo
<img src="http://www.yasinilhan.com/page_transition/screen.png" width="300" height="600" title="Screen Shoot">

## Usage
It is really easy to use!

```dart 
Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: DetailScreen()));

Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: DetailScreen()));

Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: DetailScreen()));

Navigator.push(context, PageTransition(type: PageTransitionType.upToDown, child: DetailScreen()));

Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child: DetailScreen()));

Navigator.push(context, PageTransition(type: PageTransitionType.scale, alignment: Alignment.bottomCenter, child: DetailScreen()));

Navigator.push(context, PageTransition(type: PageTransitionType.size, alignment: Alignment.bottomCenter, child: DetailScreen()));

Navigator.push(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(second: 1), child: DetailScreen()));
```

## Usage for predefined routes
First, define the `onGenerateRoute` property in the `MaterialApp` widget like below and in switch cases you can transition to your new routes:

```dart 
  onGenerateRoute: (settings) {
    switch (settings.name) {
      case '/second':
        return PageTransition(child: SecondPage(), type: PageTransitionType.scale);
        break;
      default:
        return null;
    }
  },
```

After that you can use your new route like this:

```dart 
Navigator.pushNamed(context, '/second'); 
```

## Types of transitions
* fade
* rightToLeft
* leftToRight
* upToDown
* downToUp
* scale (with alignment)
* rotate (with alignment)
* size (with alignment)

## Curves 
You can use any type of CurvedAnimation [curves](https://docs.flutter.io/flutter/animation/Curves-class.html). 

## Alignments 
You can use size, scale and rotate transform [alignment](https://docs.flutter.io/flutter/painting/Alignment-class.html ).

## Getting Started
This project is a starting point for a Dart
[package](https://flutter.io/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.