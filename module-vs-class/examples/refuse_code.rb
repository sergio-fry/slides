module PersistentCcRefuseCode
  CODE = 'MR006С'

  def current_cc_refuse_code
    payload[:credit_card_refuse_code]
  end

  def persistent_cc_refuse_code?
    current_cc_refuse_code == CODE
  end

  def changeable_cc_refuse_code?
    !persistent_cc_refuse_code?
  end
end

