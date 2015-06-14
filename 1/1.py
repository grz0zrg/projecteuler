# 1:1 conversion of 1.anubis to Python (2.x)

# by Julien Verneuil, 14/06/2015

from fractions import gcd
from sys import argv
from sys import exit

def print_usage():
    print("Usage:\n    python 1.py max n1 n2 n3 ...\n\nExample:\n    python 1.py 999 3 5")

def print_ignore_message(s):
    print("Parameter \"" + s + "\" ignored, not a natural number, you should fix this.")

def lcm(a, b):
    return (a * b // abs(gcd(a, abs(b))))

def n_sum(n):
    return (n * (n + 1)) // 2

def signed_lcm_list(l):
    if not l:
        return []
    head, tail = l[0], l[1:]
    if not tail:
        return [head]
    p = signed_lcm_list(tail)
    new_l = [head]
    new_l.extend([-lcm(head, x) for x in p])
    new_l.extend(p)
    return new_l

args_as_int = []

for arg in argv[1:]:
    try:
        n = int(arg)
        if n <= 0:
            raise ValueError()

        args_as_int.append(int(arg))
    except ValueError:
        print_ignore_message(arg)

if len(args_as_int) <= 1:
    print_usage()
    exit(0)

max = args_as_int.pop(0)

slcml = signed_lcm_list(args_as_int)
result = []

for n in slcml:
    result.append(n_sum(max // n) * n)

result = sum(result)

print("The sum of all the multiples of " + " or ".join(argv[2:]) + " below " + str(max + 1) + " is " + str(result))
