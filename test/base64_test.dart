import 'package:test/test.dart';
import 'package:base_encoding/base_encoding.dart';

void main() {
    group('Base64 Tests', () {

        List<String> RawData = ["", "f", "fo", "foo", "foob",
        "fooba", "foobar", "1234567890123456789012345678901234567890"
        ];

        List<String> EncodedDataBase64Default = ["", "Zg==", "Zm8=", "Zm9v",
        "Zm9vYg==", "Zm9vYmE=", "Zm9vYmFy",
        "MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTIzNDU2Nzg5MA=="
        ];

        test('Test_Decode_DefaultNoPadding_ReturnsExpectedValues', () {
            List<int> bytes;
            String result;

            final base64 = BaseEncoding.CreateBase64DefaultNoPadding();

            for (int i = 0; i < EncodedDataBase64Default.length; i++)
            {
                bytes = base64.Decode(EncodedDataBase64Default[i].replaceAll('=', ''));
                result = String.fromCharCodes(bytes);
                expect(RawData[i], equals(result));
            }

        });

        test('Test_Decode_Default_ReturnsExpectedValues', () {
            List<int> bytes;
            String result;

            final base64 = BaseEncoding.CreateBase64Default();

            for (int i = 0; i < EncodedDataBase64Default.length; i++)
            {
                bytes = base64.Decode(EncodedDataBase64Default[i]);
                result = String.fromCharCodes(bytes);
                expect(RawData[i], equals(result));
            }

        });

        test('Test_Dog_Food_Default', () {
            List<int> bytes;

            final base64 = BaseEncoding.CreateBase64Default();

            for (int i = 0; i < RawData.length; i++)
            {
                bytes = RawData[i].codeUnits;
                expect(base64.Decode(base64.Encode(bytes)), equals(bytes));
            }

        });

        test('Test_Dog_Food_DefaultNoPadding', () {
            List<int> bytes;

            final base64 = BaseEncoding.CreateBase64DefaultNoPadding();

            for (int i = 0; i < RawData.length; i++)
            {
                bytes = RawData[i].codeUnits;
                expect(base64.Decode(base64.Encode(bytes)), equals(bytes));
            }

        });

        test('Test_Dog_Food_FileEncoding', () {
            List<int> bytes;

            final base64 = BaseEncoding.CreateBase64FileEncoding();

            for (int i = 0; i < RawData.length; i++)
            {
                bytes = RawData[i].codeUnits;
                expect(base64.Decode(base64.Encode(bytes)), equals(bytes));
            }

        });

        test('Test_Dog_Food_RegExEncoding', () {
            List<int> bytes;

            final base64 = BaseEncoding.CreateBase64RegExEncoding();

            for (int i = 0; i < RawData.length; i++)
            {
                bytes = RawData[i].codeUnits;
                expect(base64.Decode(base64.Encode(bytes)), equals(bytes));
            }

        });

        test('Test_Dog_Food_UrlEncoding', () {
            List<int> bytes;

            final base64 = BaseEncoding.CreateBase64UrlEncoding();

            for (int i = 0; i < RawData.length; i++)
            {
                bytes = RawData[i].codeUnits;
                expect(base64.Decode(base64.Encode(bytes)), equals(bytes));
            }

        });

        test('Test_Dog_Food_XmlEncoding', () {
            List<int> bytes;

            final base64 = BaseEncoding.CreateBase64XmlEncoding();

            for (int i = 0; i < RawData.length; i++)
            {
                bytes = RawData[i].codeUnits;
                expect(base64.Decode(base64.Encode(bytes)), equals(bytes));
            }

        });

        test('Test_Encode_DefaultNoPadding_ReturnsExpectedValues', () {
            List<int> bytes;
            String result, temp;

            final base64 = BaseEncoding.CreateBase64DefaultNoPadding();

            for (int i = 0; i < RawData.length; i++)
            {
                bytes = RawData[i].codeUnits;
                result = base64.Encode(bytes);
                temp = EncodedDataBase64Default[i].replaceAll('=', '');

                expect(temp, equals(result));
            }

        });

        test('Test_Encode_Default_ReturnsExpectedValues', () {
            List<int> bytes;
            String result;

            final base64 = BaseEncoding.CreateBase64Default();

            for (int i = 0; i < RawData.length; i++)
            {
                bytes = RawData[i].codeUnits;
                result = base64.Encode(bytes);
                expect(EncodedDataBase64Default[i], equals(result));
            }

        });

    });
}
