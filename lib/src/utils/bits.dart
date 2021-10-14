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

class Bits {
  static void ReverseByteArray(List<int> src, List<int> dest, int size) {
    int src_pos = 0;
    int dest_pos = size - 1;
    while (size > 0) {
      dest[dest_pos] = src[src_pos];
      src_pos++;
      dest_pos++;
      size--;
    } // end while
  } // end function ReverseByteArray

  static int ReverseBytesInt32(int value) {
    int i1 = value & 0xFF;
    int i2 = Bits.Asr32(value, 8) & 0xFF;
    int i3 = Bits.Asr32(value, 16) & 0xFF;
    int i4 = Bits.Asr32(value, 24) & 0xFF;

    return BigInt.from((i1 << 24) | (i2 << 16) | (i3 << 8) | (i4 << 0))
        .toSigned(32)
        .toInt();
  } // end function ReverseBytesInt32

  static int ReverseBitsUInt8(int value) {
    int result = ((value >> 1) & 0x55) | ((value << 1) & 0xAA);
    result = ((result >> 2) & 0x33) | ((result << 2) & 0xCC);
    return BigInt.from(((result >> 4) & 0x0F) | ((result << 4) & 0xF0))
        .toUnsigned(8)
        .toInt();
  } // end function ReverseBitsUInt8

  static int ReverseBytesUInt16(int value) {
    return BigInt.from(((value & 0xFF) << 8 | (value & 0xFF00) >> 8))
        .toUnsigned(16)
        .toInt();
  } // end function ReverseBytesUInt16

  static int ReverseBytesUInt32(int value) {
    return BigInt.from((value & 0x000000FF) << 24 |
            (value & 0x0000FF00) << 8 |
            (value & 0x00FF0000) >> 8 |
            (value & 0xFF000000) >> 24)
        .toUnsigned(32)
        .toInt();
  } // end function ReverseBytesUInt32

  static int ReverseBytesUInt64(int value) {
    return BigInt.from((value & 0x00000000000000FF) << 56 |
            (value & 0x000000000000FF00) << 40 |
            (value & 0x0000000000FF0000) << 24 |
            (value & 0x00000000FF000000) << 8 |
            (value & 0x000000FF00000000) >> 8 |
            (value & 0x0000FF0000000000) >> 24 |
            (value & 0x00FF000000000000) >> 40 |
            (value & 0xFF00000000000000) >> 56)
        .toUnsigned(64)
        .toInt();
  } // end function ReverseBytesUInt64

  static int Asr32(int value, int ShiftBits) {
    int result = value >> ShiftBits;
    if ((value & 0x80000000) > 0) {
      // if you don't want to cast (0xFFFFFFFF) to an Int32,
      // simply replace it with (-1) to avoid range check error.
      result = result | ((-1) << (32 - ShiftBits));
    } // end if

    return BigInt.from(result).toSigned(32).toInt();
  } // end function Asr32

  static int Asr64(int value, int ShiftBits) {
    int result = value >> ShiftBits;
    if ((value & 0x8000000000000000) > 0) {
      result = result | (0xFFFFFFFFFFFFFFFF << (64 - ShiftBits));
    } // end if

    return BigInt.from(result).toSigned(64).toInt();
  } // end function Asr64

  static int RotateLeft32(int a_value, int a_n) {
    a_n = a_n & 31;
    return BigInt.from((a_value << a_n) | (a_value >> (32 - a_n)))
        .toUnsigned(32)
        .toInt();
  } // end function RotateLeft32

  static int RotateLeft64(int a_value, int a_n) {
    a_n = a_n & 63;
    return BigInt.from((a_value << a_n) | (a_value >> (64 - a_n)))
        .toUnsigned(64)
        .toInt();
  } // end function RotateLeft64

  static int RotateRight32(int a_value, int a_n) {
    a_n = a_n & 31;
    return BigInt.from((a_value >> a_n) | (a_value << (32 - a_n)))
        .toUnsigned(32)
        .toInt();
  } // end function RotateRight32

  static int RotateRight64(int a_value, int a_n) {
    a_n = a_n & 63;
    return BigInt.from((a_value >> a_n) | (a_value << (64 - a_n)))
        .toUnsigned(64)
        .toInt();
  } // end function RotateRight64

} // end class Bits
