class CHRONO
{
    hidden [System.DateTime] $start;
    hidden [System.DateTime] $stop;

    CHRONO() {}

    [CHRONO] ChronoStart()
    {
        $this.start = Get-Date;

        return $this;
    }

    [CHRONO] ChronoStop()
    {
        if ($this.start -eq $null) {
            Exit;
        }

        $this.stop = Get-Date;

        return $this;
    }

    hidden [System.TimeSpan] GetResults()
    {
        return ($this.stop - $this.start);
    }

    [long] TimeTicks()
    {
        return ($this.GetResults()).Ticks;
    }

    [int] Seconds()
    {
        return ($this.GetResults()).Seconds;
    }

    [int] Minutes()
    {
        return ($this.GetResults()).Minutes;
    }
    
    [int] Hours()
    {
        return ($this.GetResults()).Hours;
    }
    
    [int] Days()
    {
        return ($this.GetResults()).Days;
    }

    [double] TotalMilliseconds()
    {
        return ($this.GetResults()).TotalMilliseconds;
    }

    [double] TotalSeconds()
    {
        return ($this.GetResults()).TotalSeconds;
    }

    [double] TotalMinutes()
    {
        return ($this.GetResults()).TotalMinutes;
    }

    [double] TotalHours()
    {
        return ($this.GetResults()).TotalHours;
    }
    
    [double] TotalDays()
    {
        return ($this.GetResults()).TotalDays;
    }

    [System.TimeSpan] Results()
    {
        return $this.GetResults();
    }
}
