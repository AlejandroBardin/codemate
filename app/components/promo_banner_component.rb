# frozen_string_literal: true

class PromoBannerComponent < ViewComponent::Base
  def initialize
    @promo_text = Setting.find_by(key: "promo_banner_text")&.value || "🎉 LANZAMIENTO 2026"
    @promo_subtitle = Setting.find_by(key: "promo_banner_subtitle")&.value || "15% OFF en todos los paquetes - Solo por tiempo limitado"
    @promo_enabled = Setting.find_by(key: "promo_banner_enabled")&.value == "true"

    # Background image
    @bg_setting = Setting.find_by(key: "promo_banner_bg_url")
    @bg_image = @bg_setting&.promo_bg_image&.attached? ? @bg_setting.promo_bg_image : Setting.find_by(key: "promo_banner_bg_url")&.value
  end
end
