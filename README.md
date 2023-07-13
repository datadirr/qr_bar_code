[<img src="https://datadirr.com/datadirr.png" width="200" />](https://datadirr.com)

# qr_bar_code

Simple and fast QR code and Barcode generator and scanner with smartphones.

## Using

For help getting started with Flutter, view our
[online documentation](https://pub.dev/documentation/qr_bar_code/latest), which offers tutorials,
samples, guidance on mobile and web development, and a full API reference.

## Installation

First, add `qr_bar_code` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

In your flutter project add the dependency:

```yml
dependencies:
  ...
  qr_bar_code:
```

For help getting started with Flutter, view the online
[documentation](https://flutter.io/).


## Example

Please follow this [example](https://github.com/datadirr/qr_bar_code/tree/master/example) here.


### QR code (Method 1)

```dart
Code(data: "https://datadirr.com", codeType: CodeType.qrCode())
```

### QR code (Method 2)

```dart
QRCode(data: "https://datadirr.com")
```


# Outro
## Credits
Thanks to Luke Freeman for his awesome [qr.flutter](https://github.com/theyakka/qr.flutter) library.
Thanks to Kevin Moore for his awesome [qr.dart](https://github.com/kevmoo/qr.dart) library. It's the core of this library.

For author/contributor information, see the `AUTHORS` file.