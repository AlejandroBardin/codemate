# frozen_string_literal: true

class HeroComponent < ViewComponent::Base
  def initialize
    @badge_text = Setting.get("hero_badge_text", "Accepting new clients")
    @badge_enabled = Setting.get("hero_badge_enabled", "true") == "true"
    @title = Setting.get("hero_title", "Building Scalable Software")
    @title_highlight = Setting.get("hero_title_highlight", "Scalable Software")
    @subtitle = Setting.get("hero_subtitle", "We deploy senior engineering teams")
    @trusted_by_text = Setting.get("hero_trusted_by_text", "Trusted by teams at")
    @client_logos = ClientLogo.enabled

    # Background image
    @bg_setting = Setting.find_by(key: "hero_bg_url")
    @bg_image = @bg_setting&.hero_bg_image&.attached? ? @bg_setting.hero_bg_image : Setting.get("hero_bg_url")
  end

  def highlighted_title
    return @title unless @title_highlight.present?
    @title.gsub(@title_highlight, "<span class='text-primary'>#{@title_highlight}</span>")
  end
end
