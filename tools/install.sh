wget --no-check-certificate https://github.com/sergeylukin/cfgmock/archive/master.zip -O cfgmock.zip
unzip ./cfgmock.zip && rm -f ./cfgmock.zip
cp ./cfgmock-master/bin/cfgmock.sh /usr/local/bin/cfgmock
chmod +x /usr/local/bin/cfgmock
rm -fr ./cfgmock-master
