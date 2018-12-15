# Flutter Page Transition Package

This package gives you beautiful page transitions. 

## Usage 
It is really easy to use! 

<img src="http://www.yasinilhan.com/page_transition/screen.png" width="300" height="600" title="Screen Shoot">

## Examples

```dart 
Navigator.push(context,PageTransition(type: PageTransitionType.fade, child: DetailScreen()));

Navigator.push(context,PageTransition(type: PageTransitionType.leftToRight, child: DetailScreen()));

Navigator.push(context,PageTransition(type: PageTransitionType.scale, alignment: Alignment.bottomCenter, child: DetailScreen()));

Navigator.push(context,PageTransition(type: PageTransitionType.size, alignment: Alignment.bottomCenter,child: DetailScreen()));

Navigator.push(context,PageTransition(type: PageTransitionType.rotate, duration: Duration(second:1), child: DetailScreen()));
```
## Usage for Named Route Parameters
First you have to add MaterialApp property name onGenerateRoute like below and in switch cases you can Transition your new routes;
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
After that you can route new route
```dart 
Navigator.pushNamed(context, '/second'); 
```
## Type Of transition
`fade, rightToLeft, leftToRight, upToDown, downToUp, scale(with alignment), rotate(with alignment), size(with alignment)`

## Curves 
You can use any type of CurvedAnimation Curves
https://docs.flutter.io/flutter/animation/Curves-class.html 

## Alignments 
You can use size, scale and rotate transform alignment
https://docs.flutter.io/flutter/painting/Alignment-class.html 

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.io/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

