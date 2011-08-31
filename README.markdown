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


## Komplette API Dokumentation:
http://goo.gl/phFdj



 


Copyright (c) 2011 Felix Faerber. See LICENSE for details.
