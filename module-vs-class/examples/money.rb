module MoneyMath
  def self.round_to_cents(cents)
    return if cents.nil?

    cents.to_i / 100 * 100
  end

  # 100.00 -> 100_00
  def self.to_cents(amount)
    return if amount.nil?

    (amount.to_f * 100).to_i
  end

  def self.to_rubs(amount)
    return if amount.nil?

    amount.to_f / 100
  end

  # 5_000_00 -> 5 000
  def self.to_hundreds(amount)
    return if amount.nil?

    amount.to_i / 100
  end
end

