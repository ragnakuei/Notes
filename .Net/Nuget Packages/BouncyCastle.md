# BouncyCastle

可用來產生 RSA Key Pair 的 Package

.Net Core 版本 套件

-   BouncyCastle.NetCore

## [與 JSEncrypt 搭配使用](https://github.com/ragnakuei/JsEncryptWithBouncyCastleTest)

可以做到前台 JSEncrypt 以公𫓂加密，後台以私𫓂解密 !

## [Asp.Net MVC 前端 JS 加密 後端解密](https://github.com/ragnakuei/AspNetMvcFormEncryptPassword)

## 產生 Public Key File 範例

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
