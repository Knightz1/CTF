1. JS SAFE 4.0

-Đề cho một file html, mở thử:

![image](https://user-images.githubusercontent.com/91442807/177754500-4712df0f-9dec-4db5-9716-613fd0e4301e.png)

-Xem source thì thấy:

![image](https://user-images.githubusercontent.com/91442807/177755033-23845a3f-849f-42e5-8b6e-2430a7d61439.png)

-Khi nhập pass vào thì chương trình sẽ gọi hàm open_safe():

![image](https://user-images.githubusercontent.com/91442807/177755253-c10329b1-7bff-4ab3-ae05-3406c6aadc35.png)

-Hàm check format của  là CTF{....} nếu thỏa thì đưa phần nội dung của flag vào hàm x():

![image](https://user-images.githubusercontent.com/91442807/177755488-ace3f266-cf77-4ea4-aaf3-53e74703a76a.png)

-Quan sát x() thì ta thấy có checksum() có lẽ dùng để check xem có thay đổi gì trong code không và splice() được tạo ra chứ không phải dùng hàm mặc định của js.

-Đến đây mình định debug tại chỗ so sánh để lấy flag nhưng chương trình dùng anti-debug vì web bị frozen khi mình mở DevTools.

-Lướt xuống để xem có gì thú vị không thì mình thấy dòng này:

![image](https://user-images.githubusercontent.com/91442807/177756464-033706c0-ea8c-46e9-bbff-601cfc1510f6.png)

-Xem thử thì thấy:

![image](https://user-images.githubusercontent.com/91442807/177756726-0ef99a98-614c-42cc-9933-e017b6ac2383.png)

-Trong source cũng có một dòng tương tự:

![image](https://user-images.githubusercontent.com/91442807/177756913-5eb50710-b7fc-407a-adb7-a9c61931efea.png)

-Xóa dòng đó thì debug được :))






