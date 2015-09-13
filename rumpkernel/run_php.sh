#!/bin/bash

cd /home/vagrant/rumprun-packages/php
make
rumpbake xen_pv bin/php-cgi.bin bin/php-cgi
rumpbake xen_pv bin/phpi.bin bin/php

sudo /home/vagrant/rumprun/app-tools/rumprun xen \
  -d \
  -n inet,static,10.100.199.37/24 \
  -b images/data.iso,/data \
  -b images/stubetc.iso,/etc \
  -e PHP_FCGI_MAX_REQUESTS=0 \
  -- bin/php-cgi.bin -b 8000

