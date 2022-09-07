## 1. granpa's magic

- 1 bài reverse boot sector

-Search trên mạng thì có [blog](https://teamrocketist.github.io/2018/10/11/Reverse-InCTF-2018-load3r/) và bài này cũng tương tự dùng y chang cách reverse và debug.

-Solve script:

```python
from z3 import *

s=Solver()

inp=[BitVec(f'{i}',16) for i in range(16)]

for c in inp:
  s.add(c>0x20)
  s.add(c<0x7f)

s.add(((inp[13]<<8)|inp[12]) + ((inp[15]<<8)|inp[14]) ==0x9de0)
s.add(((inp[9]<<8)|inp[8]) + ((inp[11]<<8)|inp[10]) ==0xB3D3)
s.add(((inp[5]<<8)|inp[4]) + ((inp[7]<<8)|inp[6]) ==0x0CEA7)
s.add(((inp[1]<<8)|inp[0]) + ((inp[3]<<8)|inp[2]) ==0x8FE2)

s.add((inp[12]) * (inp[14]) ==0x30F0)
s.add((inp[8]) * (inp[10]) ==0x2B74)
s.add((inp[4]) * (inp[6]) ==0x171C)
s.add((inp[0]) * (inp[2]) ==0x31D8)

s.add(inp[0xe]==inp[0xf])
s.add(inp[0x1]==0x30)
s.add(inp[6]==inp[1]+3)
s.add(inp[0x4]==inp[0x2])
s.add(inp[0xa]==inp[5]-1)
s.add(inp[0xa]!=inp[0x9])
s.add(inp[0xb]+1==inp[0xc])

# print(s.check())


while s.check()==sat:
  m=s.model()
  out=""
  cond=[]
  for i in inp:
    out+=chr(m[i].as_long())

    cond.append(i != int(m[i].as_long()))
  
  s.add(Or(cond))
  print(out)

```
