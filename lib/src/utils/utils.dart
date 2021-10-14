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

class Utils {
  static String TrimRight(String S, List<String> trim_chars) {
    int len = S.length;
    int i = len - 1;

    while (i >= 0 && trim_chars.contains(S[i])) {
      i--;
    }

    if (i < 0)
      return "";
    else if (i == len) return S;

    return S.substring(0, i + 1);
  }

  static String ConvertByteArrayToHexString(List<int> arr,
      {bool upperCase = true}) {
    String result;
    StringBuffer stream = new StringBuffer();
    int temp;

    for (var i = 0; i < arr.length; i++) {
      temp = arr[i];
      stream.write(BigInt.from(temp).toRadixString(16));
    }

    return upperCase ? stream.toString().toUpperCase() : stream.toString();
  }

  static String ConvertByteArrayToASCIIString(List<int> arr,
      {bool upperCase = true}) {
    final result = String.fromCharCodes(arr);
    return upperCase ? result.toUpperCase() : result.toLowerCase();
  }

  static List<int> ConvertASCIIStringToByteArray(String s) {
    return s.codeUnits;
  }
}

class PointerUtils {
  static final _BufferOverFlow = "Buffer overflow -- buffer too large?";

  static int Offset(int pos, int length) {
    int result = pos + length;
    if ((length < 0) || (result < pos))
      throw new InvalidOperationBaseEncodingException(_BufferOverFlow);

    return result;
  }
}
