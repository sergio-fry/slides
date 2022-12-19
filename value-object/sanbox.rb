Money = Data.define(:amount, :unit)
a = Money.new(1, 'USD')
b = Money.new(1, 'USD')
a == b # true
