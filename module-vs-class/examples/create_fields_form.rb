class CreateFieldsForm < Web::BaseSchema
  include TariffCalculator
  include DadataFields
  include WebDefaults
  include FormExistence
  include CodeNumberCheck
  include VerificationFields
  include CrmpRequest
  include PartnerData

  def form_data
    return nil unless valid?

    @form_data = fields_data.merge(
      address_de_facto: dadata_field(:address_de_facto),
      ...
      cash_loan_monthly_payment: monthly_payment_for_tariff,
      tariff: tariff.external_id,
      ...
    )

    with_web_default_fields(@form_data, sales_channel_id)
  end
end

module CrmpRequest
  using ToBoolean

  def crmp?(request_data = {})
    request_data[:crmp].to_bool || sales_channel_id.to_i == 5
  end
end


module FormExistence
  def form_exists?(form_id)
    form_id && CashCore::Form.where(id: form_id).exists?
  end

  def form_exist_errors
    {
      errors: {
        form_id: I18n.t(:exists, scope: 'errors.messages'),
      },
    }
  end
end

module WebDefaults
  ALLOWED_SALES_CHANNEL_IDS = [2, 3, 5, 9]

  def with_web_default_fields(raw_params, sales_channel_id)
    return raw_params unless sales_channel_id.to_i.in?(ALLOWED_SALES_CHANNEL_IDS)

    raw_params.dup.reverse_merge!(
      {
        tariff_name: tariff_name(raw_params[:tariff_default]),
      }
    )
  end

  private

  def tariff_name(tariff_default)
    tariff_default&.downcase == 'партнерский' ? 'Партнерский' : 'Гибрид'
  end
end
