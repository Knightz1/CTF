## 3. What is the PID of the suspicious process?

Dùng lệnh `psaux`:

![image](https://user-images.githubusercontent.com/91442807/215719823-cc7ae322-e207-4835-9504-b4aef40dc8db.png)

- Quan sát tại PID `2854` ta thấy rõ ràng là thực hiện `reverse shell` đến máy của attacker để chiếm quyền điều khiển.

## 4. The attacker downloaded a backdoor to gain persistence. What is the hidden message in this backdoor?

- Quan sát lại `bash history`:

![2](https://user-images.githubusercontent.com/91442807/215723656-199b576e-513d-42d2-8b73-ac76e641985d.png)

- Ta thấy có chạy file `PythonBackup.py` nên vô link source của nó thử và thấy tại file `app/snapshot.py`:

![1](https://user-images.githubusercontent.com/91442807/215723898-a7b0f042-a0f2-47b1-9601-4a4ace11f03d.png)



