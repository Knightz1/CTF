Angstrom 

1.Dyn: reverse rust

![1](https://user-images.githubusercontent.com/91442807/166932169-341cdd47-98f4-4f21-990a-dfd86b63807d.png)

-->So sánh các kí tự đầu của input có phải là actf{ hay không

![1](https://user-images.githubusercontent.com/91442807/166932748-1b9d954c-1ea7-40bf-bd28-4912e5481eee.png)

-->So sánh kí tự '7' với } (ở đây inpuut mình nhập là 'actf{qwertyuiopasdfghjklzxcvbnm123456789' )

-->Từ đó suy ra được độ dài input cần tìm là 38

-->Nếu không đúng độ dài đó chương trình sẽ out 

Tuy nhiên lúc so sánh này là gần cuối chương trình này nhưng mình không thấy hàm check chỗ nào cả

-->Search thử strings và tìm được:

![1](https://user-images.githubusercontent.com/91442807/166934558-9388d878-f04c-4a51-90dd-0ed23d41cd76.png)

-->Hóa ra nó nằm tách biệt với code của hàm main

-->Dò từ đó ta thấy được 1 hàm so sánh:

![1](https://user-images.githubusercontent.com/91442807/166935308-44a65c3a-65d3-48c9-8bcf-3bf2564892dd.png)

-->Thử đặt breakpoint tại hàm đó với input đúng format và đúng độ dài nhưng chương trình vẫn bị crash

-->Xem asm tại cuối hàm main, hóa ra nó có gọi tới 1 địa chỉ:

![image](https://user-images.githubusercontent.com/91442807/166935727-cfd4f11a-a9a2-4afb-826e-923b2c01b9ba.png)

-->Ở đó chương trình có 1 instruction ud2 để raise exception và làm crash chương trình ->nope lại

-->Tới đây thì chương trình đã tới được breakpoint mình đặt:

-->Quan sát thấy được chương trình so sánh 32 kí tự tính từ sau { và đến trước } với '_ynourtsd_tet_eh2_bfiasl7cedbda7Correct!'

-->tới đây sửa input lại thành actf{_ynourtsd_tet_eh2_bfiasl7cedbda7} và debug lại

-->Và đã có flag: 

![image](https://user-images.githubusercontent.com/91442807/166937579-6dcd3900-38db-4185-94ee-d073f0aa4996.png)

Lưu ý là chỉ so sánh 32 kí tự nên bỏ chữ P ở cuối ra

-->Flag: actf{rusty_on_the_details_2fbdb7ac7de}









