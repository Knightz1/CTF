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


2.BEAM: reverse Erlang file

Cái bài này logic không khó nên mình chỉ để tool ở đây rồi các tự decompile ra để phân tích nhá:

https://github.com/michalmuskala/decompile?fbclid=IwAR3uq_SR3MPlruZcxOlRPN4TmQZi7IrHtnMfE4Y8ETf-Q8T5H6DvGGCYOJE


3.Flatland: reverse VM

Chỉ cần debug để hiểu flow của chương trình:

![1](https://user-images.githubusercontent.com/91442807/166939097-d09d19ed-b4dc-4705-beaa-133c1c1aad45.png)

+Đầu tiên chương trình sẽ lấy từng kí tự của input mình nhập vào ở case 13

+Sau đó thực hiện một vòng lặp 24 lần ở case 8 và case 10

+Trong vòng lặp đó thực hiện check kí tự mình nhập có nằm trong mảng byte_402150 không, nếu không có sẽ out chương trình 

+Sau đó sẽ lấy thứ tự của kí tự đó trong mảng byte_402150 để lưu vào một mảng.

+Thực hiện như vậy đối với kí tự kế tiếp

+Sau đó tới hàm check ở case 5:

![1](https://user-images.githubusercontent.com/91442807/166940156-880492b5-b869-4366-9166-e975cf62cf06.png)

-->Ở đây v3 là index của thứ tự kế tiếp và v11 là index của kí tự trước 

-->Có 4 hàm check như thế, nếu 1 trong 4 cái check không có cái nào thỏa chương trìng sẽ out 

-->Tóm lại, logic của chương trình sẽ như vầy:

inp=['N','f', 'T', 'R', 'c', 'D', '1', 'o', 'n', 't', 'r', 'w', '}', '4', '{', 'm', 'F', 'l', '_', 'A', 'd', '0', 'u', 'a']
a=[0x14,0xa,0x0,0x16,0xe,4,5,0x16,0xf,0xf,0x12,7,0xa,2,0x13,0x13,9,0xd,0x8,0x11,0xb,0xc,0,4]
b=[0x11,0xe,0xf,6,9,0xc,5,0xa,0x12,1,7,0x15,0x10,0xe,0x10,2,0x11,0,0xa,8,0x16,3,2,0x13]

xx=[0]*24
#xx độ dài 24 kí tự
#chỉ lấy các kí tự trong inp và các kí tự phải khác nhau
#bắt đầu với actf{ và kết thúc }

#sao cho:
count=0
for i in range(len(xx)):
    x=inp.index(xx[i])
    y=inp.index(xx[i+1])
    if y==a[x] or x==a[y] or y==b[x] or x==b[y]:
        count+=1
    else:
        print('Fail')
        break

if count==24:
    print('Success')










