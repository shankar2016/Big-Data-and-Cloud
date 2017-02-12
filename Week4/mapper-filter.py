#!/usr/bin/python2

import sys

lastword = "";
lastwc = 0;

for line in sys.stdin:

        a = line.split( );
        if len(a) < 4:
                continue;

        word1= a[0]
        word2= a[1]
        if not a[0].isalpha() or not a[1].isalpha():
                continue;

        word = a[0] + " " + a[1];
        try:
                n = int(a[3]);
        except ValueError:
                continue;
        print word, "\t", n
EOF
