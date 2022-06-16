1. babyreeee

Chương trình lấy chuỗi mình nhập, sau đó lấy từng kí tự trong chuỗi +69 xor với thứ tự của kí tự trong chuỗi rồi so sánh với chuỗi cố định

->Làm ngược lại là ra flag


2. bestsoftware

Reverse file .NET: chương trình lấy name, email và licensekey trong đó name và email được cho trước.

![image](https://user-images.githubusercontent.com/91442807/173990631-03dcaf41-092d-4c12-9e13-f3d3eaccce64.png)

Lúc đó ta chỉ cần lấy chuỗi (name + "1_l0v3_CSh4rp" + email) đem đi SHA256 là ra flag


3. stomped 

Cái này mình debug rồi dùng z3 để giải thôi (cái script mình xóa rồi lười viết lại quá :v)

4. magic

-Quan sát pseudo-code của main không thấy chương trình không lấy input hay in ra cái gì đặc biệt

-Chuyển qua asm xem thử:

![1](https://user-images.githubusercontent.com/91442807/173991885-d63b425c-0f30-47b6-ab5b-968d7a3df4d7.png)

-Ta thấy 2 cái quan trọng là fgets() có lẽ là dùng để lấy input  mà "nope" có lẽ là kết quả sau khi check input nhưng nằm ở vùng text màu đỏ nên có IDA không nhận diện được.

->Ta thử fix lại bằng cách kéo vùng code của main đến hết vùng text màu đỏ

-Tới đây có vẻ main đã nhận được đầy đủ code nhưng F5 lại không có gì khác so với trước đó.

-Ta thấy được mỗi vùng code được chia ra và ở cuối là call function sub_401290() hoặc sub_4012F0(), bấm vào xem thử: 

![image](https://user-images.githubusercontent.com/91442807/173993458-9b4f1446-6231-4b16-a481-3f04f24fa885.png)

-Thấy được hai hàm timeGetTime() và ExitProcess() nên có vẻ là anti-debug

->Nope nó lệnh call lại và đúng là F5 nó decompile được thêm một chút -> nope tiếp các lệnh call còn lại ta được main hoàn chỉnh:

![image](https://user-images.githubusercontent.com/91442807/173994412-b4aec8e3-80bb-4a1c-938a-8a3b117ef50b.png)

![image](https://user-images.githubusercontent.com/91442807/173994460-a78c1a76-8b8d-499a-a7bb-87d3f0a44d27.png)















