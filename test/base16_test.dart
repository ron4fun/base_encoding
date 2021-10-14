import 'package:test/test.dart';
import 'package:base_encoding/base_encoding.dart';

void main() {
    group('Base16 Tests', () {

        List<List<int>> testDataBytes = [
            [],
            [0xAB],
            [0x00, 0x01, 0x02, 0x03],
            [0x10, 0x11, 0x12, 0x13],
            [0xAB, 0xCD, 0xEF, 0xBA]
        ];

        List<String> testDataString = [
        "", "AB", "00010203", "10111213", "ABCDEFBA"
        ];

        final base16 = BaseEncoding.CreateBase16();

        test('Test_Decode_Invalid_Char_Raise', () {
            expect(() => base16.Decode("AZ12"),
                throwsA(predicate((e) => e is InvalidOperationBaseEncodingException)));

            expect(() => base16.Decode("ZAAA"),
                throwsA(predicate((e) => e is InvalidOperationBaseEncodingException)));
        });

        test('Test_Decode_Invalid_Length_Raise', () {
            expect(() => base16.Decode("12345"),
                throwsA(predicate((e) => e is InvalidArgumentBaseEncodingException)));

            expect(() => base16.Decode("ABC"),
                throwsA(predicate((e) => e is InvalidArgumentBaseEncodingException)));
        });

        test('Test_Decode_LowerCase', () {
            List<int> result;

            for (int i = 0; i < testDataBytes.length; i++)
            {
                result = base16.Decode(testDataString[i]);
                expect(testDataBytes[i], equals(result));
            }
        });

        test('Test_Encode_Lower', () {
            String result;

            for (int i = 0; i < testDataBytes.length; i++)
            {
                result = base16.EncodeLower(testDataBytes[i]);
                expect(testDataString[i].toLowerCase(), equals(result));
            }
        });

        test('Test_Encode_Upper', () {
            String result;

            for (int i = 0; i < testDataBytes.length; i++)
            {
                result = base16.EncodeUpper(testDataBytes[i]);
                expect(testDataString[i], equals(result));
            }
        });

    });
}
