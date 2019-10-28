#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import sys
import os
import hashlib
import re
from datetime import datetime


def get_time():
    t = datetime.now()
    return '%s-%s-%s %s:%s:%s' % ( str(t.year).zfill(2), str(t.month).zfill(2), str(t.day).zfill(2), str(t.hour).zfill(2), str(t.minute).zfill(2), str(t.second).zfill(2) )


def verify(ver_file, user, passwd):
    with open(ver_file, 'r') as f: tmp = f.readlines()

    tmp = ''.join(tmp)
    tmp = tmp.strip()
    # replace 3 or more 'new line' to 3 'new line'
    tmp = re.sub("\n{2,}", '\n\n\n', tmp)
    tmp = tmp.split('\n\n\n')
    
    check = '%s\n%s' % (user.strip(), passwd.strip())
    checked = False

    for i in tmp:
        if ( check == i.strip() ):
            print '%s [*] User "%s" authentication success' % (get_time(), user)
            checked = True
            break

    if (not checked):
        print '%s [x] User "%s" authentication failed' % (get_time(), user)
        sys.exit(1)




def main():
    # print sys.argv
    ver_file = sys.argv[1].strip()
    target_file = sys.argv[2].strip()

    if ( (not(os.path.exists(ver_file))) or (not(os.path.exists(target_file))) ):
        print '%s [x] secret file or target file not exists!' % (get_time())
        sys.exit(1)


    with open(target_file, 'r') as f: target_file = f.readlines()
    user = target_file[0].strip()
    passwd = target_file[1].strip()
    passwd = hashlib.sha1(passwd).hexdigest()
    del target_file

    verify(ver_file, user, passwd)



if __name__ == '__main__':

    if ( len(sys.argv) != 3 ):
        print '%s [x] Usage: python2 verify.py secret.txt target_file' % (get_time())
        sys.exit(1)
    main()
