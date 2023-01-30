## Hook lệnh i32.eq và xem các tham số của nó

```js
flag="";

Wasabi.analysis = {
    binary(location, op, first, second, result) {
        if (op == 'i32.eq' && location['func'] == 9) {
            
            //console.log(location, op, "first =", first, " second =", second, "result =", result);
            flag+= String.fromCharCode(first);
            console.log("-->", flag);
        }
    }
};
```

![1](https://user-images.githubusercontent.com/91442807/215435824-385c0fb8-7420-46a7-b4b3-62d9febb5483.png)

