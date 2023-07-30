---
paginate: true
class: lead
marp: true
---
<style>
  section {
  }
  h1,body,li,p { color: black; }

  h1 {
    text-decoration: underline;
    text-decoration-color: #FF5028;
    text-underline-offset: 0.3em;
    text-decoration-thickness: 0.1em;
    padding-bottom: 0.3em;
  }
  img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    max-width: 90%;
    max-height: 70%;
  }
</style>
<!--
_paginate: false
_class: lead
-->


# Core

Сергей Удалов

---

# Core 

* Form
* Field
* Strategy
* ABAC
* Validation

---

# Form

---

# Field

```ruby
{ name: :name, required: true, validators: [CamelCasedStringValidator] },
{ name: :age, required: true, validators: [NummericValidator, AgeValidator] },
```

---

# ABAC. CRUD notation

go_agent.acl
```
abroad_insurance_photo:CRU
additional_info_step_done:CRU
additional_monthly_income:CRU
additional_phone:CRU
address_de_facto:CRU
agreement_for_additional_services:CRU
anketa_verification_sent_at:CU
approved_rate_gybrid:R
...
```

---

# ABAC. Scope

```ruby
# form_policy.rb
def go_agent(invoker:, scope:)
  form_statuses = ['new', 'initial', 'refinement', nil]
  scope = scope.where(form_status: form_statuses)
end
```

---

# Strategy

```ruby
class AgeCheck < Strategy
  FIELDS = %w( age )

  def call(payload)
    if payload[:age] < 18
      apply_strategy form_status: :declined
    else
      apply_strategy
    end
  end
end
```

---

# Product

* Auth (Gatekeeper)
* Strategies
* Configs
* Search
* Tariffs
* HTTP API
* Front2

---

# Product

```plantuml
package "Product" {
  component Core {
  }

  component Configuration {
    [Fields]
    [Timeouts]
    [Retries]
    [ABAC]
  }

  [NBKIStrategy]
  [MegafonStrategy]
  [DocumentsStrategy]

  [Tariffs]

  [Unloads]

  Core --> Configuration
}
database Postgres as DB

Core -up-> DB
Tariffs --> DB

database Clickhouse
DB --> Clickhouse: sync
Unloads --> Clickhouse

() BankProxy
Unloads --> BankProxy

cloud Bank
BankProxy --> Bank

() HTTP
HTTP -- Core

rectangle "Megafon"
MegafonStrategy <--> Megafon: RMQ

rectangle DataHunter
NBKIStrategy <--> DataHunter: RMQ

rectangle Bumaga
DocumentsStrategy --> Bumaga: HTTP

```

---

# Tariffs

```csv
product,name,starts_at,ends_at,channel,insurance_sj,insurance_ramk,risk_grade,min_amount,max_amount,term,commission_income,cof,axp,min_rate,max_rate,min_roa_kharitonov,min_product_amount,max_product_amount,comm_new,discount_gibrid,loan_purpose
Кредит Наличными,Базовый,2019-08-01,2019-11-14,ДО/МАБ,нет,нет,MA,500,30000,12,0,7.9,2.42,14.9,19.9,4,500,30000,1.8,0,
Кредит Наличными,Базовый,2019-08-01,2019-11-14,ДО/МАБ,нет,нет,MA,500,30000,13,0,7.9,2.42,14.9,19.9,4,500,30000,1.8,0,
```

---

# Tariffs

```ruby
def tariffs
  suitable_tariffs = References::CashLoanTariff
    .suitable(
      term_request: loan_term_request,
      amount_request: loan_amount_request,
      channel: payload[:sales_channel],
      loan_purpose: payload[:loan_purpose],
    )

  suitable_tariffs = suitable_tariffs.where(name: tariff_name) if payload[:tariff_name].present?

  @tariffs ||= Array.wrap(
    suitable_tariffs
      .select { |tariff| tariff.insurance_sj == insurance_sj? && tariff.insurance_ramk == insurance_ramk? }
      .min_by(&:min_rate)
  )
end
```


---

# State Strategies

```ruby
aasm do
  state :initial, strategies: [
    'AgeCheck' => {}
  ], initial: true
  state :duplicated
  state :processing, strategies: [
    'PassportVerification' => {},
    'FNSVerification' => {},
  ]
  state :approved, strategies: [
    'SMSNotification' => {},
  ]
end
```

<!--
Strategy runs only if required state is active
-->


---

```plantuml
@startuml
skinparam dpi 300


[*] --> initial

initial : *CheckDuplicate
initial : *External::QFD::PersonalDataAgreement
  
processing : *Setters::VerificationCallRulesSetter
processing : External::Verification::Underwriter
processing : External::QFD::PersonalDataAgreement
processing : External::Verification::PassportCheck::FirstPage::Producer
processing : External::Verification::PassportCheck::FirstRegistrationPage::Producer
processing : External::Verification::PassportCheck::IssuerPage::Producer
processing : External::Verification::Underwriter
processing : ApprovedRateCalculator
  
refinement : BkiAgreementCheck
refinement : ApprovedRateCalculator
  
deal : PrintForms::JurisdictionInsurance::Strategy
deal : Setters::DealRenewal::Setter
  
refused : External::Cft::ShortDecline::Producer
refused : External::Questions::CancelCall::Producer
  
client_approved : ApprovedRateCalculator
client_approved : *BankDealApprove
  
client_refuse : External::Cft::ShortDecline::Producer
client_refuse : External::Questions::CancelCall::Producer
  

client_approved -[bold]-> deal: deal
client_approved -[dashed]-> refused: refuse
deal -[dashed]-> loan_issued: issue
initial -[bold]-> processing: process
initial -[dashed]-> duplicate: dupicate
processing -[bold]-> client_approved: approve
processing -[dashed]-> client_refuse: refuse
processing -[dashed]-> refinement: request_refinement


@enduml
```
---

# Core 3

---

# Спасибо!

