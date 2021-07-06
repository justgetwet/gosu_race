class OtherBettor

  def toss
    rand(2) + 1
  end

  def roll
    rand(6) + 1
  end

end


class Bettor

	attr_accessor :hit_rate

	def initialize
		# @payout
	end

	def betting(odds, bet_money)
		@payout = 0
		r = rand(100).to_f
		@payout = bet_money * odds if r < @hit_rate * 100
		return @payout.to_i
	end

end

class Race

	attr_accessor :house_edge
  attr_reader :bets, :white_odds, :black_odds

	def initialize
    bettors = OtherBettor.new
		@house_edge = 0.0
		@bets = []
		1000.times do
			bet = bettors.toss
			@bets << bet
		end
	end

	def calc_odds
		all_bets = @bets.size.to_f
		white_bets = @bets.count(1)
		black_bets = @bets.count(2)
		@white_odds = (1 - @house_edge) / (white_bets / all_bets)
		@black_odds = (1 - @house_edge) / (black_bets / all_bets)
	end

	def show_odds
		print("*** Odds bulletin board ***\n")
		print("white: #{@white_odds.round(2)}  ")
		print("black: #{@black_odds.round(2)}\n")
		print("***************************\n")
	end

end

race = Race.new
race.calc_odds
p race.white_odds
p race.black_odds

# bettor = Bettor.new
# bettor.hit_rate = 0.8
# bet_money = 1000
# total_balance = 0
# 10.times do
# 	balance = 0
# 	100.times do
# 		race = Race.new
# 		race.house_edge = 0.3
# 		race.calc_odds
# 		odds = race.white_odds
# 		payout = bettor.betting(odds, bet_money)
# 		balance += (payout - bet_money)
# 	end
# 	p balance
# 	total_balance += balance
# end
# p '*****'
# p total_balance