 // 1:1 conversion of 1.anubis to JavaScript
 
 // by Julien Verneuil, 14/06/2015

"use strict";

function print_usage() {
    console.log("Usage (with nodejs):\n    node 1.js max n1 n2 n3 ...\n\nExample:\n    node 1.js 999 3 5");
}

function gcd(a, b) {
    if (a < 0) { a = -a; }
    if (b < 0) { b = -b; }
    if (b > a) { var temp = a; a = b; b = temp; }
    while (true) {
        if (b == 0) { return a; }
        a %= b;
        if (a == 0) { return b; }
        b %= a;
    }
}

function lcm(a, b) {
    return a * b / gcd(a, b);
}

function signed_lcm_list(l) {
    if (l.length <= 0) {
        return [];
    }

    var head = l[0],
        tail = [];

    for (var i = 1; i < l.length; i += 1) {
        tail[i - 1] = l[i];
    }

    if (tail.length <= 0) {
        return [head];
    }

    var p = signed_lcm_list(tail),
        r = [head];
    
    for (var i = 0; i < p.length; i += 1) {
        r.push(-lcm(head, p[i]));
    }

    r = r.concat(p);

    return r;
}

function sum(n) {
    return (n * (n + 1)) / 2;
}

var argv = process.argv,
    args = [],
    args_as_int = [];

for (var i = 2; i < argv.length; i += 1) {
    args[i - 2] = argv[i];
}

for (var i = 0; i < args.length; i += 1) {
    var n = parseInt(args[i], 10);

    if (n <= 0 || isNaN(n)) {
        console.log("Parameter \"" + s + "\" ignored, not a natural number, you should fix this.");
    } else {
        args_as_int.push(n);
    }
}

if (args_as_int.length <= 0) {
    print_usage();
}

var max = args_as_int[0],
    numbers = [];

for (var i = 1; i < args_as_int.length; i += 1) {
    numbers[i - 1] = args_as_int[i];
}

if (numbers.length <= 0) {
    print_usage();
}

var slcml = signed_lcm_list(numbers),
    result = 0;

for (var i = 0; i < slcml.length; i += 1) {
    var n = slcml[i];

    result += sum(Math.floor(max / n)) * n;
}

console.log("The sum of all the multiples of " + args.join(" or ") + " below " + (max + 1) + " is " + result + ".");
