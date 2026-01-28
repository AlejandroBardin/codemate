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
    params[:settings].each do |key, value|
      Setting.find_or_create_by(key: key).update(value: value)
    end
    redirect_to admin_settings_path, notice: "Settings updated successfully"
  end

  def disconnect_meta
    MetaPageConnection.active.update_all(is_active: false)
    redirect_to admin_settings_path, notice: "Facebook Page disconnected."
  end
end
