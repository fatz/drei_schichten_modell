require 'abgabenrechner'

class BetrieblicheAltersvorsorge
 attr_reader :anlage, :zulage, :rendite, :eigenbeitrag
 attr_accessor :steuerklasse, :kinder, :kosten, :anlage, :debug

 def initialize(bruttojahresgehalt)
   @debug	 = false
   @kinder	 = false
   @brutto_pa 	 =  bruttojahresgehalt
   @bav_pa 	 =  185*12
   @steuerklasse =  1
 end




 def abgaben(bav_pa)

  p = {
   :lzz 	=>  1,
   :re4 	=>  @brutto_pa*100,
   :stkl 	=>  @steuerklasse,
   :pvz 	=>  1, # ohne kinder weil PKZ=1
   :krv         =>  0,
   :lzzfreib    =>  bav_pa
  } 

  pe = BMF::Abgabenrechner.new(p).ausgaben

  @lohnsteuer 	= pe[:lstlzz]
  @soli 	= pe[:solzlzz]


  #maximal 7573.50 in west | 6540.75 in Ost
  @alv		= (@brutto_pa/100)*1.5


  #maximal 7573.50 in west | 6540.75 in Ost
  @grv		= (@brutto_pa/100)*9.95


  @gkv		= (@brutto_pa/100)*8.2 
  @pfv		= @kinder ? (@brutto_pa/100)*0.975 : (@brutto_pa/100)*1.225  


  if @debug
   puts "jahresgehalt: #{@brutto_pa}"
   puts "BAV jahresbeitrag: #{bav_pa}"
   puts "lohnsteuer: #{@lohnsteuer}"
   puts "soli: #{@soli}"
   puts "alv: #{@alv.to_f}"
   puts "grv: #{@grv.to_f}"
   puts "gkv: #{@gkv.to_f}"
   puts "pfv: #{@pfv.to_f}"
  end


  return (@lohnsteuer+@soli+@alv+@grv+@gkv+@pfv)/100

 end




  def run
   @ohnebav	 = @brutto_pa - abgaben(0).to_i
   @mitbav	 = @brutto_pa - abgaben(@bav_pa*100).to_i

   @zulage	 = (@mitbav - @ohnebav)
   @anlage	 = @bav_pa
   @eigenbeitrag = @anlage-@zulage
   
   @rendite	 = @zulage*100/@anlage

  end




end
