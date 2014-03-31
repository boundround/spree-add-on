class Spree::AddOn < ActiveRecord::Base
  # attr_accessible :description, :name, :type, :default, :prices_attributes, :expiration_days, :default_price

  belongs_to :product, class_name: 'Spree::Product'  
  has_one :default_price, -> { where currency: Spree::Config[:currency] }, class_name: 'Spree::AddOnPrice', dependent: :destroy, autosave: true
  
  delegate_belongs_to :default_price, :display_amount, :amount, :amount=, :currency

  has_many :prices,
    class_name: 'Spree::AddOnPrice',
    dependent: :destroy,
    inverse_of: :add_on

  accepts_nested_attributes_for :prices, allow_destroy: true

  scope :default, -> { where(default: true) }

  def price_in(currency)
    prices.where(currency: currency).first || self.build_default_price(currency: currency)
  end

  def self.types
    Rails.application.config.spree.add_ons
  end

  def self.description
    self.human_attribute_name(:type_description)
  end

  def display_name
    "#{self.name} #{I18n.t('spree.addons.expires_in', count: self.expiration_days) if self.expiration_days}".strip
  end

  def purchased!(line_item)
    # Do nothing.
  end
end
