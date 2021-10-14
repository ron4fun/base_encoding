import 'package:test/test.dart';
import 'package:base_encoding/base_encoding.dart';

void main() {
    group('Base58 Tests', () {

        List<String> RawDataInHex = ["", "0000010203",
        "009C1CA2CBA6422D3988C735BB82B5C880B0441856B9B0910F",
        "000860C220EBBAF591D40F51994C4E2D9C9D88168C33E761F6",
        "00313E1F905554E7AE2580CD36F86D0C8088382C9E1951C44D010203", "0000000000",
        "1111111111", "FFEEDDCCBBAA", "00", "21",
        // Test cases from https://gist.github.com/CodesInChaos/3175971
        "00000001", "61", "626262", "636363",
        "73696D706C792061206C6F6E6720737472696E67",
        "00EB15231DFCEB60925886B67D065299925915AEB172C06647", "516B6FCD0F",
        "BF4F89001E670274DD", "572E4794", "ECAC89CAD93923C02321", "10C8511E",
        "00000000000000000000"
        ];

        List<String> Base58EncodedData = ["", "11Ldp",
        "1FESiat4YpNeoYhW3Lp7sW1T6WydcW7vcE", "1mJKRNca45GU2JQuHZqZjHFNktaqAs7gh",
        "17f1hgANcLE5bQhAGRgnBaLTTs23rK4VGVKuFQ", "11111", "2vgLdhi",
        "3CSwN61PP", "1", "a",
        // Test cases from https://gist.github.com/CodesInChaos/3175971
        "1112", "2g", "a3gV", "aPEr", "2cFupjhnEsSn59qHXstmK2ffpLv2",
        "1NS17iag9jJgTHD1VXjvLCEnZuQ3rJDE9L", "ABnLTmg", "3SEo3LWLoPntC", "3EFU7m",
        "EJDM8drfXA6uyA", "Rt5zm", "1111111111"
        ];

        final base16 = BaseEncoding.CreateBase16();
        final base58 = BaseEncoding.CreateBase58BitCoin();

        test('Test_Constructor_Null_Alphabet_Raise', () {
            expect(() => BaseEncoding.CreateBase58(null),
                throwsA(predicate((e) => e is ArgumentNullBaseEncodingException)));
        });

        test('Test_Decode_Empty_String_Returns_Empty_Buffer', () {
            expect(0, equals(base58.Decode("").length));
        });

        test('Test_Encode_Empty_Buffer_Returns_Empty_String', () {
            expect("", equals(base58.Encode([])));
        });

        test('Test_Decode_Bitcoin_Returns_Expected_Results', () {
            List<int> buffer;
            String result;

            for (int i = 0; i < RawDataInHex.length; i++)
            {
                buffer = base58.Decode(Base58EncodedData[i]);
                result = base16.EncodeUpper(buffer);
                expect(RawDataInHex[i], equals(result));
            }
        });

        test('Test_Encode_Bitcoin_Returns_Expected_Results', () {
            String result;
            List<int> buffer;

            for (int i = 0; i < RawDataInHex.length; i++)
            {
                buffer = base16.Decode(RawDataInHex[i]);
                result = base58.Encode(buffer);
                expect(Base58EncodedData[i], equals(result));
            }

        });

    });
}
