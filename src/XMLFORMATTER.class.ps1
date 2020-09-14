Class XMLFORMATTER
{
    hidden [System.IO.StringWriter]$string_writer;
    hidden [System.Xml.XmlTextWriter]$xml_writer;
    hidden [XML]$input_xml;

    XMLFORMATTER() 
    {
        $this.string_writer = New-Object System.IO.StringWriter;

        $this.xml_writer = New-Object System.XMl.XmlTextWriter $this.string_writer;
    }

    [XMLFORMATTER] indent([int]$indent = 2) 
    {
        $this.xml_writer.Formatting = “indented”;
        $this.xml_writer.Indentation = $indent;

        return $this;
    }

    [XMLFORMATTER] setXML([XML]$xml) 
    {
        $this.input_xml = $xml;

        return $this;
    }

    [String]Get()
    {
        $this.input_xml.WriteContentTo($this.xml_writer);

        $string = $this.string_writer.ToString();

        $this.xml_writer.Flush();
        $this.string_writer.Flush();

        return $string;
    }
}
