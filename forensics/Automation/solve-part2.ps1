function Create-AesManagedObject($key, $IV) {
    $aesManaged = New-Object "System.Security.Cryptography.AesManaged"
    $aesManaged.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $aesManaged.Padding = [System.Security.Cryptography.PaddingMode]::Zeros
    $aesManaged.BlockSize = 128
    $aesManaged.KeySize = 256
    if ($IV) {
        if ($IV.getType().Name -eq "String") {
            $aesManaged.IV = [System.Convert]::FromBase64String($IV)
     
        }
        else {
            $aesManaged.IV = $IV
     

        }
    }
    if ($key) {

        if ($key.getType().Name -eq "String") {
            $aesManaged.Key = [System.Convert]::FromBase64String($key)
        }
        else {
            $aesManaged.Key = $key
        }
    }
    $aesManaged
}

function Create-AesKey() {
  
    $aesManaged = Create-AesManagedObject $key $IV
    [System.Convert]::ToBase64String($aesManaged.Key)
}

function Encrypt-String($key, $unencryptedString) {
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($unencryptedString)
    $aesManaged = Create-AesManagedObject $key
    $encryptor = $aesManaged.CreateEncryptor()
    $encryptedData = $encryptor.TransformFinalBlock($bytes, 0, $bytes.Length);
    [byte[]] $fullData = $aesManaged.IV + $encryptedData
    $aesManaged.Dispose()
    [System.BitConverter]::ToString($fullData).replace("-","")
}

function Decrypt-String($key, $encryptedStringWithIV) {
    $bytes = [System.Convert]::FromBase64String($encryptedStringWithIV)
    $IV = $bytes[0..15]
    $aesManaged = Create-AesManagedObject $key $IV
    $decryptor = $aesManaged.CreateDecryptor();
    $unencryptedData = $decryptor.TransformFinalBlock($bytes, 16, $bytes.Length - 16);
    $aesManaged.Dispose()
    [System.Text.Encoding]::UTF8.GetString($unencryptedData).Trim([char]0)
}

filter parts($query) { $t = $_; 0..[math]::floor($t.length / $query) | % { $t.substring($query * $_, [math]::min($query, $t.length - $query * $_)) }} 
$key = "a1E4MUtycWswTmtrMHdqdg=="

$data = & 'C:\Program Files\Wireshark\tshark.exe' -r capture.pcap -n -l -T ek -2 -R dns.flags.response==1 -e dns.qry.name | ConvertFrom-Json

$inBlock = $false
$encryptedString = ""
foreach ($entry in $data) {
	if ($entry.layers.dns_qry_name.Count -eq 0) {
		continue
	}

	$dnsName = $entry.layers.dns_qry_name[0]
	if ($dnsName -eq 'start.windowsliveupdater.com') {
		$inBlock = $true
	} elseif ($dnsName -eq 'end.windowsliveupdater.com') {
		$inBlock = $false

		$bytes = [byte[]] -split ($encryptedString -replace '..', '0x$& ')
		$base64 = [System.Convert]::ToBase64String($bytes)

		$backToPlainText = Decrypt-String $key $base64
		Write-Output $backToPlainText

		$encryptedString = ""
	} elseif ($inBlock -and $dnsName.EndsWith('.windowsliveupdater.com')) {
		$encryptedString += $dnsName.Split(".")[0]
	}
}
