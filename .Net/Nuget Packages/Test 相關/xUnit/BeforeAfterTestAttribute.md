# BeforeAfterTestAttribute

[Sample](https://github.com/xunit/samples.xunit/tree/master/AssumeIdentity)

提供繼承的 Attribute 可以實作以下二個 Method

- public virtual void Before(MethodInfo methodUnderTest);
- public virtual void After(MethodInfo methodUnderTest);

呼叫順序

- 建構子
- Before()
- After()

