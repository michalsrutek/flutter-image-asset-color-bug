## ℹ️

Demo Flutter project demonstrating a bug when using `color` with `Image.asset`.

```dart
Image.asset(
    'assets/img.png',
    width: innerCircleWidth,
    height: innerCircleWidth,
    // !!! Using a color does something weird
    color: useColor ? Colors.orange : null,
),
```

Tracked at [TODO... ADD LINK](https://github.com).

## 📹

<img src="video.gif" width="300">

[Video in mp4](video.mp4)
