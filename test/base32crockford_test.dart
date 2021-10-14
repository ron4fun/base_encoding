import 'package:test/test.dart';
import 'package:base_encoding/base_encoding.dart';

void main() {
    group('Base32Crockford Tests', () {

        List<String> RawData = ["", "f", "fo", "foo", "foob",
            "fooba", "foobar", "1234567890123456789012345678901234567890"
        ];

        List<String> EncodedData = ["", "CR", "CSQG", "CSQPY",
            "CSQPYRG", "CSQPYRK1", "CSQPYRK1E8",
            "64S36D1N6RVKGE9G64S36D1N6RVKGE9G64S36D1N6RVKGE9G64S36D1N6RVKGE9G"
        ];

        List<String> SpecialRaw = ["000", "111", "111"];
        List<String> SpecialEncoded = ["O0o", "Ll1", "I1i"];

        final base32 = BaseEncoding.CreateBase32Crockford();

        test('Test_Decode_CrockfordChars_DecodedCorrectly', () {
            List<int> result, expected_result;

            for (int i = 0; i < SpecialRaw.length; i++)
            {
                expected_result = base32.Decode(SpecialRaw[i]);
                result = base32.Decode(SpecialEncoded[i]);
                expect(expected_result, equals(result));
            }

        });

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
                result = base32.Encode(bytes, false);
                expect(EncodedData[i], equals(result));
            }

        });

    });
}
