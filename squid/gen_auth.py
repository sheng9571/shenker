#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import sys
import os
import hashlib
import re
import subprocess
from datetime import datetime


def get_time():
    t = datetime.now()
    return '%s-%s-%s %s:%s:%s' % ( str(t.year).zfill(2), str(t.month).zfill(2), str(t.day).zfill(2), str(t.hour).zfill(2), str(t.minute).zfill(2), str(t.second).zfill(2) )


def gen(sec_file, htp_passwd):
    with open(sec_file, 'r') as f: tmp = f.readlines()

    tmp = ''.join(tmp)
    tmp = tmp.strip()
    # replace 3 or more 'new line' to 3 'new line'
    tmp = re.sub("\n{2,}", '\n\n\n', tmp)
    tmp = tmp.split('\n\n\n')
    first = True
    
    for i in tmp:
        i = i.strip().split('\n')
        if ( len(i) > 1 ):
            user = i[0].strip()
            # passwd = hashlib.sha256(i[1].strip()).hexdigest()
            passwd = i[1].strip()

            if (first):
                cmd = '$(which htpasswd) -c -b %s %s %s' % (htp_passwd, user, passwd)
                first = False
            else:
                cmd = '$(which htpasswd) -b %s %s %s' % (htp_passwd, user, passwd)
            p = subprocess.Popen(cmd, shell = True)
            p.communicate()

def main():
    # print sys.argv
    sec_file = sys.argv[1].strip()
    htp_file = sys.argv[2].strip()

    if ( os.path.isfile(sec_file) ):
        cmd = 'touch %s' % sec_file
        p = subprocess.Popen(cmd, shell = True)
        p.communicate()

    # if ( os.path.isfile(htp_file) ):
    #     cmd = 'touch %s' % htp_file
    #     p = subprocess.Popen(cmd, shell = True)
    #     p.communicate()

        
    gen(sec_file, htp_file)



if __name__ == '__main__':

    if ( len(sys.argv) != 3 ):
        print '%s [x] Usage: python2 gen_auth.py secret_file htpasswd_file' % (get_time())
        sys.exit(1)
    main()
