# Move VM

## 1. Disassemble file message.mv

`message.mv` is a `move bytecode` file which is used in blockchain

i found at move has a [disassember](https://github.com/move-language/move/tree/main/language/tools/move-disassembler), you can compile move module based on [this](https://github.com/movelanguage/move/blob/main/language/documentation/tutorial/README.md#Step0) and disassemble file .mv

Also, i found some docs about file format, bytecode at [this](https://github.com/move-language/move/issues/817), you can write you own disassembler based on them. 

After built tool, i disassembled file and had its [bytecode](https://github.com/Knightz1/CTF/blob/main/pbctf_2022/move_bytecode.txt)

Also, i found some explanations for each instruction at [this](https://diem-developers-components.netlify.app/papers/diem-move-a-language-with-programmable-resources/2020-05-26.pdf)

## 2. Understand bytecode instruction
<details>
<summary>B0-B1</summary>
	
```python
B0:
	0: ImmBorrowLoc[0](Arg0: vector<u8>)
	1: StLoc[41](loc40: &vector<u8>)
	2: CopyLoc[41](loc40: &vector<u8>)
	3: VecLen(3)
	4: LdU64(58)
	5: Neq
	6: BrFalse(11)
B1:
	7: LdU8(255)
	8: LdU8(1)
	9: Add
	10: Pop
```
</details>

- At first `loc40` = `Arg0` which is `flag` , push `loc40` to stack and get length of `loc40`, compare it with 58, if equal jump to 11 else continue to B1

- len(flag)=58

<details>
<summary>B2-B3</summary>
	
```python
B2:
	11: CopyLoc[41](loc40: &vector<u8>)
	12: LdU64(0)
	13: VecImmBorrow(3)
	14: ReadRef
	15: CastU64
	16: LdU8(48)
	17: Shl
	18: CopyLoc[41](loc40: &vector<u8>)
	19: LdU64(1)
	20: VecImmBorrow(3)
	21: ReadRef
	22: CastU64
	23: LdU8(40)
	24: Shl
	25: BitOr
	26: CopyLoc[41](loc40: &vector<u8>)
	27: LdU64(2)
	28: VecImmBorrow(3)
	29: ReadRef
	30: CastU64
	31: LdU8(32)
	32: Shl
	33: BitOr
....
	69: LdU64(29670774015617385)
	70: Xor
	71: LdU64(7049012482871828)
	72: Neq
	73: BrFalse(78)
B3:
	74: LdU8(255)
	75: LdU8(1)
	76: Add
	77: Pop
```
</details>
	
- Basically, it checks `(loc40[0]<<48) | (loc40[1]<<40) | (loc40[2]<<32) | (loc40[3]<<24) | (loc40[4]<<16) | (loc40[5]<<8) | (loc40[len(log40)-1]<<0) ^ 29670774015617385 == 7049012482871828`

- Check format flag: pbctf{......}

<details>
<summary>B4-B8</summary>
	
```python
B4:
	78: LdConst[0](Vector(U64): [252, 1, 1, 0, 0, 0, 0, 0, 0, 0, 30, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 0, 57, 0, 0, 0, 0, 0,..... ,0])
	79: StLoc[5](loc4: vector<u64>)
	80: ImmBorrowLoc[5](loc4: vector<u64>)
	81: StLoc[39](loc38: &vector<u64>)
	82: VecPack(4, 0)
	83: StLoc[6](loc5: vector<u64>)
	84: MutBorrowLoc[6](loc5: vector<u64>)
	85: StLoc[46](loc45: &mut vector<u64>)
	86: LdU64(0)
	87: StLoc[45](loc44: u64)
B5:
	88: CopyLoc[45](loc44: u64)
	89: CopyLoc[39](loc38: &vector<u64>)
	90: VecLen(4)
	91: Lt
	92: BrFalse(539)
	
B6:
	93: Branch(94)
B7:
	94: CopyLoc[39](loc38: &vector<u64>)
	95: CopyLoc[45](loc44: u64)
	96: VecImmBorrow(4)
	97: ReadRef
	98: StLoc[43](loc42: u64)
	99: CopyLoc[43](loc42: u64)
	100: LdU8(32)
	101: Shr
	102: LdU64(255)
	103: BitAnd
	104: CastU8
	105: StLoc[44](loc43: u8)
	106: MoveLoc[43](loc42: u64)
	107: LdU64(4294967295)
	108: BitAnd
	109: CastU64
	110: StLoc[42](loc41: u64)
	111: CopyLoc[44](loc43: u8)
	112: LdU8(0)
	113: Eq
	114: BrFalse(119)
B8:
	115: CopyLoc[46](loc45: &mut vector<u64>)
	116: MoveLoc[42](loc41: u64)
	117: VecPushBack(4)
	118: Branch(534)
B9:
	119: CopyLoc[44](loc43: u8)
	120: LdU8(1)
	121: Eq
	122: BrFalse(142)
```
</details>

 - B4: `loc4`= [252,....], `loc38`= &`loc4`, `loc44`=0, `loc45`=[]
	
 - B5: if `loc44` < len(`loc38`)
			  
 - B6: jump to 94
			  
 - B7: `loc42`= `loc38`[`loc44`] , `loc43`= (`loc42` >>32)&255, `loc41`= `loc42` &0xffffffff, if `loc43`==0 jump to 115 else jump 119
	
 - B8: push(`loc41`)
	
- Beacause `loc38` is a vector 64 bit, i change to 64 bit array, ignore first 2 bytes bc it is metadata of vector.

Continnue analyzing, i found its a VM

So, i wrote a disassembler for it:

<details>
<summary>Disassembler</summary>
	
```python


flag = b'a'*58

data_arr = [1, 274877906974, 244813135872, 0, 244813135872, 206158430208, 1, 90194313216, 244813135872, 1, 81604378624, 4294967295, 73014444032, 1, 68719476736, 4294327160, 81604378624, 73014444032, 
244813135872, 1, 68719476736, 206158430208, 8, 94489280512, 249108103168, 283467841556, 244813135872, 240518168576, 244813135872, 287762808832, 0, 8589934598, 73014444032, 292057776130, 8589934599, 73014444032, 292057776130, 8589934600, 73014444032, 292057776130, 8589934601, 73014444032, 292057776130, 2209421562, 98784247808, 279172874242, 1095216660480, 0, 8589934602, 73014444032, 292057776130, 8589934603, 73014444032, 292057776130, 8589934604, 73014444032, 292057776130, 8589934605, 73014444032, 292057776130, 4020009855, 98784247808, 279172874242, 1095216660480, 0, 8589934606, 73014444032, 292057776130, 8589934607, 73014444032, 292057776130, 8589934608, 73014444032, 292057776130, 8589934609, 73014444032, 292057776130, 2511570847, 98784247808, 279172874242, 1095216660480, 0, 8589934610, 73014444032, 292057776130, 8589934611, 73014444032, 292057776130, 8589934612, 73014444032, 292057776130, 8589934613, 73014444032, 292057776130, 825727845, 98784247808, 279172874242, 1095216660480, 0, 8589934614, 73014444032, 292057776130, 8589934615, 73014444032, 292057776130, 8589934616, 73014444032, 292057776130, 8589934617, 73014444032, 292057776130, 2747945899, 98784247808, 279172874242, 1095216660480, 0, 8589934618, 73014444032, 292057776130, 8589934619, 73014444032, 292057776130, 8589934620, 73014444032, 292057776130, 8589934621, 73014444032, 292057776130, 2434240953, 98784247808, 279172874242, 1095216660480, 0, 8589934622, 73014444032, 292057776130, 8589934623, 73014444032, 292057776130, 8589934624, 73014444032, 292057776130, 8589934625, 73014444032, 292057776130, 3923412385, 98784247808, 279172874242, 1095216660480, 0, 8589934626, 73014444032, 292057776130, 8589934627, 73014444032, 292057776130, 8589934628, 73014444032, 292057776130, 8589934629, 73014444032, 292057776130, 1510700589, 98784247808, 279172874242, 1095216660480, 0, 8589934630, 73014444032, 292057776130, 8589934631, 73014444032, 292057776130, 8589934632, 73014444032, 292057776130, 8589934633, 73014444032, 292057776130, 3658116609, 98784247808, 279172874242, 1095216660480, 0, 8589934634, 73014444032, 292057776130, 8589934635, 73014444032, 292057776130, 8589934636, 73014444032, 292057776130, 8589934637, 73014444032, 292057776130, 1210550661, 98784247808, 279172874242, 1095216660480, 0, 8589934638, 73014444032, 292057776130, 8589934639, 73014444032, 292057776130, 8589934640, 73014444032, 292057776130, 8589934641, 73014444032, 292057776130, 2892531646, 
98784247808, 279172874242, 1095216660480, 0, 8589934642, 73014444032, 292057776130, 8589934643, 73014444032, 292057776130, 8589934644, 73014444032, 292057776130, 8589934645, 73014444032, 292057776130, 648401340, 98784247808, 279172874242, 1095216660480, 0, 8589934646, 73014444032, 
292057776130, 8589934647, 73014444032, 292057776130, 8589934648, 73014444032, 292057776130, 8589934649, 73014444032, 292057776130, 2537403886, 98784247808, 279172874242, 1095216660480, 296352743424]

id= 0
stack = []

while id<len(data_arr):
    data = data_arr[id]
    op = (data >> 32) & 255
    num = data & 0xffffffff
    #print(op)

    if op == 0x0:
        stack.append(num)
        print(f'push({num})')
        id += 1

    elif op == 0x1:
        if num & 0x80000000:
            stat= 0xffffffff00000000 | num 
        else:
            stat= 0 | num
        stack.append(stat)
        print(f'push({stat})')
        id += 1

    elif op == 0x2:
        stack.append(flag[num])
        print(f'push(flag[{num}])')
        id += 1

    elif op == 0x10:
        stack.append(stack.pop() + stack.pop())
        print(f'push(pop() + pop())')
        id += 1

    elif op == 0x11:
        stack.append(stack.pop() ^ stack.pop())
        print(f'push(pop() ^ pop())')
        id += 1

    elif op == 0x12:
        stack.append(stack.pop() | stack.pop())
        print(f'push(pop() | pop())')
        id += 1

    elif op == 0x13:
        stack.append(stack.pop() & stack.pop())
        print(f'push(pop() & pop())')
        id += 1

    elif op == 0x14:
        stack.append(stack.pop() << stack.pop())
        print(f'push(pop() <<pop())')
        id += 1

    elif op == 0x15:
        stack.append(stack.pop() >> stack.pop())
        print(f'push(pop() >> pop())')
        id += 1

    elif op == 0x16:
        stack.append(stack.pop() != stack.pop())
        print(f'push(pop() != pop())')
        id += 1

    elif op == 0x17:
        stack.append(stack.pop() == stack.pop())
        print(f'push(pop() == pop())')
        id += 1

    elif op == 0x30:
        a1 = stack.pop()
        stack.append(a1)
        stack.append(a1)
        print(f'pop(a1), push(a1,a1)')
        id += 1

    elif op == 0x31:
        a1 = stack.pop()
        a2 = stack.pop()
        stack.append(a2)
        stack.append(a1)
        stack.append(a2)
        print(f'pop(a1,a2), push(a2,a1,a2)')
        id += 1

    elif op == 0x32:
        a1 = stack.pop()
        a2 = stack.pop()
        a3 = stack.pop()
        stack.append(a3)
        stack.append(a2)
        stack.append(a1)
        stack.append(a3)
        print(f'pop(a1,a2,a3), push(a3,a2,a1,a3)')
        id += 1

    elif op == 0x33:
        a1 = stack.pop()
        a2 = stack.pop()
        a3 = stack.pop()
        a4 = stack.pop()
        stack.append(a4)
        stack.append(a3)
        stack.append(a2)
        stack.append(a1)
        stack.append(a4)
        print(f'pop(a1,a2,a3,a4), push(a4,a3,a2,a1,a4)')
        id += 1

    elif op == 0x38:
        a1 = stack.pop()
        print(f'pop(a1)')
        id += 1

    elif op == 0x39:
        a1 = stack.pop()
        a2 = stack.pop()
        stack.append(a1)
        stack.append(a2)
        print(f'pop(a1,a2), push(a1,a2)')
        id += 1

    elif op == 0x3A:
        a1 = stack.pop()
        a2 = stack.pop()
        a3 = stack.pop()
        stack.append(a2)
        stack.append(a3)
        stack.append(a1)
        print(f'pop(a1,a2,a3), push(a2,a3,a1)')
        id += 1

    elif op == 0x40:
        a1 = stack.pop()
        if a1 == 0:
            id += 1
        else:
            id = num
        #print(f'id={id}')

    elif op == 0x41:
        a1 = stack.pop()
        if a1 == 0:
            id += 1
        else:
            id += num
        #print(f'id={id}')

    elif op == 0x42:
        a1 = stack.pop()
        if a1 == 0:
            id += 1
        else:
            id -= num
        #print(f'id={id}')

    elif op == 0x43:
        a1 = stack.pop()
        id = a1

    elif op == 0x44:
        stack.append(id + 1)
        id = num
        #print(f'id={id}')

    elif op == 0x45:
        print("Do nothing")
        id+=1

    elif op == 0x46:
        id += 1
    else:
        print("unknown opcode")
        id+=1
```
</details>

Full trace [here]()








