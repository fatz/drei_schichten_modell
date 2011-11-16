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

  @inflation = 0
  
  # K0	-	Anfangskapital
  @k0 = 0
  
  # n	  -	Laufzeit (Jahre, Monate, Tage
  # n	  -	Anzahl der Rückzahlungsperioden
  @n = 0
  
  # r	  -	Rente / Rate
  def r(*rate)
    if @r
      return @r
    else
      return k0*((q-1)/(qn-1))
    end
  end

  # p	  -	Zinssatz in Prozent
  @p = 0.0
  
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
    @p/100
  end

  # Kn	-	Endkapital
  def kn
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
    rn*(1/qn) 
  end
  
  

end





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



# Dem selbständigen Marktforscher Kain Risiko werden aus einer 
# Lebensversicherung an seinem 65. Geburtstag 100.000 € ausgezahlt. 
# Diesen Betrag möchte Kain Risiko verrenten. Er legt ihn zu 6% 
# Zinseszinsen bei einer Bank mit der Maßgabe an, ihm jährlich 10.000 €
# auszuzahlen. Wie lange dauert es, bis das Kapital aufgezehrt ist 
# (Rentendauer)?








