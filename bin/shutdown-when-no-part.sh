#!/bin/bash -ex
# Useful to automatically shut down the computer when BitTorrent downloads finishes

while find . -name '*.part' -print -quit | grep -q 'part'; do
  sleep 10
  date
done

sleep 10
shutdown now
