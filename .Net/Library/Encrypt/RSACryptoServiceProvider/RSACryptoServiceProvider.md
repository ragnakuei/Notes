# RSACryptoServiceProvider

## 指定長度

```csharp
new RSACryptoServiceProvider(2048)
```

## 參考資料

[Exporting RSA public key in PKCS#1 format](https://www.sivachandran.in/2012/09/exporting-rsa-public-key-in-pkcs1-format.html)

## 轉成 XML

```csharp
public static String ExportPublicKeyToPEMFormat(RSACryptoServiceProvider csp)
{
	TextWriter outputStream = new StringWriter();

	var parameters = csp.ExportParameters(false);
	using (var stream = new MemoryStream())
	{
		var writer = new BinaryWriter(stream);
		writer.Write((byte)0x30); // SEQUENCE
		using (var innerStream = new MemoryStream())
		{
			var innerWriter = new BinaryWriter(innerStream);
			EncodeIntegerBigEndian(innerWriter, new byte[] { 0x00 }); // Version
			EncodeIntegerBigEndian(innerWriter, parameters.Modulus);
			EncodeIntegerBigEndian(innerWriter, parameters.Exponent);

			//All Parameter Must Have Value so Set Other Parameter Value Whit Invalid Data  (for keeping Key Structure  use "parameters.Exponent" value for invalid data)
			EncodeIntegerBigEndian(innerWriter, parameters.Exponent); // instead of parameters.D
			EncodeIntegerBigEndian(innerWriter, parameters.Exponent); // instead of parameters.P
			EncodeIntegerBigEndian(innerWriter, parameters.Exponent); // instead of parameters.Q
			EncodeIntegerBigEndian(innerWriter, parameters.Exponent); // instead of parameters.DP
			EncodeIntegerBigEndian(innerWriter, parameters.Exponent); // instead of parameters.DQ
			EncodeIntegerBigEndian(innerWriter, parameters.Exponent); // instead of parameters.InverseQ

			var length = (int)innerStream.Length;
			EncodeLength(writer, length);
			writer.Write(innerStream.GetBuffer(), 0, length);
		}

		var base64 = Convert.ToBase64String(stream.GetBuffer(), 0, (int)stream.Length).ToCharArray();
		outputStream.WriteLine("-----BEGIN PUBLIC KEY-----");
		// Output as Base64 with lines chopped at 64 characters
		for (var i = 0; i < base64.Length; i += 64)
		{
			outputStream.WriteLine(base64, i, Math.Min(64, base64.Length - i));
		}
		outputStream.WriteLine("-----END PUBLIC KEY-----");

		return outputStream.ToString();

	}
}

private static void EncodeIntegerBigEndian(BinaryWriter stream, byte[] value, bool forceUnsigned = true)
{
	stream.Write((byte)0x02); // INTEGER
	var prefixZeros = 0;
	for (var i = 0; i < value.Length; i++)
	{
		if (value[i] != 0) break;
		prefixZeros++;
	}
	if (value.Length - prefixZeros == 0)
	{
		EncodeLength(stream, 1);
		stream.Write((byte)0);
	}
	else
	{
		if (forceUnsigned && value[prefixZeros] > 0x7f)
		{
			// Add a prefix zero to force unsigned if the MSB is 1
			EncodeLength(stream, value.Length - prefixZeros + 1);
			stream.Write((byte)0);
		}
		else
		{
			EncodeLength(stream, value.Length - prefixZeros);
		}
		for (var i = prefixZeros; i < value.Length; i++)
		{
			stream.Write(value[i]);
		}
	}
}

private static void EncodeLength(BinaryWriter stream, int length)
{
	if (length < 0) throw new ArgumentOutOfRangeException("length", "Length must be non-negative");
	if (length < 0x80)
	{
		// Short form
		stream.Write((byte)length);
	}
	else
	{
		// Long form
		var temp = length;
		var bytesRequired = 0;
		while (temp > 0)
		{
			temp >>= 8;
			bytesRequired++;
		}
		stream.Write((byte)(bytesRequired | 0x80));
		for (var i = bytesRequired - 1; i >= 0; i--)
		{
			stream.Write((byte)(length >> (8 * i) & 0xff));
		}
	}
}
```
