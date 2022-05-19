(Didn't submit in time)

Register and login with any account, there is an export button

Find the export api and send a invalid svg to see a stacktrace to get a lib name, search for a vuln for the lib

Find dir traversal

https://security.snyk.io/vuln/SNYK-JS-CONVERTSVGCORE-1582785

Use that to dump the /app/index.js and /app/.env to get the cookie method and secret

Write a quick app (`solve.js`) to generate the cookie for admin and then slot it in and reload

Flag is in source code
```
HTB{fr4m3d_th3_s3cr37s_f0rg3d_th3_entrY}
```