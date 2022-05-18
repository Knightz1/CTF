1. Time hash

Cơ bản là chương trình gọi hàm sleep() trong vòng lặp while tính toán số làm chương trình in chậm.

Có 2 cách là code lại hàm in số hoặc là patch hàm sleep() lại là xong.

2. Babydoid

![1](https://user-images.githubusercontent.com/91442807/169002163-7b4112ae-8b12-4538-a01f-bf589bbe3fff.png)

Nhiệm vụ chỉ là pass mấy cái check đó là có flag

```
if (flag.startsWith("HCMUS-CTF{") 
&& flag.charAt(19) == '_' 
&& flag.length() == 37 
&& flag.toLowerCase().substring(10).startsWith("this_is_") 
&& flag.charAt(((int) (((double) MagicNum.obtainY()) * Math.pow((double) MagicNum.obtainX(), (double) MagicNum.obtainY()))) + 2) == flag.charAt(((int) Math.pow(Math.pow(2.0d, 2.0d), 2.0d)) + 3) 
&& new StringBuilder(flag).reverse().toString().toLowerCase().substring(1).startsWith(ctx.getString(C0095R.string.last_part)) 
&& new StringBuilder(flag).reverse().toString().charAt(0) == '}' 
&& Helper.ran(flag.toUpperCase().substring((MagicNum.obtainY() * MagicNum.obtainX() * MagicNum.obtainY()) + 2, (int) (Math.pow((double) MagicNum.obtainZ(), (double) MagicNum.obtainX()) + 1.0d))).equals("ERNYYL") 
&& flag.toLowerCase().charAt(18) == 'a' 
&& flag.charAt(18) == flag.charAt(28) 
&& flag.toUpperCase().charAt(27) == flag.toUpperCase().charAt(28) + 1) {
```

Mấy cái check này khá đơn giản, 1 số chỗ cần chú ý:

+cái phần (C0095R.string.last_part) mình lấy file strings trong thư mục /res/values/strings/ sau khi dùng apktools để dump file apk ra.

+còn mấy cái còn lại là dễ nên các bạn tự phân tích

+sau khi tìm được chuỗi phù hợp đối với mấy cái check trên thì cuối cùng nó yêu cầu chuỗi tìm được phải đúng format của Helper.retriever() 

+Helper.retriever() đơn giản là dùng regex để check kí tự đầu là in hoa, sau là in thường, tiếp nữa là in hoa rồi lại in thường lặp lại đến kí tự cuối cùng.
