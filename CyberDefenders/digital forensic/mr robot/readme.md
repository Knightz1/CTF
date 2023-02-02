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

![1](https://user-images.githubusercontent.com/91442807/216290990-5c60d4a1-34f8-4c19-80ee-5fdf30af34dd.png)

![1](https://user-images.githubusercontent.com/91442807/216290586-4673609e-3e4f-41bd-ae86-0b05fdcddbfc.png)

Phân tích `iexplorer.exe` và liệt kê các `mutant process` với `mutantscan`:

`vol.py -f Target1-1dd8701f.vmss --profile=Win7SP1x86_23418 mutantscan | grep -i ".dat"`

![1](https://user-images.githubusercontent.com/91442807/216293149-3be55eaa-f72c-41d9-9e86-442b8db7d431.png)


## 7. It appears that a notorious hacker compromised this box before our current attackers. Name the movie he or she is from.

## 8. What is the NTLM password hash for the administrator account?

Cái này tình cờ tìm ra thôi.

Dùng `cmdscan` để tìm các lệnh termianl được nhập trong các proccess:

![1](https://user-images.githubusercontent.com/91442807/216297142-6cad779b-62f7-4e1c-92f7-11a93e8472f3.png)

- Thấy được kết quả của `wce.exe` được lưu vào `w.tmp` 

![1](https://user-images.githubusercontent.com/91442807/216297566-ce92d75f-07c4-452f-ae4e-701742bdb152.png)

![1](https://user-images.githubusercontent.com/91442807/216297699-9560b8a1-72e5-4a44-8519-43072425c96f.png)

- Khá là đáng lưu tâm :))

Tới đây mình quyết định lấy offset rồi dump file `w.tmp` ra tương tự như ở trên thôi

![1](https://user-images.githubusercontent.com/91442807/216298006-e8be221e-dc20-4705-8a42-9db2710ded8e.png)

Lấy kết quả rồi đem vào `NTLM Hash Generator` thu được: `79402B7671C317877B8B954B3311FA82`

## 9. The attackers appear to have moved over some tools to the compromised front desk host. How many tools did the attacker move?

Dùng lệnh `consoles` ta có thể liệt kê được mấy cái lệnh được thực hiện và kết quả sau lệnh, xem các file `.exe` ở thư mục `Temp`

![1](https://user-images.githubusercontent.com/91442807/216303435-b853b8a2-697b-4077-857a-cc2e9c2a45c6.png)

## 10. What is the password for the front desk local administrator account?

Lấy của ở trên luôn

## 11. What is the std create data timestamp for the nbtscan.exe tool?

Dùng `timeliner`: 

![1](https://user-images.githubusercontent.com/91442807/216308214-61a853a4-d2aa-4f56-8b18-b5535e9d98d9.png)






