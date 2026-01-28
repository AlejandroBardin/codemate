class ServiceCard < ApplicationRecord
  has_one_attached :custom_icon

  validates :title, :description, presence: true
  validate :has_icon
  validates :custom_icon, content_type: %w[image/png image/jpeg image/webp image/svg+xml],
                          size: { less_than: 1.megabyte }, if: -> { custom_icon.attached? }

  scope :enabled, -> { where(enabled: true).order(:position) }

  # Helper para determinar qué tipo de ícono usar
  def icon_type
    return :custom if custom_icon.attached?
    return :svg if svg_code.present?
    :none
  end

  def render_icon
    case icon_type
    when :custom
      custom_icon
    when :svg
      svg_code.html_safe
    else
      nil
    end
  end

  private

  def has_icon
    if custom_icon.blank? && svg_code.blank?
      errors.add(:base, "Must provide either custom_icon or svg_code")
    end
  end
end
