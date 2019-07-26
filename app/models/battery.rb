class Battery < ApplicationRecord
  has_many :power_supplies

  TECHNOLOGIES = [
    "Lead acid - Flooded / 0PzS",
    "Lead acid - Sealed GEL / 0PzV",
    "Lead acid - Sealed AGM",
    "Lithium"
  ]

  validates :technology, inclusion: {in: TECHNOLOGIES, allow_blank: true}, presence: true
  validates :dod, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100, allow_nil: true}, presence: true
  validates :efficiency, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100, allow_nil: true}, presence: true
  validates :voltage, numericality: {greater_than_or_equal_to: 0, allow_nil: true}, presence: true
  validates :capacity, numericality: {greater_than_or_equal_to: 0, allow_nil: true}, presence: true

  monetize :price_min_cents, with_model_currency: :currency
  monetize :price_min_eur_cents, with_currency: :eur, allow_nil: true

  monetize :price_max_cents, with_model_currency: :currency
  monetize :price_max_eur_cents, with_currency: :eur, allow_nil: true

  def price_min_eur_cents
    if price_min and Money.default_bank.get_rate(currency, :EUR)
      price_min.exchange_to(:EUR).fractional
    end
  end

  def price_max_eur_cents
    if price_max and Money.default_bank.get_rate(currency, :EUR)
      price_max.exchange_to(:EUR).fractional
    end
  end

  def name
    "#{technology} - #{voltage} V | #{capacity} Ah"
  end

end
