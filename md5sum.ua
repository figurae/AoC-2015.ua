HexToBin ← &i "hex.ua" "HexToBin"
BinToHex ← &i "hex.ua" "BinToHex"
Xor ← ◿2+
PadToWord ← ⊂⊚-:32⧻.
PadToByte ← ⊂⊚-:8⧻.
ReverseEndianness ← ↯¯1 ⇌ ↯¯1_8
ModAddBin ← ⇌⋯◿ⁿ32 2+∩(⍘⋯⇌)

ToBinary ← ↯¯1≡(⊂0⇌)⋯ -@\0

# TODO: handle more than one block
ToM ← ⊂:⊂:⊂:⊚-:64⧻. PadToByte ⇌⋯-1:⊚⊃(-:448⧻)(⧻).⊂ :1

# TODO: these numbers can be calculated on the fly
MRoundTwo ← [1 6 11 0 5 10 15 4 9 14 3 8 13 2 7 12]
MRoundThree ← [5 8 11 14 1 4 7 10 13 0 3 6 9 12 15 2]
MRoundFour ← [0 7 14 5 12 3 10 1 8 15 6 13 4 11 2 9]

A ← PadToWord HexToBin "67452301"
B ← PadToWord HexToBin "EFCDAB89"
C ← PadToWord HexToBin "98BADCFE"
D ← PadToWord HexToBin "10325476"

KWords ← ≡⇌⋯⌊×ⁿ32 2⌵○+1⇡64

F ← |3 ↥⊃(⟜↧¬)(↧)     # (B & C) | (~B & D)
G ← |3 ↥⊃(⋅(↧¬:))(⟜↧) # (B & D) | (C & ~D)
H ← |3 Xor Xor        # B ^ C ^ D
I ← |3 Xor ↥¬:⊙:      # C ^ (B | ~D)

Si ← [[7 12 17 22][5 9 14 20][4 11 16 23][6 10 15 21]]
SiOne ← ⊂⊂⊂...⊢ Si
SiTwo ← ⊂⊂⊂...⊡1 Si
SiThree ← ⊂⊂⊂...⊡2 Si
SiFour ← ⊂⊂⊂...⊡3 Si

PrepareInput ← |4.5 ⊃⊃⊃(⊡1)(⊡2)(⊡3)(⊡0).⊂⊂⊟

ProcessRound ← (
  ⊙⊙(:⊙(⊃(⊢)(↘1)))
  ⊙⊙⊙(:⊙(:⊙(⊃(⊢)(↘1))))
  ⍥(ModAddBin)3
  ⊙⊙⊙⊙(⊃(⊢)(↘1))
  ⊃(⋅⋅⋅⋅∘)(⊙⊙⊙∘)
  ↻⊙PadToWord
  ⊙⊃⊃⊃(⊡1)(⊡1)(⊡2)(⊡3)
  PadToWord ModAddBin
  ⊃(⋅⋅⋅∘)(⊙⊙∘)
)

PrepareStack ← ⊙⊙⊙⊙⊙⊙;;⊃(⊙⊙⊙⊙⊙⊙⊙∘)(∘) ⊙⊙⊙⊙⊙;;⊃(⊙⊙⊙⊙⊙⊙∘)(∘) ⊃(⋅⋅⋅⋅⋅⋅⋅⋅∘)(⊙⊙⊙⊙⊙⊙⊙∘)

MdFive ← (
  ... ≡ReverseEndianness ↯16_32 ToM ToBinary
  ⊙(⊏MRoundTwo) ⊙⊙(⊏MRoundThree) ⊙⊙⊙(⊏MRoundFour)
  ⊙⊙⊙⊙(:⊙:) A B C D KWords SiOne
  ⍥(ProcessRound F PrepareInput)16
  PrepareStack SiTwo
  ⍥(ProcessRound G PrepareInput)16
  PrepareStack SiThree
  ⍥(ProcessRound H PrepareInput)16
  PrepareStack SiFour
  ⍥(ProcessRound I PrepareInput)16
  ⊂⊂⊟ A B C D ⊂⊂⊟ ⊙⊙⊙⊙(;;;)
  ↯¯1 ≡(BinToHex ReverseEndianness PadToWord ModAddBin)
)
