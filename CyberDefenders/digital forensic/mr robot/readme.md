![1](https://user-images.githubusercontent.com/91442807/216226363-fde4c992-7e4a-4678-9d6d-6120c002a7f5.png)

`vol.py -f Target1-1dd8701f.vmss --profile=Win7SP1x86_23418 memdump -D . -p 3196`

![1](https://user-images.githubusercontent.com/91442807/216229197-2f492adc-e62b-4000-806e-1ba3232b391f.png)

`vol.py -f Target1-1dd8701f.vmss --profile=Win7SP1x86_23418 filescan | grep AnyConnectInstaller.exe`

![1](https://user-images.githubusercontent.com/91442807/216231065-63061c6a-e72f-486a-93de-8c55149d4a3a.png)

`vol.py -f Target1-1dd8701f.vmss --profile=Win7SP1x86_23418 dumpfiles -D . -Q 0x000000003df1cf00`

## 4. The malware appears to be leveraging process injection. What is the PID of the process that is injected?

Xem lại mục procees với `pstree`, ta thấy có `cmd.exe` nằm trong `iexplorer.exe`, khá khả nghi:

![1](https://user-images.githubusercontent.com/91442807/216231456-20ac0ed6-6b5d-4eaa-8970-b40eb728f41a.png)



