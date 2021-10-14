import 'package:test/test.dart';
import 'package:base_encoding/base_encoding.dart';

void main() {
    group('Base32ExtendedHex Tests', () {

        List<String> RawData = ["", "f", "fo", "foo", "foob",
            "fooba", "foobar", "1234567890123456789012345678901234567890"
        ];

        List<String> EncodedData = ["", "CO======", "CPNG====", "CPNMU===",
            "CPNMUOG=", "CPNMUOJ1", "CPNMUOJ1E8======",
            "64P36D1L6ORJGE9G64P36D1L6ORJGE9G64P36D1L6ORJGE9G64P36D1L6ORJGE9G"
        ];

        final base32 = BaseEncoding.CreateBase32ExtendedHex();

        test('Test_Decode_InvalidInput_ThrowsInvalidArgumentException', () {
            expect(() => base32.Decode("!@#!#@!#@#!@"),
                throwsA(predicate((e) => e is InvalidArgumentBaseEncodingException)));

            expect(() => base32.Decode("||||"),
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
