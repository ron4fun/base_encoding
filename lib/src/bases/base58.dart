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
import '../utils/utils.dart';

import "base58Alphabet.dart";

class Base58 {
  Base58Alphabet _Alphabet = null;

  static final AlphabetNull = "Alphabet instance cannot be null";

  Base58(Base58Alphabet alphabet) {
    if (alphabet == null)
      throw new ArgumentNullBaseEncodingException(AlphabetNull);

    _Alphabet = alphabet;
  }

  String Encode(List<int> bytes) {
    final growthPercentage = 138;
    int bytesLen, outputLen, carry;

    StringBuffer result = new StringBuffer();

    bytesLen = bytes.length;
    if (bytesLen == 0) return result.toString();

    String value = _Alphabet.GetValue();

    int pos_input = 0;
    int pos_end = PointerUtils.Offset(pos_input, bytesLen);
    while ((pos_input != pos_end) && (bytes[pos_input] == 0)) {
      pos_input++;
    }

    int numZeroes = pos_input;
    String firstChar = value[0];

    if (pos_input == pos_end) {
      for (int i = 0; i < numZeroes; i++) {
        result.write(firstChar);
      }

      return result.toString();
    }

    outputLen = bytesLen * growthPercentage ~/ 100;

    int length = 0;
    List<int> output = List.generate(outputLen + 1, (i) => 0);
    int pos_output = 0;

    int pos_output_end = outputLen;
    int i, pos_digit;
    while (pos_input != pos_end) {
      carry = bytes[pos_input];
      i = 0;
      pos_digit = pos_output_end;
      while (((carry != 0) || (i < length)) && (pos_digit >= 0)) {
        carry = carry + (256 * output[pos_digit]);
        output[pos_digit] = BigInt.from(carry % 58).toUnsigned(8).toInt();
        carry = carry ~/ 58;
        pos_digit--;
        i++;
      }

      length = i;
      pos_input++;
    }

    pos_output_end++;
    while ((pos_output != pos_output_end) && (output[pos_output] == 0)) {
      pos_output++;
    }

    result.writeAll(List.generate(numZeroes, (e) => firstChar));

    while (pos_output != pos_output_end) {
      result.write(value[output[pos_output]]);
      pos_output++;
    }

    return result.toString();
  }

  List<int> Decode(String text) {
    final reductionFactor = 733;
    int textLen, numZeroes, outputLen, carry, resultLen;

    textLen = text.length;
    if (textLen == 0) return [];

    int pos_input = 0;
    int pos_end = PointerUtils.Offset(pos_input, textLen);

    String firstChar = _Alphabet.GetValue()[0];
    while ((pos_input != pos_end) && (text[pos_input] == firstChar)) {
      pos_input++;
    }

    numZeroes = pos_input;
    if (pos_input == pos_end) {
      return List.generate(numZeroes, (e) => 0);
    }

    outputLen = textLen * reductionFactor ~/ 1000 + 1;
    List<int> output = List.generate(outputLen, (e) => 0);

    int pos_output = 0;
    int pos_output_end = outputLen - 1;
    int pos_digit;
    while (pos_input != pos_end) {
      carry = _Alphabet.GetSelf(text[pos_input]);
      pos_input++;
      pos_digit = pos_output_end;
      while (pos_digit >= 0) {
        carry = carry + (58 * output[pos_digit]);
        output[pos_digit] = BigInt.from(carry).toUnsigned(8).toInt();
        carry = carry ~/ 256;
        pos_digit--;
      }
    }

    pos_output = 0;
    while ((pos_output != pos_output_end) && (output[pos_output] == 0)) {
      pos_output++;
    }

    resultLen = (pos_output_end - pos_output) + 1;
    if (resultLen == outputLen) {
      return output;
    }

    return List.generate(numZeroes, (e) => 0) +
        output.sublist(pos_output, pos_output + resultLen);
  }
}
