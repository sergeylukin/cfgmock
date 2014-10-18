wget --quiet --no-check-certificate https://github.com/sergeylukin/cfgmock/archive/master.zip -O cfgmock.zip
unzip ./cfgmock.zip &> /dev/null && rm -f ./cfgmock.zip
chmod +x cfgmock-master/test/test.sh cfgmock-master/bin/cfgmock.sh
cfgmock-master/test/test.sh
rm -fr ./cfgmock-master
