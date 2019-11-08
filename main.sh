#!/bin/bash

# Removes repeat offenders from list

cat badEggs.txt|sort|uniq -u|wc -l
cat badEggs.txt |sort |uniq -u > badEggs.txt

# Reads from concurrent file called "badEggs.txt", which is where the list of IPs is located 

touch whoDaBadEggsAre.txt
file="badEggs.txt"
  while IFS= read -r line
  do
    i=$((i+1))
    echo $i
    printf "%s belongs to\n" "$line" 2> /dev/null >> whoDaBadEggsAre.txt
    whois $line | sed '23,$d'| sed '/^%/ d'| sed '/^#/ d' >> whoDaBadEggsAre.txt
    printf "_________________________________________________________________\n" >> whoDaBadEggsAre.txt
  done<$file

## Please be aware that even though I tried to redirect stderr to /dev/null, It still throws a whois warning
## BUT it does still work.
