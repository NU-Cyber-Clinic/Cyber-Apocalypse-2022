Research NTUSER.DAT is a reg hive

Find how to carve data out of them and find [Registry Explorer](https://ericzimmerman.github.io/)

Look into the run folder and find a powershell on startup, decode that ase base64 utf16 (payload.ps1)

Swap the iex to a write-output and place in the other strings from the registry to dump the decrypted string

One of the lines also needs to be swapped round to get the key to load

```
HTB{g0ld3n_F4ng_1s_n0t_st34lthy_3n0ugh}
```