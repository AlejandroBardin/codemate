class FeaturedPackageComponent < ViewComponent::Base
  def initialize
    @package = Package.homepage_featured
    @title = Setting.find_by(key: "featured_package_title")&.value || "Paquete Destacado"
    @subtitle = Setting.find_by(key: "featured_package_subtitle")&.value || "Nuestra mejor oferta del mes"
  end

  def render?
    @package.present?
  end
end
