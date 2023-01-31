## 3. What is the PID of the suspicious process?

Dùng lệnh `psaux`:

![image](https://user-images.githubusercontent.com/91442807/215719823-cc7ae322-e207-4835-9504-b4aef40dc8db.png)

- Quan sát tại PID `2854` ta thấy rõ ràng là thực hiện `reverse shell` đến máy của attacker để chiếm quyền điều khiển.

## 4. The attacker downloaded a backdoor to gain persistence. What is the hidden message in this backdoor?

- Quan sát lại `bash history`:

![2](https://user-images.githubusercontent.com/91442807/215723656-199b576e-513d-42d2-8b73-ac76e641985d.png)

- Ta thấy có chạy file `PythonBackup.py` nên vô link source của nó thử và thấy tại file `app/snapshot.py`:

![image](https://user-images.githubusercontent.com/91442807/215724200-22f8c3db-b320-4200-a7e9-e2552e6fa6a6.png)

- Thấy chương trình có tải file nào đó về:

- Tải về xem thử:

![1](https://user-images.githubusercontent.com/91442807/215724508-6cfadf0b-b5e8-410e-9f2e-aced2763cafd.png)

- Decode base64 ra: `shkCTF{th4t_w4s_4_dumb_b4ckd00r_86033c19e3f39315c00dca}`

## 5. What are the attacker's IP address and the local port on the targeted machine?

Ở phần trên ta thấy attacker thực hiện `reverse shell` đến port `12345`, nên ta sử dụng `linux_netstat` để xem các kết nối đến port đó:

![1](https://user-images.githubusercontent.com/91442807/215726225-517b1a77-5ba0-4357-8ed0-884e02e83721.png)

- Kết quả: `192.168.49.1:12345`

## 6. What is the first command that the attacker executed?

Xem lại ở trên thì lệnh đầu tiên của attacker là gọi bash shell: `python -c import pty; pty.spawn("/bin/bash")`

## 7. After changing the user password, we found that the attacker still has access. Can you find out how?

![1](https://user-images.githubusercontent.com/91442807/215728037-31973153-ac11-4c82-849d-61270f59451a.png)

ta có thấy attacker có mở file `rc.local` rồi ghi cái gì đó nhưng ta không thể dump file đó ra được, nhưng ta có thể `dump memory` tại PID `2887` để xem cách nó edit file:

![1](https://user-images.githubusercontent.com/91442807/215728417-beb880cd-7bec-468e-a93b-1552bf02a14f.png)

Ta lưu hết mấy cái string của mấy file dump được vào 1 file rồi `cat` nó rồi lọc từ `echo` ra: `cat str.txt | grep echo -A 5 -B 5`

![1](https://user-images.githubusercontent.com/91442807/215731047-0b09c4b1-85c8-4ba6-a49f-d87ae255e299.png)

- Quan sát thấy attacker lưu `ssh key` của máy nạn nhân để có thể dễ dàng truy cập.





