# CSP


### web.config

https://stackoverflow.com/questions/37992225/config-your-iis-server-to-use-the-content-security-policy-header

```xml
<add name="Content-Security-Policy" value="script-src 'unsafe-inline' 'unsafe-eval' 'self' https: ;object-src 'self';base-uri 'none';report-uri https://xxxxx.xxx.com;" />

<add name="Content-Security-Policy" value="script-src 'unsafe-eval' 'self' https: ; script-src-elem 'unsafe-inline' 'self' https://code.jquery.com https://www.googletagmanager.com https://www.google-analytics.com ;object-src 'self';base-uri 'none';report-uri https://xxxxx.xxx.com;" />
```