s ← "ckczppom"
Sample ← "abcdef"

MdFive ← &i "md5sum.ua" "MdFive"

# NOTE: this is much too slow to calculate more than a few thousand hashes
⇡1000
⊐≡⍘parse
⊐≡(⊐⊂ s)
≡MdFive
⊐≡(regex "^00.+") # there is something with two zeroes in the first thousand though!
⊔⊢⊢ ⊏⊚≡⧻.
