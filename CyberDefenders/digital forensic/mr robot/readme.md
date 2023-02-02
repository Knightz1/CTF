## 1. What email address tricked the front desk employee into installing a security update?

Xem thử proccess với `pstree`:

![1](https://user-images.githubusercontent.com/91442807/216277876-58d5514e-48aa-40f4-a521-afdf77ebc131.png)

- Thấy được một ứng dụng thư của microsoft là `outlook.exe` 

![1](https://user-images.githubusercontent.com/91442807/216226363-fde4c992-7e4a-4678-9d6d-6120c002a7f5.png)

## 2. What is the filename that was delivered in the email?

Tiến hành dump memory tại pid `3196` 

`vol.py -f Target1-1dd8701f.vmss --profile=Win7SP1x86_23418 memdump -D . -p 3196`

Rồi search string: 

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

## 5. What is the unique value the malware is using to maintain persistence after reboot?

Một trong những nơi để setup `persistence access` là ở `registry key`:

![image](https://user-images.githubusercontent.com/91442807/216280777-b1aaf0fc-6e8f-4034-9922-dd96b6195999.png)

- Ta có thể thấy file `AnyConnectInstaller.exe` được drop ở thu mực trên để được persistence access

## 6. Malware often uses a unique value or name to ensure that only one copy runs on the system. What is the unique name the malware is using?

Dùng `mutex` để tránh tình trạng có 2 tiến trình giống nhau cùng chạy trên máy [tham khảo](https://www.sans.org/blog/looking-at-mutex-objects-for-malware-discovery-indicators-of-compromise/)

Phân tích `iexplorer.exe` và liệt kê các `mutant process` trong đó:

![1](https://user-images.githubusercontent.com/91442807/216287251-9e279574-75ec-4529-bfed-410fb93cb97d.png)

## 7. It appears that a notorious hacker compromised this box before our current attackers. Name the movie he or she is from.




