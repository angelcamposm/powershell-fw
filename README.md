# powershell-fw
PowerShell-FW is a class repository for PowerShell that will allow us to speed up certain tasks.


## LOGGER.class.ps1

### About this class

This class writes a log in a log file...

### Import

Import that class with dot sourcing... (example with file stored in C:\scripts)

```powershell

. 'C:\scripts\LOGGER.class.ps1'

```

### How to use

```powershell

# Write a log with levels
$logger = [LOGGER]::New().setDaily().setLevel([LEVEL]::INFORMATIONAL).setMessage('TEST message').Write();

```

This command outputs this line:

```

[2020/09/04 1:34:11][INFORMATIONAL] TEST message

```


```powershell

# Write a log with tags
$logger = [LOGGER]::New().
    setDaily().
    addItem('wait_time', 50).
    addItem('device', 'blackbox').
    addItem('ip_address', '192.168.10.254').
    addItem('user', 'acamposm').
    Write();

```

This command outputs this line of log:

```

[2020/09/04 1:39:59] wait_time="50"; device="blackbox"; ip_address="192.168.10.254"; user="acamposm"

```
