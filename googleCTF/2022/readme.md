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

![image](https://user-images.githubusercontent.com/91442807/177757551-c41f4cf3-2b7b-4c06-b278-66eb9805fcfe.png)

-Ta thấy được kí tự đầu là 'W' và không cần step gì cả chỉ cần đặt tiếp con trỏ chuột ngay dòng đó là nó tự hiện kí tự tiếp theo, cứ thế ta lấy được: ```W0w_5ucH_N1c3_d3bU9_sK1lLz_```

-Có vẻ nó chưa đủ lắm thì phải, tới đây mình bị kẹt hết một hồi vì những hàm khác như save() không có liên quan.

-Lướt xuống todo xem tiếp:

![image](https://user-images.githubusercontent.com/91442807/177758790-04377ff7-251f-477c-884f-a43378eb017d.png)

-Thấy được thứ tự có vẻ bị ngược, chuyển lại đúng với comment xem thử:

![image](https://user-images.githubusercontent.com/91442807/177759058-482b51a9-f740-49df-b209-9cb6906e608d.png)

-Thế là có phần còn lại :))  ```Br0w53R_Bu9s_C4Nt_s70p_Y0u```


2. MIXED

Bài này mình tìm hiểu sau giải, thấy hay nên note lại.

-Đề cho một file pyc, dựa trên số commit của đề cho tìm được repo: ```https://github.com/python/cpython/tree/64113a4ba801126028505c50a7383f3e9df29573```

-Đây là python phiên bản 3.11, tuy nhiên hãy download file zip về để build vì nếu dùng git clone khi build sẽ up lên phiên bản 3.12

-Đối với phiên bản 3.11 thì mình tìm thấy tool nào hỗ trợ để decompile file pyc cả nên mình sẽ dùng dis module để decompile nó:

```python
import marshal
import dis
with open("x.pyc", "rb") as f1:
   d1=f1.read()
d1=d1[16:]        #bỏ 16 bytes header đầu
y=marshal.loads(d1)
dis.dis(x)
```

![image](https://user-images.githubusercontent.com/91442807/177802626-b8fa4056-0cd4-4f52-9ce3-5f9bd924caee.png)

-Nó in được một chút thì bị lỗi, xem file patch đề cho thì thấy mấy cái opcode trong file opcode.py đã bị đổi chỉ số theo random và cái file x.pyc sử dụng các opcode custom đó chứ không theo số tiêu chuẩn của python 3.11 nữa.

->Vậy bây giờ cần tìm các số random đó để sửa lại trong file opcode.py để in ra cho đúng

-Chỉ còn cách tạo file pyc để xem cấu trúc của nó rồi so sánh với x.pyc để map lại cho đúng

-Tới đây thì xem thử co_names của chương trình lúc mới chạy (python bytecode tiêu biểu có 3 loại là ```co_names``` dùng để lưu các tên biến mà nó sẽ dùng trong code, ```co_consts``` dùng để lưu các số để tính toán và ```co_code``` lưu đoạn code hiển thi dưới định dạng là các bytes.

-Xem co_names:

```python
print(y.co_names)
```

![image](https://user-images.githubusercontent.com/91442807/177806318-8aeaae58-7b83-474f-ab58-67b879a9258d.png)

-Ta thấy có hàm main nhưng trong khi code ở dưới lại không có khởi tạo hàm main:

![image](https://user-images.githubusercontent.com/91442807/177806505-32f73a0a-f1bd-4497-9bca-079b83afc03c.png)

-Tạo file pyc:

```python
import py_compile
py_compile.compile('sample.py')
```
-Custom lại file dis.py của python để in các chỉ số của opcode (dis.py)

-Sau khi viết vài cái đơn giản để tạo ra thử có thể rút ra một số ý:
  +opcode đầu là resume (trong khi opcode đầu của x.pyc là store_global với chỉ số 97) 














