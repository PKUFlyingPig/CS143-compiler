#!/bin/bash

for filename in ../../examples/*.cl; do
    echo "--------Test using" $filename "--------"
    ../../bin/.i686/lexer $filename > refout
    ./lexer $filename > myout
    if diff refout myout; then
        echo "Passed"
    else
        echo "Failed"
    fi
done

rm -rf refout myout