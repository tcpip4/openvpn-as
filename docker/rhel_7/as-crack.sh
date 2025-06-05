#!/bin/bash
##OpenvpnAS-Crack
cp -r /usr/local/openvpn_as/lib/python/pyovpn-2.0-py3.8.egg   /mnt/
cd /mnt && unzip -q -o /mnt/pyovpn-2.0-py3.8.egg
cd pyovpn/lic/
mv uprop.pyc uprop2.pyc

cat > /mnt/pyovpn/lic/uprop.py << EOF
from pyovpn.lic import uprop2
old_figure = None
def new_figure(self, licdict):
    ret = old_figure(self, licdict)
    ret['concurrent_connections'] = 9999
    return ret
for x in dir(uprop2):
    if x[:2] == '__':
        continue
    if x == 'UsageProperties':
        exec('old_figure = uprop2.UsageProperties.figure')
        exec('uprop2.UsageProperties.figure = new_figure')
    exec('%s = uprop2.%s' % (x, x))
EOF

/opt/rh/rh-python38/root/usr/bin/python3.8 -O -m compileall /mnt/pyovpn/lic/uprop.py
mv __pycache__/uprop.*.pyc uprop.pyc
cd /mnt && zip -rq pyovpn-2.0-py3.8.egg-1 ./pyovpn ./EGG-INFO ./common
\cp ./pyovpn-2.0-py3.8.egg-1 /usr/local/openvpn_as/lib/python/pyovpn-2.0-py3.8.egg
