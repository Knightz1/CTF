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

![1](https://user-images.githubusercontent.com/91442807/166942349-2ad7b65e-4ca1-4bd5-80bd-7d078886c7dd.png)

Trong giải thì mình dựa trên 1 số quy luật và bruteforce để tìm ra flag:

+Trường hợp _ sẽ có 2 kí tự thỏa điều kiện là n và r nên sẽ có 2 trường hợp: actf{  n_r } và actf{ r_n }

+Đối với trường hợp sau thì mình tìm tiếp là ko có từ nào có nghĩa nên quay lại cái đầu.

+Trong đó chắc chắn có từ flat nên có thể dựa trên đó để giới hạn số trường hợp lại.

+Trường hợp { và } đều có kí tự F thỏa mà F có thể trong từ Flat nên chắc chắn ở đầu từ đó } sẽ giới hạn lại còn 2 trường hợp.

+Tới đây thì các bạn có thể bruteforce các điều kiện và tìm flag


4.Self

Bài này mình ban đầu đặt bp tại hàm getc() để xem nó làm gì với input mà ko được nên cuối viết 1 cái disassembler để xem nó làm cái gì:

Thông qua debug thì ta thấy được chương trình lấy 1 lần 4 bytes từ mảng dword_5632CB0A4038 và lấy byte đầu tiên làm điều kiện để switch-case và các byte sau để tính toán.

![1](https://user-images.githubusercontent.com/91442807/166946518-fcfdabd4-9d2a-4d0a-a57a-2b6340a57ca6.png)

Dump các bytes ra và phân tích các opcode(khá đơn giản vì code trong IDA rất đẹp rồi nên hầu như chỉ là copy-paste)

Disassembler:

![1](https://user-images.githubusercontent.com/91442807/166978131-2264ccbd-b6d1-48e5-9004-ba45e26b3392.png)

![2](https://user-images.githubusercontent.com/91442807/166978153-3af4d7e3-1110-4ac4-a0ad-c36c1986655d.png)

+Quan sát code được generate ra, hóa ra chương trình không bao giờ có opcode để đến được case lấy input(hèn chi mình đặt bp tại getc nó không bao giờ đến được :v)

+Quan sát thêm nữa thì thấy có quá nhiều vòng lặp và nó chỉ làm một công việc như nhau

+Và khi chương trình không lấy input thì nó chỉ có thể tạo flag trên memory

+Debug quan sát các opcode thực hiện lệnh add, sub và xor đồng thời patch các loop ko cần thiết lại.


5. Baby3

+Chỉ là lấy cái mấy cái số hex rồi chuyển lại thành string rồi kết hợp lại là ra flag

6. Super flag bros

+Cơ bản là ta sẽ reverse các máy trong game để tìm code thích hợp(khá đơn giản vì có thể debug được)

+Sau khi tìm được code và nhập vào ta sẽ thấy nó đi qua 1 hàm hash và sau đó xor với 1 mảng byte để in ra màn hình.

+Tuy nhiên sau khi in ra thì lại có một số kí tự null và space rất khó nhìn và nhưng vẫn có thể recover lại được bằng cách biết 1 số kí tự có trước và bruteforce. 

7. Uninspired

+Logic nó như sau: độ dài input là 10 và chỉ lấy các giá trị từ 0 đến 9, sau đó có 1 mảng gồm 10 phần tử 0. Đối với mỗi số trong input thì thì số tại thứ tự đó trong mảng cộng thêm 1.

+Nhận ra có 1 logic là tổng các số trong input phải bằng 10.

+Biết được điều đó thì sau một hồi lấy giấy và thử ta suy ra được số 6210001000.


8. Imposter

+Chương trình không có chỗ để nhập input nên chắc có thể là nó tự print flag đúg như mô tả

+Vấn đề chương trình sử dụng các malloc() với size cực kì lớn để làm chậm chương trình và máy tính cần có ram cực kì lớn để có thể chạy xong.

![1](https://user-images.githubusercontent.com/91442807/167192996-d24047e2-0412-4569-abdb-30dfdd681528.png)

![2](https://user-images.githubusercontent.com/91442807/167193072-4d309e7f-78cf-42f1-b2a9-d2edc1f5d817.png)

+Ở trên là một instruction gọi malloc với sie lớn

+Đến đây t chỉ cần patch lại với 1 kích thước phù hợp để chương trình in ra flag.















