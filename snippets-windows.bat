# shutdown in 7200 seconds (2 hours)
shutdown /s /t 7200
# abort with:
shutdown /a

# for some reason the GUI doesn't always show exFAT as an alternative when formatting
# use command line to format volumes as exFAT
format M: /FS:exFAT
