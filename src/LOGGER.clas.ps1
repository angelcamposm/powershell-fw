Enum Level {
    EMERGENCY
    ALERT
    CRITICAL
    ERROR
    WARNING
    NOTICE
    INFORMATIONAL
    DEBUG
}

Class LOGGER
{
    #region PROPERTIES

    hidden [string]$channel;
    hidden [bool]$daily;
    hidden [System.Collections.ArrayList]$items;
    hidden [string]$level;
    hidden [string]$message;
    hidden [string]$path;
    hidden [string]$separator;

    #endregion

    #region CONSTRUCTORS

    LOGGER()
    {
        $this.channel = 'log';
        $this.daily = $false;
        $this.items = [System.Collections.ArrayList]@()
        $this.level = $null;
        $this.message = $null;
        $this.path = 'C:\Temp\';
        $this.separator = '; ';
    }

    #endregion

    #region METHODS

    static hidden [void]checkPath([string]$path)
    {
        if (-not(Test-Path -Path $path -PathType Container)) {
            [void](New-Item -Path $path -ItemType Directory)
        }
    }
    
    hidden [string]getFileName()
    {
        if ($this.daily) {
            return "$($this.channel)_$(Get-Date -Format 'yyyy_MM_dd').log";
        }

        return "$($this.channel).log";
    }

    hidden [string]getHeader()
    {
        return '[' + $(Get-Date -Format 'yyyy/MM/dd HH:mm:ss') + ']';
    }

    hidden [string]getLevel()
    {
        if ($this.level.Length -eq 0) {
            return '';
        }

        return '[' + $this.level + ']';
    }

    hidden [string]getLogFile()
    {
        return "$($this.path)$($this.getFileName())";
    }

    hidden [string]getLogMessage()
    {
        [LOGGER]::checkPath($this.path);

        $msg = $this.getHeader();

        if (($this.getLevel()).Length -gt 0) 
        {
            $msg += $this.getLevel();
        }

        if ([string]::IsNullOrEmpty($this.message)) 
        {
            $msg += ' ' + $($this.items -join $this.separator);
        }
        else 
        {
            $msg += ' ' + $this.message;
        }

        return $msg;
    }
    
    [LOGGER]addItem([string]$item, [string]$value)
    {
        $this.items.Add($item + '="' + $value + '"');

        return $this;
    }

    [LOGGER]setChannel([string]$channel)
    {
        $this.channel = $channel;

        return $this;
    }
        
    [LOGGER]setDaily()
    {
        $this.daily = $true;

        return $this;
    }

    [LOGGER]setLevel([Level]$level)
    {
        $this.level = $level;

        return $this;
    }

    [LOGGER]setMessage([string]$message)
    {
        $this.message = $message;

        return $this;
    }
        
    [LOGGER]setPath([string]$path)
    {
        $this.path = $path + $(if ($path.EndsWith('\')) { ''; } else { '\'; })

        return $this;
    }

    [LOGGER]setSeparator([string]$separator)
    {
        $this.separator = $separator;

        return $this;
    }

    # OUTPUTS

    [void]outHost()
    {
        $this.getLogMessage() | Out-Host
    }

    [string]outString()
    {
        return $this.getLogMessage();
    }
    
    [void]Write()
    {
        $this.getLogMessage() | Out-File -FilePath $($this.getLogFile()) -Encoding utf8 -Append
    }

    #endregion
}