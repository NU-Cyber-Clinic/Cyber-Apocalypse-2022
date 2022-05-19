Analyse the binary to see it takes a password to open

Try the password see it doesnt work so look closer

It reads 57 chars and then compares 52 so if we can fill the extra space with null bytes it should allow us to enter the password, done in `solve.py`

```
HTB{n0_n33d_2_ch4ng3_m3ch5_wh3n_u_h4v3_fl0w_r3d1r3ct}
```