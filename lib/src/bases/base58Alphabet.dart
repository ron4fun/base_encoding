/*
Copyright (c) 2021 Mbadiwe Nnaemeka Ronald ron2tele@gmail.com

    This software is provided 'as-is', without any express or implied
    warranty. In no event will the author be held liable for any damages
    arising from the use of this software.
    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not
    claim that you wrote the original software. If you use this software
    in a product, an acknowledgment in the product documentation must be
    specified.

    2. Altered source versions must be plainly marked as such, and must not be
    misrepresented as being the original software.

    3. This notice must not be removed or altered from any source distribution.
*/

import '../utils/types.dart';

class Base58Alphabet {
  static final _EmptyAlphabet = "Base58 alphabets cannot be empty";
  static final _InvalidAlphabetLength =
      "Base58 alphabets need to be 58-characters long";
  static final _InvalidCharacter = "Invalid character";

  static final _Length = 58;

  Map<String, int> _ReverseLookupTable = new Map();

  String _Value;

  static Base58Alphabet BitCoin = new Base58Alphabet(
      "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz");
  static Base58Alphabet Ripple = new Base58Alphabet(
      "rpshnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCg65jkm8oFqi1tuvAxyz");
  static Base58Alphabet Flickr = new Base58Alphabet(
      "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ");

  Base58Alphabet(String text) {
    if (text.length == 0)
      throw new ArgumentNullBaseEncodingException(_EmptyAlphabet);

    if (text.length != _Length)
      throw new InvalidArgumentBaseEncodingException(
          _InvalidAlphabetLength + ' ${text.length}');

    _Value = text;

    for (int i = 0; i < text.length; i++) {
      _ReverseLookupTable[text[i]] = i;
    }
  }

  String GetValue() => _Value;

  int GetSelf(String c) {
    try {
      return _ReverseLookupTable[c];
    } catch (e) {
      //pass
    }

    throw new InvalidOperationBaseEncodingException(
        _InvalidCharacter + ' ' + c);
  }

  static Base58Alphabet GetBitCoin() => BitCoin;

  static Base58Alphabet GetFlickr() => Flickr;

  static Base58Alphabet GetRipple() => Ripple;
}
