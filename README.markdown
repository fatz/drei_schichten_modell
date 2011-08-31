# abgabenrechner

drei_schichten_modell.gem ist ein programm zu berechnung der zulagen.


## Installation
Add this line to your Gemfile:

```
gem 'drei_schichten_modell'
```



```ruby
require 'rubygems'
require 'drei_schichten_modell'

parameter = { 
  :lzz => 1, 
  :re4 => 2600000, 
  :stkl => 1, 
  :r => 1 
}

abgabenrechner = BMF::Abgabenrechner.new(parameter)
puts abgabenrechner.ausgaben.inspect # => {:solzs=>0, :bk=>313700, :solzv=>0, :bks=>0, :sts=>0, :bkv=>0, :stv=>0, :lstlzz=>313700, :solzlzz=>17253}
puts abgabenrechner.ausgaben[:lstlzz] # => 313700

puts abgabenrechner.xml => 
```
```xml
<lohnsteuer jahr="2011">
    <eingaben>
        <eingabe name="R" value="1" status="ok" />
        <eingabe name="STKL" value="1" status="ok" />
        <eingabe name="RE4" value="2600000" status="ok" />
        <eingabe name="LZZ" value="1" status="ok" />
    </eingaben>
    <ausgaben>
        <ausgabe name="BK" value="313700" />
        <ausgabe name="BKS" value="0" />
        <ausgabe name="BKV" value="0" />
        <ausgabe name="LSTLZZ" value="313700" />
        <ausgabe name="SOLZLZZ" value="17253" />
        <ausgabe name="SOLZS" value="0" />
        <ausgabe name="SOLZV" value="0" />
        <ausgabe name="STS" value="0" />
        <ausgabe name="STV" value="0" />
    </ausgaben>
</lohnsteuer>
```




## Komplette API Dokumentation:
http://goo.gl/phFdj



 


Copyright (c) 2011 Felix Faerber. See LICENSE for details.
