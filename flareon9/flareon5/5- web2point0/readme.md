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
