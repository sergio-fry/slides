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

# Intro 

  * Form
  * Field
  * Strategy
  * ABAC
  * Search
  * Validation
  * HTTP API

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


  Core --> Configuration
}
database DB
Core -up-> DB

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

# Спасибо!

