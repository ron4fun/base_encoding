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

class Base32Alphabet {
  List<String> _EncodingTable = new List();
  List<int> _DecodingTable = new List();

  static final _HighestAsciiCharSupported = 122;

  static Base32Alphabet _Crockford = new CrockfordBase32Alphabet();
  static Base32Alphabet _Rfc4648 =
      new Base32Alphabet("ABCDEFGHIJKLMNOPQRSTUVWXYZ234567");
  static Base32Alphabet _ExtendedHex =
      new Base32Alphabet("0123456789ABCDEFGHIJKLMNOPQRSTUV");

  void _CreateDecodingTable(String chars) {
    List<int> bytes = List.generate(_HighestAsciiCharSupported + 1, (e) => 0);
    String c;
    int b;

    for (int i = 0; i < chars.length; i++) {
      c = chars[i];
      b = BigInt.from(i + 1).toUnsigned(8).toInt();
      bytes[c.codeUnitAt(0)] = b;
      bytes[c.toLowerCase().codeUnitAt(0)] = b;
    }

    _DecodingTable = bytes;
  }

  Base32Alphabet(String chars) {
    for (int i = 0; i < chars.length; i++) {
      _EncodingTable.add(chars[i]);
    }

    _CreateDecodingTable(chars);
  }

  List<String> GetEncodingTable() => [..._EncodingTable];

  List<int> GetDecodingTable() => [..._DecodingTable];

  static Base32Alphabet GetCrockford() => _Crockford;

  static Base32Alphabet GetRfc4648() => _Rfc4648;

  static Base32Alphabet GetExtendedHex() => _ExtendedHex;
}

class CrockfordBase32Alphabet extends Base32Alphabet {
  CrockfordBase32Alphabet() : super("0123456789ABCDEFGHJKMNPQRSTVWXYZ") {
    _Map(_DecodingTable, 'O', '0');
    _Map(_DecodingTable, 'I', '1');
    _Map(_DecodingTable, 'L', '1');
  }

  static void _Map(List<int> buffer, String source, String destination) {
    int result =
        BigInt.from(buffer[destination.codeUnitAt(0)]).toUnsigned(8).toInt();

    buffer[source.codeUnitAt(0)] = result;
    buffer[source.toLowerCase().codeUnitAt(0)] = result;
  }
}
