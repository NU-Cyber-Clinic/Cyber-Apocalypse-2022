from pwn import *

conn = remote('68.183.37.6',30112)
conn.recvuntil(">> ", drop=True)
conn.send("2\n")
conn.recvuntil(": ", drop=True)
conn.send("DRAEGER15th30n34nd0nly4dm1n15tr4t0R0fth15sp4c3cr4ft\00\00\00\00\00\00\00")
conn.interactive()