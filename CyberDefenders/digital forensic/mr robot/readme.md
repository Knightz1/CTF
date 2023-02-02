![1](https://user-images.githubusercontent.com/91442807/216226363-fde4c992-7e4a-4678-9d6d-6120c002a7f5.png)

`vol.py -f Target1-1dd8701f.vmss --profile=Win7SP1x86_23418 memdump -D . -p 3196`

![1](https://user-images.githubusercontent.com/91442807/216229197-2f492adc-e62b-4000-806e-1ba3232b391f.png)

## 3. What is the name of the rat's family used by the attacker?

Ta lấy `offset` của file AnyConnectInstaller.exe:

`vol.py -f Target1-1dd8701f.vmss --profile=Win7SP1x86_23418 filescan | grep AnyConnectInstaller.exe`

![1](https://user-images.githubusercontent.com/91442807/216231065-63061c6a-e72f-486a-93de-8c55149d4a3a.png)

Rồi tiến hành dump file:

`vol.py -f Target1-1dd8701f.vmss --profile=Win7SP1x86_23418 dumpfiles -D . -Q 0x000000003df1cf00`

Thực hiện dump file trên lần lượt từng offset được liệt kê, ta thấy ở offset `0x000000003df1cf00` cho ra 1 file `PE` 

- Lấy `md5sum` rồi cho lên virustotal thử:

![image](https://user-images.githubusercontent.com/91442807/216276930-205a33d5-0a6c-473e-ad37-f6ea4cf60f13.png)

Search theo từ `rat` của câu hỏi thì thu được như hình trên. 

## 4. The malware appears to be leveraging process injection. What is the PID of the process that is injected?

Xem lại mục procees với `pstree`, ta thấy có `cmd.exe` nằm trong `iexplorer.exe`, khá khả nghi:

![1](https://user-images.githubusercontent.com/91442807/216231456-20ac0ed6-6b5d-4eaa-8970-b40eb728f41a.png)



