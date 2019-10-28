#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import sys
import os
import hashlib


def main():
    user = sys.argv[1].strip()
    passwd = hashlib.sha1(sys.argv[2].strip()).hexdigest()
    print '%s\n%s' % (user, passwd)



if __name__ == '__main__':

    if ( len(sys.argv) != 3 ):
        print '[x] Usage: python2 gen_account.py username password'
        sys.exit(1)
    main()
