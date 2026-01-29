class Admin::SettingsController < Admin::BaseController
  def index
    @meta_connection = MetaPageConnection.active.first

    # Agrupar settings por sección
    @hero_settings = Setting.where("key LIKE 'hero_%'").order(:key)
    @footer_settings = Setting.where("key LIKE 'footer_%'").order(:key)
    @header_settings = Setting.where("key LIKE 'site_%'").order(:key)
    @general_settings = Setting.where.not("key LIKE 'hero_%' OR key LIKE 'footer_%' OR key LIKE 'site_%'").order(:key)
  end

  def batch_update
    # Handle logo upload separately
    if params[:site_logo].present?
      logo_setting = Setting.find_or_create_by(key: "site_logo_url")
      logo_setting.site_logo.attach(params[:site_logo])
    end

    # Handle promo banner background image
    if params[:promo_bg_image].present?
      promo_bg_setting = Setting.find_or_create_by(key: "promo_banner_bg_url")
      promo_bg_setting.promo_bg_image.attach(params[:promo_bg_image])
    end

    # Handle hero background image
    if params[:hero_bg_image].present?
      hero_bg_setting = Setting.find_or_create_by(key: "hero_bg_url")
      hero_bg_setting.hero_bg_image.attach(params[:hero_bg_image])
    end

    # Handle regular settings
    params[:settings]&.each do |key, value|
      setting = Setting.find_or_create_by(key: key)
      result = setting.update(value: value)
      Rails.logger.info "Setting #{key}: #{result ? 'updated' : 'failed'} to '#{value}'"
    end

    redirect_to admin_settings_path, notice: "Settings updated successfully"
  end

  def disconnect_meta
    MetaPageConnection.active.update_all(is_active: false)
    redirect_to admin_settings_path, notice: "Facebook Page disconnected."
  end
end
