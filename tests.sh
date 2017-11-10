#!/bin/bash

# C
gcc -std=c11 -Wall -Wpedantic -o 'likec' 'like.c'
# Java
javac 'Like.java'
# Haskell
ghc -Wall -o 'likehs' 'like.hs'

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

rm 'likec' 'Like.class' 'likehs' 'like.hi' 'like.o'
