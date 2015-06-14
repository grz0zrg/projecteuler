#!/bin/sh

if [ "$#" -ne 1 ]; then
	echo "Usage: ./bench.sh n_times"
	exit 1
fi

cd "$(dirname "$0")/1"

echo "\n Benchmarking projecteuler.net solution 1 ..."
echo "\n Compile Haskell solution... $(ghc 1.hs -o projecteuler_1_hs >/dev/null)done."
echo "\n Anubis     $(anbexec benchmark $1 . anbexec projecteuler_1 999 1 2 3 4 5 6 7 8 9 10)"
echo "\n Python     $(anbexec benchmark $1 . python 1.py 999 1 2 3 4 5 6 7 8 9 10)"
echo "\n Haskell    $(anbexec benchmark $1 . projecteuler_1_hs 999 1 2 3 4 5 6 7 8 9 10)"
echo "\n JavaScript $(anbexec benchmark $1 . node 1.js 999 1 2 3 4 5 6 7 8 9 10)"
