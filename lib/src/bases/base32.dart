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

import "base32Alphabet.dart";

class Base32 {
  static final _AlphabetNull = "Alphabet instance cannot be null";
  static final _InvalidCharacter = "Invalid character value in input: 0x";
  static final _BitsPerByte = 8;
  static final _BitsPerChar = 5;
  static final _PaddingChar = '=';

  static void _InvalidInput(String c) {
    throw new InvalidArgumentBaseEncodingException(_InvalidCharacter + c);
  }

  Base32Alphabet _Alphabet = null;

  Base32(Base32Alphabet alphabet) {
    if (alphabet == null)
      throw new ArgumentNullBaseEncodingException(_AlphabetNull);

    _Alphabet = alphabet;
  }

  String Encode(List<int> bytes, bool padding) {
    int bytesLen, outputLen, bitsLeft, currentByte, outputPad, nextBits;
    List<String> encodingTable;

    bytesLen = bytes.length;
    if (bytesLen == 0) return "";

    StringBuffer outputBuffer = new StringBuffer();

    encodingTable = _Alphabet.GetEncodingTable();

    outputLen = (((bytesLen - 1) ~/ _BitsPerChar) + 1) * _BitsPerByte;

    int pos_output = 0;
    int pos_output_end = outputLen;
    int pos_input = 0;

    bitsLeft = _BitsPerByte;
    currentByte = BigInt.from(bytes[pos_input]).toUnsigned(8).toInt();
    int pos_end = PointerUtils.Offset(pos_input, bytesLen);
    while (pos_input != pos_end) {
      if (bitsLeft > _BitsPerChar) {
        bitsLeft = bitsLeft - _BitsPerChar;
        outputPad = Bits.Asr32(currentByte, bitsLeft);
        outputBuffer.write(encodingTable[outputPad]);
        pos_output++;
        currentByte = currentByte & ((1 << bitsLeft) - 1);
      }

      nextBits = _BitsPerChar - bitsLeft;
      bitsLeft = _BitsPerByte - nextBits;
      outputPad = currentByte << nextBits;
      pos_input++;
      if (pos_input != pos_end) {
        currentByte = BigInt.from(bytes[pos_input]).toUnsigned(8).toInt();
        outputPad = outputPad | Bits.Asr32(currentByte, bitsLeft);
        currentByte = currentByte & ((1 << bitsLeft) - 1);
      }

      outputBuffer.write(encodingTable[outputPad]);
      pos_output++;
    }

    if (padding) {
      while (pos_output != pos_output_end) {
        outputBuffer.write(_PaddingChar);
        pos_output++;
      }
    }

    return outputBuffer.toString();
  }

  List<int> Decode(String text) {
    int textLen, decodingTableLen, bitsLeft, outputPad, b, shiftBits;
    List<int> decodingTable;

    String c;
    String trimmed;

    List<int> result = [];
    trimmed = Utils.TrimRight(text, [_PaddingChar]);
    textLen = trimmed.length;

    if (textLen == 0) return result;

    decodingTable = _Alphabet.GetDecodingTable();
    decodingTableLen = decodingTable.length;
    bitsLeft = _BitsPerByte;

    outputPad = 0;

    int pos_input = 0;
    int pos_end = PointerUtils.Offset(pos_input, textLen);

    while (pos_input != pos_end) {
      c = trimmed[pos_input];

      var c_pos = c.codeUnitAt(0);

      if (c_pos >= decodingTableLen) _InvalidInput(c);

      b = decodingTable[c_pos] - 1;
      if (b < 0) _InvalidInput(c);

      pos_input++;

      if (bitsLeft > _BitsPerChar) {
        bitsLeft = bitsLeft - _BitsPerChar;
        outputPad = outputPad | (b << bitsLeft);
        continue;
      }

      shiftBits = _BitsPerChar - bitsLeft;
      outputPad = outputPad | (Bits.Asr32(b, shiftBits));
      result.add(BigInt.from(outputPad).toUnsigned(8).toInt());

      b = b & ((1 << shiftBits) - 1);
      bitsLeft = _BitsPerByte - shiftBits;
      outputPad = b << bitsLeft;
    }

    return result;
  }
}
