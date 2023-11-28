h ← ["0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "A" "B" "C" "D" "E" "F"]
HexToDec ← /+×ⁿ:16⇌⇡⧻.⊗↯¯1_1 :h
HexToBin ← ⇌⋯ HexToDec

# pad input to 4 bytes
BinToHex ← ☇¯2 ⊏ :h ⍘⋯ ≡⇌ ↯¯1_4
