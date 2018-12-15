# Flutter Page Transition Package

This package gives you beautiful page transitions.
<br/><br/>
</a>
	<a href="https://flutter.io">
    <img src="https://img.shields.io/badge/Platform-Flutter-yellow.svg"
      alt="Platform" />
  </a>
[![pub package](https://img.shields.io/pub/v/page_transition.svg)](https://pub.dartlang.org/packages/page_transition) 
</a>
<a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/BSD-2-Clause.svg?style=flat-square"
      alt="License: BSD-2-Clause" />
  </a>
## Demo
<img src="http://www.yasinilhan.com/page_transition/page_transition.gif" width="320" height="600" title="Screen Shoot">

## Usage
It is really easy to use!
You should ensure that you add the `page_transition` as a dependency in your flutter project.

```yaml
dependencies:
  page_transition: '^1.0.5'
```
Than you can use it with below examples.

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
You can use size, scale and rotate transform [alignment](https://docs.flutter.io/flutter/painting/Alignment-class.html)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[BSD 2-Clause](https://opensource.org/licenses/BSD-2-Clause)


