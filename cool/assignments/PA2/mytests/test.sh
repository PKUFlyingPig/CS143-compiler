TESTDIR=/home/compilers/cool/assignments/PA2/mytests
cd $TESTDIR/..
make lexer
if [ $? -ne 0 ]; then
    echo "Compile error !"
else
    echo "Compiled lexer successfully, run test..."
    TESTSRC=$1
    cd $TESTDIR
    if [ ! -f "${TESTSRC}.cl" ]; then
        echo "test src not exists"
    else
        lexer "${TESTSRC}.cl" > "${TESTSRC}.ref"
        ../lexer "${TESTSRC}.cl" > "${TESTSRC}.out"
        diff "${TESTSRC}.ref" "${TESTSRC}.out"
    fi
fi