# BouncyCastle

可用來產生 RSA Key Pair 的 Package

## 產生 Public Key 範例

```csharp
void Main()
{
	var rsaKeyPairGenerator = new RsaKeyPairGenerator();
	rsaKeyPairGenerator.Init(new KeyGenerationParameters(new SecureRandom(), 2048));
	var keyPair = rsaKeyPairGenerator.GenerateKeyPair();

	ExportPublicKey(keyPair.Public);
	ExportRsaPublicKey(keyPair.Public);
}

/// <summary>
/// 產生 PKCS#8 format 的 Public Key
/// </summary>
static void ExportPublicKey(AsymmetricKeyParameter publicKey)
{
	var stringWriter = new StringWriter();
	var pemWriter = new PemWriter(stringWriter);
	pemWriter.WriteObject(publicKey);
	stringWriter.Flush();
	stringWriter.Close();

	File.WriteAllText(@"C:\temp\PublicKey.pem", stringWriter.ToString());
}

/// <summary>
/// 產生 PKCS#1 format 的 Public Key
/// </summary>
static void ExportRsaPublicKey(AsymmetricKeyParameter publicKey)
{
	var subjectPublicKeyInfo = SubjectPublicKeyInfoFactory.CreateSubjectPublicKeyInfo(publicKey);
	var rsaPublicKeyStructure = RsaPublicKeyStructure.GetInstance(subjectPublicKeyInfo.GetPublicKey());
	var rsaPublicKeyPemBytes = Base64.Encode(rsaPublicKeyStructure.GetEncoded());

	var stringBuilder = new StringBuilder();

	stringBuilder.AppendLine("-----BEGIN RSA PUBLIC KEY-----");

	for (int i = 0; i < rsaPublicKeyPemBytes.Length; ++i)
	{
		stringBuilder.Append((char)rsaPublicKeyPemBytes[i]);

		// wraps after 64 column
		if (((i + 1) % 64) == 0)
			stringBuilder.AppendLine();
	}

	stringBuilder.AppendLine();
	stringBuilder.AppendLine("-----END RSA PUBLIC KEY-----");

	File.WriteAllText(@"C:\temp\RsaPublicKey.pem", stringBuilder.ToString());
}
```
