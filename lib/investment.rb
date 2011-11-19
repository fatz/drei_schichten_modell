class Investment
  attr_accessor :p, :r, :n, :k0, :inflation
  attr_reader :i
  
  # http://page.math.tu-berlin.de/~mrenesse/agromath/fima.pdf

  # TODO
  # S0	-	Darlehen, Schuldsumme
  # Sn	-	Restschuld
  # T	  -	Tildungsrate
  # Z	  -	Zinsbetrag
  # A	  -	Annuität


  def initialize
    # p	  -	Zinssatz in Prozent
    @p = 0.0
    
    @inflation = 0.0
    
    # K0	-	Anfangskapital
    @k0 = 0

    # n	  -	Laufzeit (Jahre, Monate, Tage
    # n	  -	Anzahl der Rückzahlungsperioden
    @n = 0
  end
  

  
  # r	  -	Rente / Rate
  def r(*rate)
    if @r
      return @r
    else
      return k0*((q-1)/(qn-1))
    end
  end


  # q	  -	Aufzinsungsfaktor ( q = 1 + i )
  def q
    1+i
  end


  def qn
    q**n
  end


  # v	  -	Abzinsungsfaktor (v = 1 / q )
  def v
    1/q
  end


  # i	  -	Zinssatz ( i = p / 100 )
  def i
    (@p-@inflation)/100
  end


  # Kn	-	Endkapital zinseszinslicher Verzinsung
  def kn
    k0*qn
  end


  # Kn	-	Endkapital einfacher Verzinsung 
  def kn_einfach
    k0*(1+(i*n))
  end
  
  
  # Rn	-	Endwert der nachschüssigen Rente 
  def rn
    r*((qn-1)/(q-1))
  end


  #  Die nachschüssige Rentenbarwertformel (RBF) lautet
  def rbf
    rn*(1/qn)
  end
  
  
  # Barwert der nachschussigen ewigen Rente
  def r0
    r/i
  end
  

end



# Ein Betrag von 100 € wird bei einer einfachen Verzinsung von 2% genau drei Jahre 
# lang ausgeliehen. Die Zinszahlung soll am Ende der Laufzeit erfolgen. Wie groß ist die 
# am Ende der Laufzeit angesammelte Summe aus Kapital und Zinsen?
#invest = Investment.new
#invest.k0 = 100
#invest.p = 2.0
#invest.n = 3
#puts invest.kn_einfach.to_i



# Eine Spareinlage von 100 € wird für 4 Jahre angelegt und mit 6% verzinst. Welche 
# Höhe hat das Kapital bei zinseszinslicher Verzinsung nach 4 Jahren?
# invest = Investment.new
# invest.k0 = 100
# invest.p = 6.0
# invest.n = 4
# puts "mit zinseszinslicher Verzinsung #{invest.kn.to_i} euro "
# puts "mit einfacher Verzinsung #{invest.kn_einfach.to_i} euro "
# Bei einfacher Verzinsung ist die Kapitalsumme am Ende des mehrjährigen 
# Anlagezeitraums kleiner als bei der Zinseszinsrechnung.




# Theo Knapp bringt 5 Jahre lang einmal jährlich am Jahresende 100 € 
# zur Bank, die diese Einzahlungen bei 5% Zinseszinsen ansammelt. 
# Welcher Betrag wird Theo nach Ablauf von 5 Jahren zur Verfügung 
# stehen (Rentenendwert)?
# invest = Investment.new
# invest.p = 5.0
# invest.r = 100
# invest.n = 5
# puts "der Rentenendwert von Theo Knapp betaegt nach 5 Jahren #{invest.rn.to_i} euro "





# Aus einem Lottogewinn stehen Berta Gierig für die nächsten 10 Jahre 
# jährliche Zahlungen in Höhe von je 10.000 € zu. Welchen Wert hat dieser 
# Lottogewinn heute, wenn von 6% Zinseszinsen ausgegangen wird, d.h. 
# mit welchem Betrag könnte Berta heute ihre Rente kapitalisieren lassen 
# (Rentenbarwert)?
# invest = Investment.new
# invest.p = 6.0
# invest.r = 10000
# invest.n = 10
# puts "der Rentenbarwert von Berta Gierig betaegt #{invest.r0.to_i} euro"
# puts "Sie könnte sich also #{invest.r0.to_i} € sofort auszahlen lassen."
# puts "Der Endwert von Berta Gierigs Lottogewinn beträgt #{invest.rn.to_i} euro."






# In 18 Jahren sollen dem neugeborenen Kind Benjamin der Familie 
# Ver’Wöhn 25.000 € zur Verfügung stehen. Wie hoch müssen die 
# jährlichen Raten sein, die die Ver’Wöhns während der nächsten 18 Jahre 
# bei 5% Zinsen einzahlen müssen, damit nach 18 Jahren exakt der 
# gewünschte Betrag für Benjamin zur Verfügung steht?
# invest = Investment.new
# invest.k0 = 25000 
# invest.p = 5.0
# invest.n = 18
# puts "Familie Verwöhn müsste jährlich #{invest.r.to_i} € einzahlen, damit Benjamin nach 18 Jahren über 25.000 € verfügen kann"








