require 'abgabenrechner'

class BetrieblicheAltersvorsorge
 attr_reader :anlage, :zulage, :rendite, :eigenbeitrag, :ablaufleistung, :gesamt_eigenbeitrag, :rente
 attr_accessor :steuerklasse, :kosten, :anlage, :bav_pa, :debug, :verzinsung, :aufschubzeit, :rentengarantiefaktor

 def initialize(bruttojahresgehalt)
   @debug                 = false
   @kinder                = false
   @brutto_pa             = bruttojahresgehalt
   @bav_pa                = Beitragsbemessungsgrenze.new('west').bav_maximal_beitrag 
   @steuerklasse          = 1
   @verzinsung            = 2
   @aufschubzeit          = 1
   @gesamt_eigenbeitrag   = 0
   @rentengarantiefaktor  = 36.51
   @versicherungskosten   = 10000
 end




 def abgaben(bav_pa)

  rechen_brutto_pa = @brutto_pa - bav_pa

  p = {
   :lzz 	      =>  1,
   :re4 	      =>  rechen_brutto_pa*100,
   :stkl 	      =>  @steuerklasse,
   :pvz 	      =>  1, # ohne kinder weil PKZ=1
   :krv         =>  0,
   :lzzfreib    =>  bav_pa
  } 

  pe = BMF::Abgabenrechner.new(p).ausgaben
  
  @lohnsteuer 	= (pe[:lstlzz].to_i)/100
  @soli 	= (pe[:solzlzz].to_i)/100


  #maximal 7573.50 in west | 6540.75 in Ost
  @alv		= (rechen_brutto_pa/100)*1.5

  #maximal 7573.50 in west | 6540.75 in Ost
  @grv		= (rechen_brutto_pa/100)*9.95

  @gkv		= (rechen_brutto_pa/100)*8.2
  @pfv		= @kinder ? (rechen_brutto_pa/100)*0.975 : (rechen_brutto_pa/100)*1.225  


  if @debug
   puts "jahresgehalt: #{rechen_brutto_pa}"
   puts "BAV jahresbeitrag: #{bav_pa}"
   puts "lohnsteuer: #{@lohnsteuer}"
   puts "soli: #{@soli}"
   puts "alv: #{@alv.to_i}"
   puts "grv: #{@grv.to_i}"
   puts "gkv: #{@gkv.to_i}"
   puts "pfv: #{@pfv.to_i}"
  end

  return @lohnsteuer+@soli+@alv+@grv+@gkv+@pfv

 end




  def run
   @ohnebav	 = abgaben(0).to_i
   @mitbav	 = abgaben(@bav_pa).to_i
   @zulage	 = (@ohnebav - @mitbav)
   @anlage	 = @bav_pa
   @eigenbeitrag = @anlage-@zulage
   @rendite	 = (@zulage*100/@anlage)+@verzinsung
   
   invest = Investment.new
   invest.p = @verzinsung.to_f
   invest.r = @anlage
   invest.n = @aufschubzeit   
   @ablaufleistung = invest.rn.to_i - @versicherungskosten
   @gesamt_eigenbeitrag = @anlage*@aufschubzeit
   
   prozehntausend = @ablaufleistung/10000
   @rente = (prozehntausend*@rentengarantiefaktor)*12
  end




end
