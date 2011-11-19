class Beitragsbemessungsgrenze
  
  def initialize(ostwest)
    
    @grenzen = {
      2011 => { 'west' => 66000, 'ost' => 57600 },
      2012 => { 'west' => 67200, 'ost' => 57600 }
    }
    
    @ostwest = ostwest
    @jahr = Time.now.year 
  end
  
    
  def grv(bruttojahresgehalt)
      return bruttojahresgehalt > @grenzen[@jahr][@ostwest] ? @grenzen[@jahr][@ostwest] : bruttojahresgehalt
  end
  
  
  def bav_maximal_beitrag
    return @grenzen[@jahr][@ostwest]/100*4
  end
  
  
end