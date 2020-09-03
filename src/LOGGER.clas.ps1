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
    hidden [bool]$daily;
    hidden [System.Collections.ArrayList]$items;
    hidden [string]$level;
    hidden [string]$message;
    hidden [string]$path;

    LOGGER()
    {
        $this.daily = $false;
        $this.items = [System.Collections.ArrayList]@()
        $this.level = $null;
        $this.message = $null;
        $this.path = 'C:\Temp\';
    }

    [LOGGER]addItem([string]$item)
    {
        $this.items.Add("$($item)");

        return $this;
    }

    static hidden [void]checkPath([string]$path)
    {
        if (-not(Test-Path -Path $path -PathType Container)) {
            [void](New-Item -Path $path -ItemType Directory)
        }
    }
    
    hidden [string]getFileName()
    {
        if ($this.daily) {
            return 'incidencias_' + $(Get-Date -Format 'yyyy_MM_dd') + '.log';
        }

        return 'incidencias.log';
    }
    
    hidden [string]getHeader()
    {
        return '[' + $(Get-Date -Format 'yyyy/MM/dd H:mm:ss') + ']';
    }

    hidden [string]getLevel()
    {
        if ($this.level.Length -eq 0) {
            return '';
        }

        return '[' + $this.level + ']';
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

    [void]Write()
    {
        [LOGGER]::checkPath($this.path);

        $msg = $this.getHeader();

        if (($this.getLevel()).Length -gt 0) 
        {
            $msg += $this.getLevel();
        }

        if ([string]::IsNullOrEmpty($this.message)) 
        {
            $msg += ' ' + $($this.items -join '; ');
        }
        else 
        {
            $msg += ' ' + $this.message;
        }

        $msg | Out-File -FilePath $($this.path + $this.getFileName()) -Encoding utf8 -Append
    }
}