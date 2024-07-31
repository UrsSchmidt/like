#!/bin/bash

# C
gcc -std=c18 -Wall -Wpedantic -o 'likec' 'src/like.c'
# Java
javac -d '.' 'src/Like.java'
# Haskell
ghc -Wall -o 'likehs' -outputdir '.' 'src/like.hs' >/dev/null

while IFS='' read -r line || [[ -n "$line" ]]; do
    IFS=';' read -r -a array <<< "$line"
    str="${array[0]}"
    pattern="${array[1]}"
    expected="${array[2]}"
    # C
    cwas=$(./likec "$str" "$pattern")
    if [ "$cwas" != "$expected" ]; then
        echo "'$str' Like '$pattern'; was: $cwas, expected: $expected; in C"
    fi
    # Java
    javawas=$(java Like "$str" "$pattern")
    if [ "$javawas" != "$expected" ]; then
        echo "'$str' Like '$pattern'; was: $javawas, expected: $expected; in Java"
    fi
    # Haskell
    haskellwas=$(./likehs "$str" "$pattern")
    if [ "$haskellwas" != "$expected" ]; then
        echo "'$str' Like '$pattern'; was: $haskellwas, expected: $expected; in Haskell"
    fi
done < 'tests.txt'

rm 'likec' 'likehs' *.class *.hi *.o
