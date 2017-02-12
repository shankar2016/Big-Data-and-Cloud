#!/usr/bin/python2

import sys

lastword = "";
lastwc = 0;
for line in sys.stdin:
        a = line.split( );
        if len(a) < 2:
                continue;

        word = a[0] + " " + a[1];
        try:
                n = int(a[2]);
        except ValueError:
                continue;

        if word == lastword:
                lastwc = lastwc + n;
        else:
                if lastwc > 0:
                        print lastword, lastwc
                lastword = word;
                lastwc = n;


if lastwc > 0:
        print lastword, lastwc
EOF
