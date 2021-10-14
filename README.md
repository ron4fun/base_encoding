## base_encoding [![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/ron4fun/base_encoding/blob/master/LICENSE) [![Build Status](https://travis-ci.org/ron4fun/base_encoding.svg?branch=master)](https://travis-ci.org/ron4fun/base_encoding)
**`base_encoding`** is a compact and standalone encoding library that provides at the moment support for encoding and decoding various bases such as Base16, Base32 (various variants), Base58 (various variants) and Base64 (various variants).

**Supported Encodings:**

    Base64: Default, DefaultNoPadding, UrlEncoding, XmlEncoding, RegExEncoding and FileEncoding alphabets 
    (and any custom alphabet you might have)
    
    Base58: Bitcoin, Ripple and Flickr alphabets (and any custom alphabet you might have)

    Base32: RFC 4648, Crockford and Extended Hex (BASE32-HEX) alphabets with Crockford character substitution 
    (or any other custom alphabets you might want to use)   
    
    Base16: An experimental hexadecimal encoder/decoder.

   
**Usage Examples.**

```dart
import 'package:base_encoding/base_encoding.dart';


main() {
    final base32 = BaseEncoding.CreateBase32Crockford();

    String rawData = "foobar";

    var output = base32.Encode(rawData.codeUnits, false);

    print('Output: ${output}'); // Output: CSQPYRK1E8
}
```
    
**License**

This "Software" is Licensed Under  **`MIT License (MIT)`** .

#### Tip Jar
* :dollar: **Bitcoin**: `1Mcci95WffSJnV6PsYG7KD1af1gDfUvLe6`
