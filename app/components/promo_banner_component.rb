# frozen_string_literal: true

class PromoBannerComponent < ViewComponent::Base
  def initialize
    @promo_text = Setting.find_by(key: "promo_banner_text")&.value || "🎉 LANZAMIENTO 2026"
    @promo_subtitle = Setting.find_by(key: "promo_banner_subtitle")&.value || "15% OFF en todos los paquetes - Solo por tiempo limitado"
    @promo_enabled = Setting.find_by(key: "promo_banner_enabled")&.value == "true"
  end
end
