1. Oracle

Một bài java đơn giản

z3 script:

```
from z3 import *
s=Solver()

inp=[BitVec(f'{i}',32) for i in range(42)]
for c in inp:
    s.add(c>0x20)
    s.add(c<0x7f)


for i in range(42):
    inp[i]=inp[i] ^ 3 * i * i + 5 * i + 101 + i % 2

dd=[0]*42
for i in range(42):
    dd[i]=inp[(i + 42 - 1) % 42] << 4 | (inp[i] & 0xFF) >> 4

inp=dd

for i in range(42):
    inp[i]=inp[i]+7 * i * i + 31 * i + 127 + i % 2

ck=[48, 6, 122, -86, -73, -59, 78, 84, 105, -119, -36, -118, 70, 17, 101, -85, 55, -38, -91, 32, -18, -107, 53, 99, -74, 67, 89, 120, -41, 122, -100, -70, 34, -111, 21, -128, 78, 27, 123, -103, 36, 87]
n=0
for i in range(42):
    n=n|((ck[i]^inp[i])&0xff)

s.add(n==0)
print(s.check())
if s.check()==sat:
    m=s.model()
    inp=[BitVec(f'{i}',32) for i in range(42)]
    for i in inp:
        print(chr(m[i].as_long()),end="")


```
