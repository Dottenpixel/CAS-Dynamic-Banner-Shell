package com.brokenfunction.json {
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	import com.adobe.serialization.json.JSONDecoder;
	import com.adobe.serialization.json.JSONEncoder;

	import com.rational.serialization.json.JSON;

	public class TestJson extends Sprite {
		public function TestJson() {
			checkDecode("true");
			checkDecode("false");
			checkDecode("null");
			checkDecode("\"string\"");
			checkDecode("\"\"");
			checkDecode("\"\\\"\\\\\\/\\b\\f\\n\\r\\t\"", "\"\\\"\\\\/\\b\\f\\n\\r\\t\"");
			checkDecode("\"\\\"x\\\\x\\/x\\bx\\fx\\nx\\rx\\t\"", "\"\\\"x\\\\x/x\\bx\\fx\\nx\\rx\\t\"");
			checkDecode("\"test\\u0021unicode\"", "\"test!unicode\"");
			checkDecode("\"test\\u222Bunicode\\u222b\"", "\"test\u222Bunicode\u222b\"");
			checkDecode("\"test\\u00f7unicode\"", "\"test\u00f7unicode\"");
			checkDecode("\"\\u0021unicode\"", "\"\u0021unicode\"");
			checkDecode("\"unicode\\u0021\"", "\"unicode\u0021\"");
			checkDecode("123", "123", true);
			checkDecode("123e", "123", true);
			checkDecode("123e1", "1230", true);
			checkDecode("0.1", "0.1", true);
			checkDecode("123.1", "123.1", true);
			checkDecode("-123.1", "-123.1", true);
			checkDecode("123e1", "1230", true);
			checkDecode("123e+1", "1230", true);
			checkDecode("123e-1", "12.3", true);
			checkDecode("123E-1", "12.3", true);
			checkDecode("123e-001", "12.3", true);
			checkDecode("[]");
			checkDecode("[\"string\",null,true,false,1]");
			checkDecode("[\"test\\u0021\"]", "[\"test\u0021\"]");
			checkDecode("{}");
			checkDecode("{\"test\":{\"test\":{\"test\":\"sdfsdf\"}}}");
			checkDecode("{\"test\":\"sdfsdf\",\"test\":\"sdfsdf\"}", "{\"test\":\"sdfsdf\"}");
			checkDecode("[\"test\",43243,{\"test\":\"sdfsdf\"},4343]");
			checkDecode("[\"string\",null,true,false,1,{\"string\":\"string\"}]");
			checkDecodeMulti("{\"test\":\"sdfsdf\",\"test2\":\"sdfsdf\"}", [
				"{\"test\":\"sdfsdf\",\"test2\":\"sdfsdf\"}",
				"{\"test2\":\"sdfsdf\",\"test\":\"sdfsdf\"}"]);
			checkDecodeMulti("{\"a\":143,\"b\":232}", [
				"{\"a\":143,\"b\":232}","{\"b\":232,\"a\":143}"]);
			checkDecodeMulti("{\"a\":\"test\",\"b\":2}", [
				"{\"a\":\"test\",\"b\":2}","{\"b\":1,\"a\":\"test\"}"]);
			checkDecodeMulti("{\"a\":1,\"b\":\"test\"}", [
				"{\"a\":1,\"b\":\"test\"}","{\"b\":\"test\",\"a\":1}"]);
			checkDecodeMulti("{\"a\":234,\"c\":[1,2,3,242342298e10,-1235],\"d\":[{\"a\":\"test\",\"b\":\"test\"}]}",[
				"{\"d\":[{\"b\":\"test\",\"a\":\"test\"}],\"c\":[1,2,3,242342298e10,-1235],\"a\":234}"]);
			checkEncode(true);
			checkEncode(false);
			checkEncode(null);
			checkEncode("string");
			checkEncode("\"\\/\b\f\n\r\t");
			checkEncode("\u0021");
			checkEncode("\u222B");
			checkEncode("\u00f7");
			checkEncode("x\u222Bx");
			checkEncode(123);
			checkEncode(uint.MAX_VALUE);
			checkEncode(int.MIN_VALUE);
			checkEncode(Number.MAX_VALUE);
			checkEncode(Number.MIN_VALUE);
			checkEncode([]);
			checkEncode(["test"]);
			checkEncode([0, 1, 2]);
			checkEncode(["string",null,true,false,1,{"string":"string"}]);
			checkEncode({});
			checkEncode({"test": "test"});
			checkEncode({"a": 1, "b": 2, "c": 3});
			checkEncode({
				a: 234,
				c: [1, 2, 3, 242342298e10, -1235],
				d: [{a: "test", b: "test"}]
			});

			trace("All tests passed");

			testDecode(
				"true",
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) (new JSONDecoder(data)).getValue();},
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) decodeJson(data);},
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) (new JsonDecoderAsync(data)).result;},
				function (data:ByteArray):void {
					for (var i:int = 0; i < 30000; i++) decodeJson(data);},
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) JSON.decode(data);}
			);
			testDecode(
				"\"test string\"",
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) (new JSONDecoder(data)).getValue();},
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) decodeJson(data);},
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) (new JsonDecoderAsync(data)).result;},
				function (data:ByteArray):void {
					for (var i:int = 0; i < 30000; i++) decodeJson(data);},
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) JSON.decode(data);}
			);
			testDecode(
				"-123e5",
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) (new JSONDecoder(data)).getValue();},
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) decodeJson(data);},
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) (new JsonDecoderAsync(data)).result;},
				function (data:ByteArray):void {
					for (var i:int = 0; i < 30000; i++) decodeJson(data);},
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) JSON.decode(data);}
			);
			testDecode(
				"[1,2,3]",
				function (data:String):void {
					for (var i:int = 0; i < 10000; i++) (new JSONDecoder(data)).getValue();},
				function (data:String):void {
					for (var i:int = 0; i < 10000; i++) decodeJson(data);},
				function (data:String):void {
					for (var i:int = 0; i < 10000; i++) (new JsonDecoderAsync(data)).result;},
				function (data:ByteArray):void {
					for (var i:int = 0; i < 10000; i++) decodeJson(data);},
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) JSON.decode(data);}
			);
			testDecode(
				"{\"test\":\"sdfsdf\",\"test2\":\"sdfsdf\"}",
				function (data:String):void {
					for (var i:int = 0; i < 10000; i++) (new JSONDecoder(data)).getValue();},
				function (data:String):void {
					for (var i:int = 0; i < 10000; i++) decodeJson(data);},
				function (data:String):void {
					for (var i:int = 0; i < 10000; i++) (new JsonDecoderAsync(data)).result;},
				function (data:ByteArray):void {
					for (var i:int = 0; i < 10000; i++) decodeJson(data);},
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) JSON.decode(data);}
			);
			testDecode(
				encodeJson({
					a: 234,
					b: [{a: "x", b: "test string\r\ntest string"}],
					c: [1, 2, 3, 242342298e10, -1235],
					d: [
						{a: "test", b: "test"},{a: "test", b: "test"},
						{a: "test", b: "test"},{a: "test", b: "test"},
						{a: "test", b: "test"},{a: "test", b: "test"},
						{a: "test", b: "test"},{a: "test", b: "test"},
						{a: "test", b: "test"},{a: "test", b: "test"},
						{a: "test", b: "test"},{a: "test", b: "test"}]
				}),
				function (data:String):void {
					for (var i:int = 0; i < 1000; i++) (new JSONDecoder(data)).getValue();},
				function (data:String):void {
					for (var i:int = 0; i < 1000; i++) decodeJson(data);},
				function (data:String):void {
					for (var i:int = 0; i < 1000; i++) (new JsonDecoderAsync(data)).result;},
				function (data:ByteArray):void {
					for (var i:int = 0; i < 1000; i++) decodeJson(data);},
				function (data:String):void {
					for (var i:int = 0; i < 30000; i++) JSON.decode(data);}
			);
			testEncode(
				true,
				function (data:Object):void {
					for (var i:int = 0; i < 100000; i++) (new JSONEncoder(data)).getString();},
				function (data:Object):void {
					for (var i:int = 0; i < 100000; i++) encodeJson(data);},
				function (data:Object):void {
					for (var i:int = 0; i < 30000; i++) JSON.encode(data);}
			);
			testEncode(
				-123e4,
				function (data:Object):void {
					for (var i:int = 0; i < 100000; i++) (new JSONEncoder(data)).getString();},
				function (data:Object):void {
					for (var i:int = 0; i < 100000; i++) encodeJson(data);},
				function (data:Object):void {
					for (var i:int = 0; i < 30000; i++) JSON.encode(data);}
			);
			testEncode(
				"this is a string",
				function (data:Object):void {
					for (var i:int = 0; i < 100000; i++) (new JSONEncoder(data)).getString();},
				function (data:Object):void {
					for (var i:int = 0; i < 100000; i++) encodeJson(data);},
				function (data:Object):void {
					for (var i:int = 0; i < 30000; i++) JSON.encode(data);}
			);
			testEncode(
				"this is a much longer string to understand the effect the size of the string has on the results",
				function (data:Object):void {
					for (var i:int = 0; i < 10000; i++) (new JSONEncoder(data)).getString();},
				function (data:Object):void {
					for (var i:int = 0; i < 10000; i++) encodeJson(data);},
				function (data:Object):void {
					for (var i:int = 0; i < 30000; i++) JSON.encode(data);}
			);
			testEncode(
				[Number.MIN_VALUE, "test", null],
				function (data:Object):void {
					for (var i:int = 0; i < 10000; i++) (new JSONEncoder(data)).getString();},
				function (data:Object):void {
					for (var i:int = 0; i < 10000; i++) encodeJson(data);},
				function (data:Object):void {
					for (var i:int = 0; i < 30000; i++) JSON.encode(data);}
			);
			testEncode(
				{a:12345, b:null},
				function (data:Object):void {
					for (var i:int = 0; i < 30000; i++) (new JSONEncoder(data)).getString();},
				function (data:Object):void {
					for (var i:int = 0; i < 30000; i++) encodeJson(data);},
				function (data:Object):void {
					for (var i:int = 0; i < 30000; i++) JSON.encode(data);}
			);
			testEncode(
				{
					a: 234,
					b: [{a: "x", b: "test string\r\ntest string"}],
					c: [1, 2, 3, 242342298e10, -1235],
					d: [
						{a: "test", b: "test"},{a: "test", b: "test"},
						{a: "test", b: "test"},{a: "test", b: "test"},
						{a: "test", b: "test"},{a: "test", b: "test"},
						{a: "test", b: "test"},{a: "test", b: "test"},
						{a: "test", b: "test"},{a: "test", b: "test"},
						{a: "test", b: "test"},{a: "test", b: "test"}]
				},
				function (data:Object):void {
					for (var i:int = 0; i < 1000; i++) (new JSONEncoder(data)).getString();},
				function (data:Object):void {
					for (var i:int = 0; i < 1000; i++) encodeJson(data);},
				function (data:Object):void {
					for (var i:int = 0; i < 30000; i++) JSON.encode(data);}
			);
		}

		public function checkDecode(input:String, expectedResult:String = "", isNumber:Boolean = false):void {
			if (!expectedResult) {
				expectedResult = input;
			}
			checkDecode2(input, expectedResult, isNumber);

			// trailing characters should be ignored
			checkDecode3(input, "\"", expectedResult, isNumber);
			checkDecode3(input, "]", expectedResult, isNumber);
			checkDecode3(input, "}x8!", expectedResult, isNumber);

			// try combining it with something else
			checkDecode2("{\"test\":" + input + "}", "{\"test\":" + expectedResult + "}", false);
			checkDecode2("[[2],[[[" + input + "]],[5]]]", "[[2],[[[" + expectedResult + "]],[5]]]", false);
			checkDecode2("{\"a\":{\"b\":{\"c\":" + input + "}}}", "{\"a\":{\"b\":{\"c\":" + expectedResult + "}}}", false);
			checkDecode2("[" + input + "]", "[" + expectedResult + "]", false);
			checkDecode2("[\"x\"," + input + ",54564]", "[\"x\"," + expectedResult + ",54564]", false);
			checkDecode2("[" + input + "," + input + "]", "[" + expectedResult + "," + expectedResult + "]", false);
		}

		public function checkDecodeMulti(input:String, possibleResults:Array):void {
			var i:int = possibleResults.length;
			var errors:String;
			while (i-- > 0) {
				try {
					checkDecode(input, possibleResults[i]);
					return;
				} catch (e:Error) {
					errors += e.getStackTrace() + "\n\n";
					continue;
				}
			}
		}

		public function checkDecode2(input:String, expectedResult:String, isNumber:Boolean):void {
			// try the fast decoder
			try {
				trace(input+" -> " + expectedResult);
				var data:Object = decodeJson(input);
				var adobeResult:String = (new JSONEncoder(data)).getString();
				if (expectedResult != adobeResult) {
					throw new Error("Result: " + adobeResult);
				}
			} catch (e:Error) {
				throw new Error("JSONEncoder(decodeJson()) failed: " + input + " -> " + expectedResult + "\n" + e.getStackTrace() + "\n\n");
			}

			// try the async decoder
			try {
				trace(input+" -> " + expectedResult + " (async)");
				data = (new JsonDecoderAsync(input)).result;
				adobeResult = (new JSONEncoder(data)).getString();
				if (expectedResult != adobeResult) {
					throw new Error("Result: " + adobeResult);
				}
			} catch (e:Error) {
				throw new Error("JSONEncoder(JsonDecoderAsync()) failed: " + input + " -> " + expectedResult + "\n" + e.getStackTrace() + "\n\n");
			}

			// try the async decoder, but only give one byte at a time
			try {
				trace(input+" -> " + expectedResult + " (async 2)");
				var bytes:ByteArray = new ByteArray();
				bytes.writeUTFBytes(input);
				bytes.position = 0;
				var bytes2:ByteArray = new ByteArray();

				var asyncDecoder:JsonDecoderAsync = new JsonDecoderAsync(bytes2, false);
				while (bytes.position < bytes.length) {
					bytes.readBytes(bytes2, bytes2.length, 1);
					asyncDecoder.process();
				}

				data = asyncDecoder.result;
				adobeResult = (new JSONEncoder(data)).getString();
				if (expectedResult != adobeResult) {
					throw new Error("Result: " + adobeResult);
				}
			} catch (e:Error) {
				throw new Error("JSONEncoder(JsonDecoderAsync()) (socket version) failed: " + input + " -> " + expectedResult + "\n" + e.getStackTrace() + "\n\n");
			}

			// try the async decoder, but use limit
			if (!isNumber) {
				try {
					trace(input+" -> " + expectedResult + " (async 3)");
					asyncDecoder = new JsonDecoderAsync(input, false);
					while (!asyncDecoder.process(3)) {};
					adobeResult = (new JSONEncoder(asyncDecoder.result)).getString();
					if (expectedResult != adobeResult) {
						throw new Error("Result: " + adobeResult);
					}
				} catch (e:Error) {
					throw new Error("JSONEncoder(JsonDecoderAsync()) (limit version) failed: " + input + " -> " + expectedResult + "\n" + e.getStackTrace() + "\n\n");
				}
			}
		}

		public function checkDecode3(input:String, extraChars:String, expectedResult:String, isNumber:Boolean):void {
			checkDecode2(input + extraChars, expectedResult, isNumber);

			// try the async decoder, but make sure it doesn't read past the end of the string
			try {
				trace(input+" -> " + expectedResult + " (async extra chars)");
				var bytes:ByteArray = new ByteArray();
				bytes.writeUTFBytes(input + extraChars);
				bytes.position = 0;
				var bytes2:ByteArray = new ByteArray();

				var asyncDecoder:JsonDecoderAsync = new JsonDecoderAsync(bytes2, false);
				while (bytes.position < bytes.length) {
					bytes.readBytes(bytes2, bytes2.length, 1);
					asyncDecoder.process();
				}

				var data:Object = asyncDecoder.result;
				var adobeResult:String = (new JSONEncoder(data)).getString();
				if (expectedResult != adobeResult) {
					throw new Error("Result: " + adobeResult);
				}
				if (!isNumber && bytes2.position != input.length) {
					throw new Error("JsonDecoderAsync read past the end of the string, " + input.length + " to " + bytes2.position);
				}
			} catch (e:Error) {
				throw new Error("JSONEncoder(JsonDecoderAsync()) (extra chars) failed: " + input + extraChars + " -> " + expectedResult + "\n" + e.getStackTrace() + "\n\n");
			}
		}

		public function checkEncode(input:Object, expectedResult:String = ""):void {
			if (!expectedResult) {
				expectedResult = (new JSONEncoder(input)).getString();;
			}
			checkEncode2(input, expectedResult);
			checkEncode2(input, expectedResult);
			checkEncode2({"test":input}, "{\"test\":" + expectedResult + "}");
			checkEncode2([input], "[" + expectedResult + "]");
			checkEncode2([[],[9,9],[[[input]],[]]], "[[],[9,9],[[[" + expectedResult + "]],[]]]");
			checkEncode2(["x",input,54564], "[\"x\"," + expectedResult + ",54564]");
			checkEncode2([input,input],"[" + expectedResult + "," + expectedResult + "]");
		}

		public function checkEncode2(input:Object, expectedResult:String):void {
			try {
				trace("encode(" + expectedResult + ")");
				var result:String = encodeJson(input);
				if (expectedResult != result) {
					throw new Error("Result: " + result);
				}
			} catch (e:Error) {
				throw new Error("encodeJson(" + expectedResult + ") failed\n" + e.getStackTrace() + "\n\n");
			}
		}

		public function testDecode(data:String, adobeTest:Function, fastTest:Function, asyncTest:Function, fastTest2:Function, asonTest:Function):void {
			var time:uint;
			var resultAdobe:uint = 0;
			var resultFast:uint = 0;
			var resultAsync:uint = 0;
			var resultFast2:uint = 0;
			var resultAson:uint = 0;

			var dataBytes:ByteArray = new ByteArray();
			dataBytes.writeUTFBytes(data);

			time = getTimer();
			adobeTest(data);
			resultAdobe += getTimer() - time;

			time = getTimer();
			fastTest(data);
			resultFast += getTimer() - time;

			time = getTimer();
			asyncTest(data);
			resultAsync += getTimer() - time;

			/*time = getTimer();
			asonTest(data);
			resultAson += getTimer() - time;*/

			time = getTimer();
			fastTest2(dataBytes);
			resultFast2 += getTimer() - time;

			time = getTimer();
			asyncTest(data);
			resultAsync += getTimer() - time;

			time = getTimer();
			fastTest(data);
			resultFast += getTimer() - time;

			time = getTimer();
			fastTest2(dataBytes);
			resultFast2 += getTimer() - time;

			time = getTimer();
			adobeTest(data);
			resultAdobe += getTimer() - time;

			/*time = getTimer();
			asonTest(data);
			resultAson += getTimer() - time;*/

			trace("");
			trace("Parsing results for " + data);
			trace("decodeJson improvement: " + (Math.floor(100 * resultAdobe / resultFast) / 100) + "x");
			trace("decodeJson improvement (w/o String overhead): " + (Math.floor(100 * resultAdobe / resultFast2) / 100) + "x");
			trace("JsonDecoderAsync improvement: " + (Math.floor(100 * resultAdobe / resultAsync) / 100) + "x");
			//trace("ason improvement: " + (Math.floor(100 * resultAdobe / resultAson) / 100) + "x");
		}

		public function testEncode(data:Object, adobeTest:Function, fastTest:Function, asonTest:Function):void {
			var time:uint;
			var resultAdobe:uint = 0;
			var resultFast:uint = 0;
			var resultAson:uint = 0;

			time = getTimer();
			adobeTest(data);
			resultAdobe += getTimer() - time;

			time = getTimer();
			asonTest(data);
			resultAson += getTimer() - time;

			time = getTimer();
			fastTest(data);
			resultFast += getTimer() - time;

			time = getTimer();
			adobeTest(data);
			resultAdobe += getTimer() - time;

			time = getTimer();
			fastTest(data);
			resultFast += getTimer() - time;

			time = getTimer();
			asonTest(data);
			resultAson += getTimer() - time;

			trace("");
			trace("Parsing results for " + encodeJson(data));
			trace("encodeJson improvement: " + (Math.floor(100 * resultAdobe / resultFast) / 100) + "x");
			trace("ason improvement: " + (Math.floor(100 * resultAdobe / resultAson) / 100) + "x");
		}
	}
}
