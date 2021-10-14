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

import "base64Alphabet.dart";

class Base64 {
  static final _PaddingChar = '=';

  Base64Alphabet _Alphabet = null;

  static final AlphabetNull = "Alphabet Instance cannot be null";

  /// Returns decoded value and new pos
  static int Process(
      List<String> input, int pos_input, List<int> decode_table) {
    String c = input[pos_input];
    return decode_table[c.codeUnitAt(0)];
  }

  Base64(Base64Alphabet alphabet) {
    if (alphabet == null) {
      throw new ArgumentNullBaseEncodingException(AlphabetNull);
    }

    _Alphabet = alphabet;
  }

  String Encode(List<int> bytes) {
    int bytesLen, padding, blocks;
    int b1, b2, b3;
    List<String> output, EncodingTable;
    bool pad2, pad1;

    bytesLen = bytes.length;
    if (bytesLen == 0) return "";

    EncodingTable = _Alphabet.GetEncodingTable();

    padding = bytesLen % 3;
    if (padding > 0) {
      padding = 3 - padding;
    }

    blocks = (bytesLen - 1) ~/ 3 + 1;

    int l = blocks * 4;

    output = new List(l);

    int i = 1;
    int pos_input = 0;
    int pos_output = 0;
    while (i < blocks) {
      b1 = bytes[pos_input];
      pos_input++;
      b2 = bytes[pos_input];
      pos_input++;
      b3 = bytes[pos_input];
      pos_input++;

      output[pos_output] = EncodingTable[Bits.Asr32((b1 & 0xFC), 2)];
      pos_output++;
      output[pos_output] =
          EncodingTable[Bits.Asr32((b2 & 0xF0), 4) | (b1 & 0x03) << 4];
      pos_output++;
      output[pos_output] =
          EncodingTable[Bits.Asr32((b3 & 0xC0), 6) | (b2 & 0x0F) << 2];
      pos_output++;
      output[pos_output] = EncodingTable[b3 & 0x3F];
      pos_output++;

      i++;
    }

    pad2 = padding == 2;
    pad1 = padding > 0;

    b1 = bytes[pos_input];
    pos_input++;
    if (pad2) {
      b2 = 0;
    } else {
      b2 = bytes[pos_input];
      pos_input++;
    }

    if (pad1) {
      b3 = 0;
    } else {
      b3 = bytes[pos_input];
      pos_input++;
    }

    output[pos_output] = EncodingTable[Bits.Asr32((b1 & 0xFC), 2)];
    pos_output++;
    output[pos_output] =
        EncodingTable[Bits.Asr32((b2 & 0xF0), 4) | (b1 & 0x03) << 4];
    pos_output++;
    if (pad2) {
      output[pos_output] = '=';
    } else {
      output[pos_output] =
          EncodingTable[Bits.Asr32((b3 & 0xC0), 6) | (b2 & 0x0F) << 2];
    }

    pos_output++;

    if (pad1) {
      output[pos_output] = '=';
    } else {
      output[pos_output] = EncodingTable[b3 & 0x3F];
    }

    pos_output++;

    if (!_Alphabet.GetPaddingEnabled()) {
      if (pad2) {
        l--;
      }
      if (pad1) {
        l--;
      }

      output = output.sublist(0, l);
    }

    StringBuffer result = new StringBuffer();
    output.forEach((e) => result.write(e));

    return result.toString();
  }

  List<int> Decode(String text) {
    int textLen, blocks, bytes, padding;
    int temp1, temp2;
    List<int> output, DecodingTable;

    textLen = text.length;
    if (textLen == 0) return [];

    List<String> tempArray = new List(textLen);

    for (int i = 0; i < textLen; i++) {
      tempArray[i] = text[i];
    }

    DecodingTable = _Alphabet.GetDecodingTable();

    blocks = (textLen - 1) ~/ 4 + 1;
    bytes = blocks * 3;

    padding = blocks * 4 - textLen;

    if ((textLen > 2) && (tempArray[textLen - 2] == _PaddingChar)) {
      padding = 2;
    } else if ((textLen > 1) && (tempArray[textLen - 1] == _PaddingChar)) {
      padding = 1;
    }

    output = new List(bytes - padding);

    int i = 1;
    int pos_temp = 0;
    int pos_output = 0;
    while (i < blocks) {
      temp1 = Process(tempArray, pos_temp, DecodingTable);
      pos_temp++;
      temp2 = Process(tempArray, pos_temp, DecodingTable);
      pos_temp++;

      output[pos_output] =
          BigInt.from(((temp1 << 2) | (Bits.Asr32(temp2 & 0x30, 4))))
              .toUnsigned(8)
              .toInt();
      pos_output++;

      temp1 = Process(tempArray, pos_temp, DecodingTable);
      pos_temp++;

      output[pos_output] =
          BigInt.from(((Bits.Asr32(temp1 & 0x3C, 2)) | ((temp2 & 0x0F) << 4)))
              .toUnsigned(8)
              .toInt();
      pos_output++;

      temp2 = Process(tempArray, pos_temp, DecodingTable);
      pos_temp++;

      output[pos_output] =
          BigInt.from((((temp1 & 0x03) << 6) | temp2)).toUnsigned(8).toInt();
      pos_output++;

      i++;
    }

    temp1 = Process(tempArray, pos_temp, DecodingTable);
    pos_temp++;
    temp2 = Process(tempArray, pos_temp, DecodingTable);
    pos_temp++;

    output[pos_output] =
        BigInt.from(((temp1 << 2) | (Bits.Asr32(temp2 & 0x30, 4))))
            .toUnsigned(8)
            .toInt();
    pos_output++;

    if (padding != 2) {
      temp1 = Process(tempArray, pos_temp, DecodingTable);
      pos_temp++;

      output[pos_output] =
          BigInt.from(((Bits.Asr32(temp1 & 0x3C, 2) | ((temp2 & 0x0F) << 4))))
              .toUnsigned(8)
              .toInt();
      pos_output++;
    }

    if (padding == 0) {
      temp2 = Process(tempArray, pos_temp, DecodingTable);
      pos_temp++;

      output[pos_output] =
          BigInt.from((((temp1 & 0x03) << 6) | temp2)).toUnsigned(8).toInt();
      pos_output++;
    }

    return output;
  }
}
