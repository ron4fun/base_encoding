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

import '../utils/bits.dart';
import '../utils/types.dart';
import '../utils/utils.dart';

/// Hexadecimal encoding/decoding
class Base16 {
  static final _NumberOffset = 48;
  static final _UpperNumberDiff = 7;
  static final _LowerUpperDiff = 32;

  static final _LowerAlphabet = "0123456789abcdef";
  static final _UpperAlphabet = "0123456789ABCDEF";

  static final _InvalidHexCharacter = "Invalid hex character:";
  static final _InvalidTextLength = "Text cannot be odd length";

  static void _ValidateHex(int c) {
    if (!(((c >= 48) && (c <= 57)) ||
        ((c >= 65) && (c <= 70)) ||
        ((c >= 97) && (c <= 102))))
      throw new InvalidOperationBaseEncodingException(
          '${_InvalidHexCharacter} ${c}');
  }

  static int _GetHexByte(int character) {
    int c = character - _NumberOffset;
    if (c < 10) // is number?
      return c;

    c = c - _UpperNumberDiff;
    if (c < 16) // is uppercase?
      return c;

    return c - _LowerUpperDiff;
  }

  String _Encode(List<int> bytes, String alphabet) {
    StringBuffer result = new StringBuffer();
    int bytesLen = bytes.length;
    if (bytesLen == 0) return result.toString();

    int pos_input = 0;
    int pos_end = PointerUtils.Offset(pos_input, bytesLen);
    int b;
    while (pos_input != pos_end) {
      b = bytes[pos_input];
      result.write(alphabet[Bits.Asr32(b, 4)]);
      result.write(alphabet[b & 0x0F]);
      pos_input++;
    }

    return result.toString();
  }

  /// Encode to Base16 representation using uppercase lettering
  String EncodeUpper(List<int> bytes) {
    return _Encode(bytes, _UpperAlphabet);
  }

  /// Encode to Base16 representation using lowercase lettering
  String EncodeLower(List<int> bytes) {
    return _Encode(bytes, _LowerAlphabet);
  }

  List<int> Decode(String text) {
    List<int> result = [];
    int textLen = text.length;
    if (textLen == 0) return result;

    if (textLen % 2 != 0) {
      throw new InvalidArgumentBaseEncodingException(_InvalidTextLength);
    }

    int pos_input = 0;
    int pos_end = PointerUtils.Offset(pos_input, textLen);
    var new_text = text.codeUnits;
    int b1, b2, c1, c2;
    while (pos_input != pos_end) {
      c1 = new_text[pos_input];
      pos_input++;
      _ValidateHex(c1);
      b1 = _GetHexByte(c1);
      c2 = new_text[pos_input];
      pos_input++;
      _ValidateHex(c2);
      b2 = _GetHexByte(c2);
      result.add(BigInt.from(b1 << 4 | b2).toUnsigned(8).toInt());
    }

    return result;
  }
}
