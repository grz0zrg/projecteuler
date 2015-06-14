#!/bin/sh

if [ "$#" -ne 1 ]; then
	echo "Usage: ./bench.sh n_times"
	exit 1
fi

cd "$(dirname "$0")/1"

echo "\n Benchmarking projecteuler.net solution 1 ..."
echo "\n Compile Haskell solution... $(ghc 1.hs -o projecteuler_1_hs >/dev/null)done."
echo " Compile Java solution... $(javac 1.java >/dev/null)done."
echo "\n  \033[34mAnubis\033[0m     $(anbexec benchmark $1 . anbexec projecteuler_1 999 1 2 3 4 5 6 7 8 9 10)"
echo "  \033[34mPython\033[0m     $(anbexec benchmark $1 . python 1.py 999 1 2 3 4 5 6 7 8 9 10)"
echo "  \033[34mHaskell\033[0m    $(anbexec benchmark $1 . ./projecteuler_1_hs 999 1 2 3 4 5 6 7 8 9 10)"
echo "  \033[34mJavaScript\033[0m $(anbexec benchmark $1 . node 1.js 999 1 2 3 4 5 6 7 8 9 10)"
echo "  \033[34mJava\033[0m       $(anbexec benchmark $1 . java projecteuler_1 999 1 2 3 4 5 6 7 8 9 10)"
