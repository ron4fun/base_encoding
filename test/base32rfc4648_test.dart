import 'package:test/test.dart';
import 'package:base_encoding/base_encoding.dart';

void main() {
    group('Base32ExtendedHex Tests', () {

        List<String> RawData = ["", "f", "fo", "foo", "foob",
            "fooba", "foobar", "foobar1", "foobar12", "foobar123", "1234567890123456789012345678901234567890"
        ];

        List<String> EncodedData = ["", "MY======", "MZXQ====",
            "MZXW6===", "MZXW6YQ=", "MZXW6YTB", "MZXW6YTBOI======", "MZXW6YTBOIYQ====",
            "MZXW6YTBOIYTE===", "MZXW6YTBOIYTEMY=",
            "GEZDGNBVGY3TQOJQGEZDGNBVGY3TQOJQGEZDGNBVGY3TQOJQGEZDGNBVGY3TQOJQ"
        ];

        final base32 = BaseEncoding.CreateBase32Rfc4648();

        test('Test_Decode_InvalidInput_ThrowsInvalidArgumentException', () {
            expect(() => base32.Decode("[];',m."),
                throwsA(predicate((e) => e is InvalidArgumentBaseEncodingException)));
        });

        test('Test_Decode_ReturnsExpectedValues', () {
            String result;
            List<int> bytes;

            for (int i = 0; i < EncodedData.length; i++)
            {
                bytes = base32.Decode(EncodedData[i]);
                result = String.fromCharCodes(bytes);
                expect(RawData[i], equals(result));

                bytes = base32.Decode(EncodedData[i].toLowerCase());
                result = String.fromCharCodes(bytes);
                expect(RawData[i], equals(result));
            }

        });

        test('Test_Encode_ReturnsExpectedValues', () {
            String result;
            List<int> bytes;

            for (int i = 0; i < RawData.length; i++)
            {
                bytes = RawData[i].codeUnits;
                result = base32.Encode(bytes, true);
                expect(EncodedData[i], equals(result));
            }

        });

    });
}
