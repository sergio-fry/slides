rectangle "Баланс-Платформа" {
  package "Проект" as Project {
    rectangle Python
    rectangle Ruby
    rectangle PHP
  }
  rectangle "Аналитика" as Analytics
  database ClickHouse
  rectangle "Отчеты" as Reports
  actor "Саппорт" as Support
  actor "Аналитик" as Risk
}

cloud "Банк" as bank {
  database "Oracle" as bank.db
  actor "Сотрудник" as bank.operator
}

Ruby --> Analytics: RPC
Python --> Analytics: RPC
PHP --> Analytics: RPC


Analytics --> ClickHouse: write
Reports --> ClickHouse: read
Reports --> Support: HTTP
Risk --> ClickHouse: SQL

Reports --> bank.db: bank_proxy
Reports --> bank.operator: HTTP

