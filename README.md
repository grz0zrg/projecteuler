###Solutions to problems at [projecteuler.net](http://projecteuler.net)###

Done for fun and to benchmark the [Anubis programming language](http://fr.wikipedia.org/wiki/Anubis_%28langage%29) against other programming languages

======

>Result of a benchmark run for the first problem on a "x64 Ubuntu™ Intel® Q6600® quad-core" machine, each programs are executed 10000 times
>Note: Java benchmark is useless because the time shown is taking into account the Virtual Machine initialization which is known to be slow and the Javascript benchmark may as well have the same flaw due to the way the benchmarking process is done... also the JavaScript/Java solution don't use big integer thus the result is potentially slower in reality for these programming languages, this benchmark is not exactly representative of the performance of each programming language but can give a hint.

|  language  	| average time (ms) 	|
|:----------:	|:-----------------:	|
|   Haskell  	|         3         	|
|   Anubis   	|         9         	|
|   Python   	|         30        	|
| JavaScript 	|         61        	|
|    Java    	|        118        	|

