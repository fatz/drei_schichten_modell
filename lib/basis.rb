require 'rubygems'
require 'abgabenrechner'

class Basis
 
 attr_reader :anlage, :zulage, :eigenbeitrag, :rendite, :ablaufleistung, :gesamt_eigenbeitrag, :rente
 attr_writer :debug, :steuerklasse, :basis_pa, :verzinsung, :aufschubzeit, :rentengarantiefaktor


 def initialize(bruttojahresgehalt)
  @debug	      = false
  @brutto_pa 	  = bruttojahresgehalt
  @basis_pa 	  = 20000
  @steuerklasse = 1
  @plusdings 	  = 50   # damit das ergebis besser stimmt
  @verzinsung   = 2
  @aufschubzeit = 1
  @gesamt_eigenbeitrag = 0
  @rentengarantiefaktor = 36.51
  @versicherungskosten  = 10000

 end





 def run

  @lzzfreib	 = (@basis_pa/100)*72


  p1 = {
   :lzz 	    => 1,
   :re4 	    => @brutto_pa*100,
   :stkl	    => @steuerklasse,
   :r 		    => 0,
   :lzzfreib 	=> @lzzfreib*100,
   :krv 	    => 0
  }
  p1e = BMF::Abgabenrechner.new(p1).ausgaben


  p2 = {
   :lzz  	    => 1,
   :re4  	    => @brutto_pa*100,
   :stkl 	    => @steuerklasse,
   :r	 	      => 0,
   :lzzfreib 	=> 0,
   :krv 	    => 0
  }
  p2e = BMF::Abgabenrechner.new(p2).ausgaben


   @zulage 	= ((p2e[:lstlzz]-p1e[:lstlzz])/100)+@plusdings
   @anlage 	= @basis_pa
   @rendite	= (@zulage*100)/@basis_pa
   @eigenbeitrag= @anlage-@zulage

   invest = Investment.new
   invest.p = @verzinsung.to_f
   invest.r = @anlage
   invest.n = @aufschubzeit   
   @ablaufleistung =     invest.rn.to_i-@versicherungskosten
   @gesamt_eigenbeitrag = @anlage*@aufschubzeit

   prozehntausend = @ablaufleistung/10000
   @rente = (prozehntausend*@rentengarantiefaktor)*12

   if @debug
      puts "#{((p2e[:lstlzz]-p1e[:lstlzz])/100)+@plusdings} euro forderung"
      puts "#{@basis_pa} euro gehen in die anlage"
      puts "#{(p2e[:lstlzz]-p1e[:lstlzz])/@basis_pa}% Rendite"
   end

  end












end
