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




