Main function:

![Ảnh chụp màn hình 2021-09-27 090333](https://user-images.githubusercontent.com/91442807/134835038-8bff5787-9bce-43e6-b45a-aa9503467fd8.png)

Check function():

![aad](https://user-images.githubusercontent.com/91442807/134835049-cb06a712-7d76-4075-a609-aa220cf2f3de.png)

It seems the program only received 5 characters include: h,j ,k,l,x . If our input is different from those 5 character, program wil go to default case, print no :< and out.

From my experience in playing previous CTFs, i guess this is a maze solving task

Now, let start analyzing the program:

![Ảnh chụp màn hình 2021-09-27 091654](https://user-images.githubusercontent.com/91442807/134836069-74879737-00fa-448b-8430-ae03d2e69ec5.png)

The program starts at v6=0 and check (dword_563EA2B73080[v6] & 1) != 0) , if passed the check v6--

From this, i think v6 is the step to following location, I also dump the data(dword_563EA2B73080) into (maze_dump.bin)

![2](https://user-images.githubusercontent.com/91442807/134836591-d1143dc7-273a-40ab-8996-61270f8c2e51.png)

Check and step(v6) is similar to 3 cases: j,k,l.

Especially is case x:

![2](https://user-images.githubusercontent.com/91442807/134837212-7d8caa68-a8a1-4b0d-9480-67edcfdc424d.png)

+ First it checks: dword_563EA2B73080[v6] & 0x80 == 0

+ After that program calculate v8 = (dword_563EA2B73080[v6] >> 4) & 7

+ v7+=1

+ v5 =dword_563EA2B73060[v8] ^ (dword_563EA2B73060[v8] >> 8) & v5 (with initial v5 =0)

+ The two last check are (v7==8) and (v5==255)  that mean we have to jump case 'x' 8 times 

I wrote a script to find numbers and their index in dword_563EA2B73080 array that pass dword_563EA2B73080[v6] & 0x80 == 0

![1](https://user-images.githubusercontent.com/91442807/134838025-67743495-f5b4-44c7-a631-e6248bdee221.png)

    140,index=675
    147,index=1235
    164,index=1458
    188,index=1734
    201,index=2111
    218,index=2374
    236,index=2937
    243,index=3585
    
It has exact 8 numbers sastify

The result of v8 according to those 8 numbers:

    140,index=675,  v8=0
    147,index=1235, v8=1
    164,index=1458, v8=2
    188,index=1734, v8=3
    201,index=2111, v8=4
    218,index=2374, v8=5
    236,index=2937, v8=6
    243,index=3585, v8=7
    
v8 corresponds to the location in dword_563EA2B73060 array:

    [0xFF7F, 0xEE47, 0x7B84, 0x13D2, 0x6B21, 0xD262, 0x51CE, 0xE89]
    
And now we have to find the order to have v5==255 after 8 times jump to case 'x', i bruce force it :))

![1](https://user-images.githubusercontent.com/91442807/134839918-56326d29-b6a3-4a35-a7be-9558f5e95761.png)

    [(6, 20942), (3, 5074), (7, 3721), (5, 53858), (1, 60999), (4, 27425), (0, 65407), (2, 31620)]
    
 So the correct order we have to find is: 0->2937->1734->3585->2374->1235->2111->675->1458 , i use bfs to find shorted path from 0->2937, 2937->1734,... 675->1458 and connects them by 'x'  (solve_maze.py)
 
 
 Flag: DUCTF{bfs_dfs_ffs_no_more_mazes_a8fb66c12cd}
 
 














    
