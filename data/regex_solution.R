library(stringr)

#-------------------------------------------------------------------------------
# 1. Basic matches
# 1.1. Match `..\..` in `somestring..\..\somesting`
str_view("string..\\..\\sting", "\\.\\.\\\\\\.\\.")
# 1.2. Match `"'\` in `"'\\somestring`
str_view("\"'\\\\somestring", "\"'\\\\")

#-------------------------------------------------------------------------------
# 2. Anchors
# 2.1. Match words that start with "j" from built-in vector `stringr::words`
# Hint: use `match = TRUE` to show only matched strings
str_view(words, "^j", match = TRUE)
# 2.2. Match all words that end with `d` and that are exactly three
# letters long
str_view(words, "^..d$", match = TRUE)

#-------------------------------------------------------------------------------
# 3. Character classes
# 3.1 Match words that start with a vowel
str_view(words, "^[aeiou]", match = TRUE)
# 3.2 Match words that ends with with `ed`, but not with `eed`
str_view(words, "[^e]ed$", match = TRUE)

#-------------------------------------------------------------------------------
# 4. Repetition
# 4.1 Match the words that start with two or vowels
str_view(words, "^[aeiou]{2,}", match = TRUE)
# 4.2 Match the words that end with two or vowels
str_view(words, "[aeiou]{2,}$", match = TRUE)