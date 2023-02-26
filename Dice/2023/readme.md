### not-baby-parallelism

## Trace.py

```python
import ida_dbg
import ida_funcs

res=[]
while True:
    ida_dbg.continue_process()
    ida_dbg.wait_for_next_event(ida_dbg.WFNE_SUSP, -1)
    eip= ida_dbg.get_reg_val("EIP")

    if hex(eip)[-3:]=='445':
        rax= ida_dbg.get_reg_val("RSI")
        res.append(rax)
        # print(rax)

    if hex(eip)[-3:]=='45e':
        rax= ida_dbg.get_reg_val("RSI")
        res.append(rax)
        #print(rax)

    if hex(eip)[-3:]=='46f':
        r12=ida_dbg.get_reg_val("R12")
        r12_func=ida_funcs.get_func_name(r12)
        #print(f'{r12_func}: {res[1]}, {res[0]}')
        #print(f'store {res[1]}')
        if r12_func=='xor':
            print(f'memo[{res[1]}]=  memp[{res[1]}] ^ memo[{res[0]}]')

        if r12_func=='mul':
            print(f'memo[{res[1]}]=  memp[{res[1]}] * memo[{res[0]}]')

        if r12_func=='add':
            print(f'memo[{res[1]}]=  memp[{res[1]}] + memo[{res[0]}]')
        res=[]
    
    if hex(eip)[-3:]=='6b2':
        break
```

## Solve.py

<details>

```python
from z3 import *

s=Solver()

flag=[BitVec(f'{i}',64) for i in range(51)]

for c in flag:
    s.add(c>0x20)
    s.add(c<0x7f)
s.add(flag[0]==ord('d'))
s.add(flag[1]==ord('i'))
s.add(flag[2]==ord('c'))
s.add(flag[3]==ord('e'))
memo=flag
#part1
memo[1]=  memo[1] ^ memo[0]
memo[3]=  memo[3] ^ memo[2]
memo[5]=  memo[5] ^ memo[4]
memo[7]=  memo[7] ^ memo[6]
memo[9]=  memo[9] ^ memo[8]
memo[11]=  memo[11] ^ memo[10]
memo[13]=  memo[13] ^ memo[12]
memo[15]=  memo[15] ^ memo[14]
memo[17]=  memo[17] ^ memo[16]
memo[19]=  memo[19] ^ memo[18]
memo[21]=  memo[21] ^ memo[20]
memo[23]=  memo[23] ^ memo[22]
memo[25]=  memo[25] ^ memo[24]
memo[27]=  memo[27] ^ memo[26]
memo[29]=  memo[29] ^ memo[28]
memo[31]=  memo[31] ^ memo[30]
memo[33]=  memo[33] ^ memo[32]
memo[35]=  memo[35] ^ memo[34]
memo[37]=  memo[37] ^ memo[36]
memo[39]=  memo[39] ^ memo[38]
memo[41]=  memo[41] ^ memo[40]
memo[43]=  memo[43] ^ memo[42]
memo[45]=  memo[45] ^ memo[44]
memo[47]=  memo[47] ^ memo[46]
memo[49]=  memo[49] ^ memo[48]
memo[3]=  memo[3] + memo[1]
memo[7]=  memo[7] + memo[5]
memo[11]=  memo[11] + memo[9]
memo[15]=  memo[15] + memo[13]
memo[19]=  memo[19] + memo[17]
memo[23]=  memo[23] + memo[21]
memo[27]=  memo[27] + memo[25]
memo[31]=  memo[31] + memo[29]
memo[35]=  memo[35] + memo[33]
memo[39]=  memo[39] + memo[37]
memo[43]=  memo[43] + memo[41]
memo[47]=  memo[47] + memo[45]
memo[7]=  memo[7] * memo[3]
memo[15]=  memo[15] * memo[11]
memo[23]=  memo[23] * memo[19]
memo[31]=  memo[31] * memo[27]
memo[39]=  memo[39] * memo[35]
memo[47]=  memo[47] * memo[43]
memo[15]=  memo[15] ^ memo[7]
memo[31]=  memo[31] ^ memo[23]
memo[47]=  memo[47] ^ memo[39]
memo[31]=  memo[31] + memo[15]

#part2
memo[47]=  memo[31] + memo[47]
memo[23]=  memo[15] ^ memo[23]
memo[39]=  memo[31] ^ memo[39]
memo[11]=  memo[7] * memo[11]
memo[19]=  memo[15] * memo[19]
memo[27]=  memo[23] * memo[27]
memo[35]=  memo[31] * memo[35]
memo[43]=  memo[39] * memo[43]
memo[5]=  memo[3] + memo[5]
memo[9]=  memo[7] + memo[9]
memo[13]=  memo[11] + memo[13]
memo[17]=  memo[15] + memo[17]
memo[21]=  memo[19] + memo[21]
memo[25]=  memo[23] + memo[25]
memo[29]=  memo[27] + memo[29]
memo[33]=  memo[31] + memo[33]
memo[37]=  memo[35] + memo[37]
memo[41]=  memo[39] + memo[41]
memo[45]=  memo[43] + memo[45]
memo[49]=  memo[47] + memo[49]
memo[2]=  memo[1] ^ memo[2]
memo[4]=  memo[3] ^ memo[4]
memo[6]=  memo[5] ^ memo[6]
memo[8]=  memo[7] ^ memo[8]
memo[10]=  memo[9] ^ memo[10]
memo[12]=  memo[11] ^ memo[12]
memo[14]=  memo[13] ^ memo[14]
memo[16]=  memo[15] ^ memo[16]
memo[18]=  memo[17] ^ memo[18]
memo[20]=  memo[19] ^ memo[20]
memo[22]=  memo[21] ^ memo[22]
memo[24]=  memo[23] ^ memo[24]
memo[26]=  memo[25] ^ memo[26]
memo[28]=  memo[27] ^ memo[28]
memo[30]=  memo[29] ^ memo[30]
memo[32]=  memo[31] ^ memo[32]
memo[34]=  memo[33] ^ memo[34]
memo[36]=  memo[35] ^ memo[36]
memo[38]=  memo[37] ^ memo[38]
memo[40]=  memo[39] ^ memo[40]
memo[42]=  memo[41] ^ memo[42]
memo[44]=  memo[43] ^ memo[44]
memo[46]=  memo[45] ^ memo[46]
memo[48]=  memo[47] ^ memo[48]
memo[50]=  memo[49] ^ memo[50]

ck=[100,
13,
110,
19,
104,
30,
42,
1539,
1591,
1544,
1593,
136971,
137063,
137022,
137038,
5230,
5131,
5233,
5184,
397480,
397559,
397524,
397495,
12938,
13028,
12967,
13048,
892722,
892674,
892788,
892703,
19864,
19965,
19867,
19965,
357552,
357587,
357562,
357599,
19682,
19606,
19725,
19823,
1299012,
1298992,
1299055,
1298972,
24582,
24630,
24653,
24624]

for i in range(len(ck)):
    s.add(memo[i]==ck[i])

print(s.check())
if s.check() == sat:
    m=s.model()
    flag=[BitVec(f'{i}',64) for i in range(51)]
    for j in flag:
        print(chr(m[j].as_long()),end="")
```
</details>
