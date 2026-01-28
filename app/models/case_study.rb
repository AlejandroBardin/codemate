class CaseStudy < ApplicationRecord
  has_one_attached :cover_image

  validates :title, :category, :description, presence: true
  validates :cover_image, attached: true, content_type: %w[image/png image/jpeg image/webp],
                          size: { less_than: 5.megabytes }

  scope :enabled, -> { where(enabled: true).order(:position) }

  CATEGORIES = %w[FINTECH HEALTHTECH ENTERPRISE E-COMMERCE SAAS AUTOMATION CONSULTING].freeze
  METRIC_COLORS = %w[green yellow blue purple pink].freeze

  # Helper para determinar si es el único caso activo
  def self.single_featured?
    enabled.count == 1
  end
end
