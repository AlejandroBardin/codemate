class Setting < ApplicationRecord
  has_one_attached :site_logo

  validates :key, presence: true, uniqueness: true
  validates :value, presence: true, allow_blank: true

  # Helper para obtener valores fácilmente
  def self.get(key, default = nil)
    find_by(key: key)&.value || default
  end

  # Helper para obtener el logo del sitio
  def self.logo
    find_by(key: "site_logo_url")
  end
end
