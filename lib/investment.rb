class Investment
  attr_accessor :jahresbeitrag, :jahre, :verzinsung, :kapitelanwuchs


  def initialize(jahresbeitrag, jahre, verzinsung)
    @jahresbeitrag = jahresbeitrag
    @jahre = jahre + 1
    @verzinsung = verzinsung
    @kapitelanwuchs = []
    
    kapital = 0
    jahre.times do
      kapital += kapital/100*verzinsung
      kapital += jahresbeitrag + jahresbeitrag/100*verzinsung
      kapitelanwuchs << sprintf("%0.2f", kapital)
    end
    
  end
  
end
