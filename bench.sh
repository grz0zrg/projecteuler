#!/bin/sh

if [ "$#" -lt 1 ]; then
	echo "Usage: ./bench.sh n_times"
	exit 1
fi

n_times=$1

compile () {
	local cmd=""
	local lang=""
	
	case "${1##*.}" in
		"anubis" )
			cmd="$(anubis $1 >/dev/null)"
			lang="Anubis"
		;;	

		"hs" )
			cmd="$(ghc $1 -o projecteuler.${1%.*}.bin >/dev/null)"
			lang="Haskell"
		;;
		
		"java" )
			cmd="$(javac $1 >/dev/null)"
			lang="Java"
		;;
	esac
	
	if [ -n "$lang" ]; then
		echo "  Compile $lang solution... $cmd\033[32mdone\033[0m."
	fi
}

benchmark () {
	local cmd=""
	local lang=""

	case "${2##*.}" in
		"anubis" )
			cmd="anbexec projecteuler_$1"
			lang="Anubis"
		;;
		
		"hs" )
			cmd="./projecteuler_$1_hs"
			lang="Haskell"
		;;
		
		"java" )
			cmd="java projecteuler_$1"
			lang="Java"
		;;
		
		"py" )
			cmd="python $1.py"
			lang="Python"
		;;
		
		"js" )
			cmd="node $1.js"
			lang="JavaScript"
		;;
	esac
	
	if [ -n "$lang" ]; then
		echo "  \033[34;1m$lang\033[0m\n    \033[37m$(anbexec benchmark $n_times . $cmd $3)\033[0m"
	fi
}

# take solution number as first argument and solution arguments then compile and benchmark everything
benchmark_solution () {
	cd $1
	
	echo "\n \033[32;1mBenchmarking projecteuler.net solution $1 ...\033[0m\n"

	for f in $1.*; do
		compile $f
	done
	
	echo ""
	
	for f in $1.*; do
		benchmark $1 $f "$2"
	done
	
	cd ".."
}

cd "$(dirname $0)"

benchmark_solution 1 "999 1 2 3 4 5 6 7 8 9 10"
