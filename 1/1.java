/*
 * 1:1 conversion of 1.anubis to Java
 *
 * by Julien Verneuil, 14/06/2015
 */

import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;

class projecteuler_1 {
    public static void print_usage() {
        System.out.println("Usage:\n    java projecteuler_1 max n1 n2 n3 ...\n\nExample:\n    java projecteuler_1 999 3 5");
    }

    public static void print_ignore_message(String s) {
        System.out.println("Parameter \"" + s + "\" ignored, not a natural number, you should fix this.");
    }

    public static int gcd(int a, int b) {
        if (a < 0) { a = -a; }
        if (b < 0) { b = -b; }
        if (b > a) { int temp = a; a = b; b = temp; }
        while (true) {
            if (b == 0) { return a; }
            a %= b;
            if (a == 0) { return b; }
            b %= a;
        }
    }

    public static int lcm(int a, int b) {
        return a * b / gcd(a, b);
    }

    public static List<Integer> signed_lcm_list(List<Integer> l) {
        if (l.isEmpty()) {
            return new ArrayList<Integer>();
        }

        int head = l.get(0);
        List<Integer> tail = l.subList(1, l.size());

        if (tail.isEmpty()) {
            List<Integer> new_l = new ArrayList<Integer>();
            new_l.add(head);
            return new_l;
        }

        List<Integer> p = signed_lcm_list(tail);
        List<Integer> r = new ArrayList<Integer>();
        r.add(head);

        for (int n : p) {
            r.add(-lcm(head, n));
        }

        r.addAll(p);

        return r;
    }

    public static int sum(int n) {
        return (n * (n + 1)) / 2;
    }

    // http://stackoverflow.com/a/22714883
    public static String join(String[] strings, String separator) {
        StringBuffer sb = new StringBuffer();
        for (int i=0; i < strings.length; i++) {
            if (i != 0) sb.append(separator);
                sb.append(strings[i]);
            }
        return sb.toString();
    }

    public static void main(String[] args) {
        int[] args_as_int = new int[args.length];

        for (int i = 0; i < args.length; i++) {
            String s = args[i];
            int n = 0;

            try {
                n = Integer.parseInt(s);
            } catch (NumberFormatException e) {
                print_ignore_message(s);

                continue;
            }

            if (n <= 0) {
                print_ignore_message(s);
            } else {
                args_as_int[i] = n;
            }
        }

        if (args_as_int.length <= 0) {
            print_usage();
        }

        double max = args_as_int[0];
        List<Integer> numbers = new ArrayList<Integer>();

        for (int i = 1; i < args_as_int.length; i++) {
            numbers.add(args_as_int[i]);
        }

        if (numbers.isEmpty()) {
            print_usage();
        }

        List<Integer> slcml = signed_lcm_list(numbers);
        int result = 0;

        for (int n : slcml) {
            result += sum((int)Math.floor(max / n)) * n;
        }

        String[] ns = new String[args.length - 1];
        ns = Arrays.copyOfRange(args, 1, args.length);

        System.out.println("The sum of all the multiples of " + join(ns, " or ") + " below " + (int)(max + 1) + " is " + result + ".");
    }
}
