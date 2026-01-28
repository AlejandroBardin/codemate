class Setting < ApplicationRecord
  validates :key, presence: true, uniqueness: true
  validates :value, presence: true, allow_blank: true

  # Helper para obtener valores fácilmente
  def self.get(key, default = nil)
    find_by(key: key)&.value || default
  end
end
