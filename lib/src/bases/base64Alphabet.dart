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

class Base64Alphabet {
  bool _PaddingEnabled;
  List<String> _EncodingTable;
  List<int> _DecodingTable;

  static final _B64CharacterSet =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  static Base64Alphabet _Default =
      new Base64Alphabet(_B64CharacterSet, '+', '/', true);
  static Base64Alphabet _DefaultNoPadding =
      new Base64Alphabet(_B64CharacterSet, '+', '/', false);
  static Base64Alphabet _UrlEncoding =
      new Base64Alphabet(_B64CharacterSet, '-', '_', false);
  static Base64Alphabet _XmlEncoding =
      new Base64Alphabet(_B64CharacterSet, '_', ':', false);
  static Base64Alphabet _RegExEncoding =
      new Base64Alphabet(_B64CharacterSet, '!', '-', false);
  static Base64Alphabet _FileEncoding =
      new Base64Alphabet(_B64CharacterSet, '+', '-', false);

  void _CreateDecodingTable(List<String> chars) {
    List<int> bytes = List.generate(123, (e) => 0);

    for (int i = 0; i < chars.length; i++) {
      bytes[chars[i].codeUnitAt(0)] = i;
    }

    _DecodingTable = bytes;
  }

  Base64Alphabet(
      String chars, String plusChar, String slashChar, bool paddingEnabled) {
    String newChars = chars + plusChar + slashChar;

    _EncodingTable = new List(newChars.length);

    for (int i = 0; i < _EncodingTable.length; i++) {
      _EncodingTable[i] = newChars[i];
    }

    _PaddingEnabled = paddingEnabled;
    _CreateDecodingTable(_EncodingTable);
  }

  static Base64Alphabet GetDefault() => _Default;

  static Base64Alphabet GetDefaultNoPadding() => _DefaultNoPadding;

  static Base64Alphabet GetFileEncoding() => _FileEncoding;

  static Base64Alphabet GetRegExEncoding() => _RegExEncoding;

  static Base64Alphabet GetUrlEncoding() => _UrlEncoding;

  static Base64Alphabet GetXmlEncoding() => _XmlEncoding;

  bool GetPaddingEnabled() => _PaddingEnabled;

  List<String> GetEncodingTable() => [..._EncodingTable];

  List<int> GetDecodingTable() => [..._DecodingTable];
}
