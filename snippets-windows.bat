# shutdown in 7200 seconds (2 hours)
shutdown /s /t 7200
# abort with:
shutdown /a

# for some reason the GUI doesn't always show exFAT as an alternative when formatting
# use command line to format volumes as exFAT
format M: /FS:exFAT /Q

# disable driver signature enforcement
bcdedit -set loadoptions DISABLE_INTEGRITY_CHECKS
bcdedit -set TESTSIGNING ON

# re-enable driver signature enforcement
bcdedit -set loadoptions ENABLE_INTEGRITY_CHECKS
bcdedit -set TESTSIGNING OFF
