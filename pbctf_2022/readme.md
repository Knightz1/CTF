Move VM

## 1. Disassemble file message.mv

`message.mv` is a `move bytecode` file which is used in blockchain

i found at move has a [disassember](https://github.com/move-language/move/tree/main/language/tools/move-disassembler), you can compile move module based on [this](https://github.com/movelanguage/move/blob/main/language/documentation/tutorial/README.md#Step0) and disassemble file .mv

Also, i found some docs about file format, bytecode at [this](https://github.com/move-language/move/issues/817), you can write you own disassembler based on them. 

After built tool, i disassembled file and had its [bytecode](https://github.com/Knightz1/CTF/blob/main/pbctf_2022/move_bytecode.txt)

Also, i found some explanations for each instruction at [this](https://diem-developers-components.netlify.app/papers/diem-move-a-language-with-programmable-resources/2020-05-26.pdf)

## 2. Understand bytecode instruction

```
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

At first `loc40` = `Arg0` which is `flag` , push `loc40` to stack and get length of `loc40`, compare it with 58, if equal jump to 11 else continue to B1

- len(flag)=58

```
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
Basically, it checks `(loc40[0]<<48) | (loc40[1]<<40) | (loc40[2]<<32) | (loc40[3]<<24) | (loc40[4]<<16) | (loc40[5]<<8) | (loc40[len(log40)-1]<<0) ^ 29670774015617385 == 7049012482871828`





