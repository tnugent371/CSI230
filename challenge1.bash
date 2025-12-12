curl -s http://10.0.17.6/IOC.html |
xmllint --html --xpath "//table/tr/td[1]/text()" - 2>/dev/null > IOC.txt