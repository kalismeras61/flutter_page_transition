# Flutter Page Transition Package

This package gives you beautiful page transitions. 

## Usage 
It is really easy to use! 

## Examples

```dart 
Navigator.push(context,PageTransition(type:'fade', child: DetailScreen())); 

Navigator.push(context,PageTransition(type:'leftToRigth', child: DetailScreen())); 

Navigator.push(context,PageTransition(type:'scale',aligment: Alignment.bottomCenter, child: DetailScreen())); 

Navigator.push(context,PageTransition(type:'size', aligment: Alignment.bottomCenter,child: DetailScreen())); 

Navigator.push(context,PageTransition(type:'rotate', aligment: Alignment.bottomCenter,child: DetailScreen())); 
```
## Type Of transition
`fade, rightToLeft, leftToright, UpToDown, DownToUp, scale(with alignment) ,rotate(with alignment), size(with alignment)`

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

