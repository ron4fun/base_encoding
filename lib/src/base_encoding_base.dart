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

import 'bases/base16.dart';
import 'bases/base32.dart';
import 'bases/base32Alphabet.dart';
import 'bases/base58.dart';
import 'bases/base58Alphabet.dart';
import 'bases/base64.dart';
import 'bases/base64Alphabet.dart';

class BaseEncoding
{
    // ================== Base16 =================
    static Base16 CreateBase16()
    => new Base16();

    // ================== Base32 =================
    static Base32 CreateBase32(Base32Alphabet alphabet)
    => new Base32(alphabet);

    static Base32 CreateBase32Crockford()
    => new Base32(Base32Alphabet.GetCrockford());

    static Base32 CreateBase32Rfc4648()
    => new Base32(Base32Alphabet.GetRfc4648());

    static Base32 CreateBase32ExtendedHex()
    => Base32(Base32Alphabet.GetExtendedHex());

    // ================== Base58 =================
    static Base58 CreateBase58(Base58Alphabet alphabet)
    => new Base58(alphabet);

    static Base58 CreateBase58BitCoin()
    => new Base58(Base58Alphabet.GetBitCoin());

    static Base58 CreateBase58Flickr()
    => new Base58(Base58Alphabet.GetFlickr());

    static Base58 CreateBase58Ripple()
    => new Base58(Base58Alphabet.GetRipple());

    // ================== Base64 =================
    static Base64 CreateBase64(Base64Alphabet alphabet)
    => new Base64(alphabet);

    static Base64 CreateBase64Default()
    => new Base64(Base64Alphabet.GetDefault());

    static Base64 CreateBase64DefaultNoPadding()
    => new Base64(Base64Alphabet.GetDefaultNoPadding());

    static Base64 CreateBase64FileEncoding()
    => new Base64(Base64Alphabet.GetFileEncoding());

    static Base64 CreateBase64RegExEncoding()
    => new Base64(Base64Alphabet.GetRegExEncoding());

    static Base64 CreateBase64UrlEncoding()
    => new Base64(Base64Alphabet.GetUrlEncoding());

    static Base64 CreateBase64XmlEncoding()
    => new Base64(Base64Alphabet.GetXmlEncoding());
}