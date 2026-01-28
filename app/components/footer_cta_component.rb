# frozen_string_literal: true

class FooterCtaComponent < ViewComponent::Base
  def initialize
    @title = Setting.get("footer_cta_title", "Ready to scale your engineering?")
    @subtitle = Setting.get("footer_cta_subtitle", "Get a custom roadmap and estimate within 24 hours.")
    @button_text = Setting.get("footer_cta_button_text", "Get Estimate")
    @button_url = Setting.get("footer_cta_button_url", "#contact")
    @rating_text = Setting.get("footer_rating_text", "4.9/5 on Clutch")
    @badge_text = Setting.get("footer_badge_text", "Google Partner")
    @copyright = Setting.get("footer_copyright", "\u00A9 2026 Codemate. All rights reserved.")
  end
end
