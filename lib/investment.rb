class Investment
  attr_accessor :jahresbeitrag, :jahre, :verzinsung, :kapitelanwuchs




def i(p)
  p/100
end

def r(i)
  1+i
end

def v(r)
  1/r
end



def z4(a,n,i)
  a*(1+n*i)
end


#Endwert mit Zinseszins: 
def z6(a,n,i)
  kapital = a
  n.times do
    kapital += kapital*i
  end
  return kapital
end







  def initialize(jahresbeitrag, jahre, verzinsung)
    @jahresbeitrag = jahresbeitrag
    @jahre = jahre
    @verzinsung = verzinsung
    @kapitelanwuchs = []
    
    kapital = 0
    jahre.times do
      kapital += (kapital/100)*verzinsung
      kapital += jahresbeitrag + (jahresbeitrag/100)*verzinsung
      kapitelanwuchs << kapital
    end
    

  end
  
end
