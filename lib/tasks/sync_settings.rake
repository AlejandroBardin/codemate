namespace :settings do
  desc "Sync production settings with current seed configuration"
  task sync_production: :environment do
    puts "🔄 Syncing production settings..."

    # Settings that should exist (from current seeds.rb)
    required_settings = [
      # General
      { key: "whatsapp_number", value: "5493813416824" },
      { key: "facebook_pixel", value: "1166448375323223" },
      { key: "google_analytics_id", value: "" },

      # Header
      { key: "site_name", value: "Codemate" },
      { key: "site_logo_url", value: "" },
      { key: "site_tagline", value: "Automation & Software" },

      # Promo Banner
      { key: "promo_banner_enabled", value: "true" },
      { key: "promo_banner_text", value: "🎉 LANZAMIENTO 2026" },
      { key: "promo_banner_subtitle", value: "15% OFF en todos los paquetes - Solo por tiempo limitado" },
      { key: "promo_banner_bg_url", value: "" },

      # Hero Section
      { key: "hero_badge_text", value: "Accepting new automation clients" },
      { key: "hero_badge_enabled", value: "true" },
      { key: "hero_title", value: "Building Scalable Automation for Rapid Growth Companies" },
      { key: "hero_subtitle", value: "We deploy senior automation experts to build risk-free development sprints. Trusted by growing companies to ship faster." },
      { key: "hero_cta_text", value: "Hablemos por WhatsApp" },
      { key: "hero_bg_url", value: "" },

      # Footer CTA
      { key: "footer_cta_title", value: "Ready to automate your business?" },
      { key: "footer_cta_subtitle", value: "Get a custom roadmap and estimate within 24 hours." },
      { key: "footer_cta_button_text", value: "Get Estimate" },
      { key: "footer_cta_button_url", value: "#contact" },
      { key: "footer_rating_text", value: "4.9/5 on Clutch" },
      { key: "footer_badge_text", value: "n8n Certified Partner" },
      { key: "footer_copyright", value: "© 2026 Codemate. All rights reserved." }
    ]

    # Settings that should be removed (old/deprecated)
    deprecated_keys = [
      "hero_title_highlight",
      "hero_trusted_by_text",
      "hero_cta_primary_text",
      "hero_cta_primary_url",
      "hero_cta_secondary_text",
      "hero_cta_secondary_url"
    ]

    # Add missing settings
    added_count = 0
    required_settings.each do |setting_attrs|
      setting = Setting.find_or_initialize_by(key: setting_attrs[:key])
      if setting.new_record?
        setting.value = setting_attrs[:value]
        setting.save!
        puts "  ✅ Added: #{setting_attrs[:key]}"
        added_count += 1
      end
    end

    # Remove deprecated settings
    removed_count = 0
    deprecated_keys.each do |key|
      setting = Setting.find_by(key: key)
      if setting
        setting.destroy
        puts "  ❌ Removed: #{key}"
        removed_count += 1
      end
    end

    puts "\n📊 Summary:"
    puts "  Added: #{added_count} settings"
    puts "  Removed: #{removed_count} deprecated settings"
    puts "  Total settings: #{Setting.count}"
    puts "\n✅ Production settings synced!"
  end
end
