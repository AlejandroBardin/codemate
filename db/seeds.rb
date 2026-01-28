# Admin User
User.find_or_create_by!(email_address: "admin@codemate.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
end
puts "✅ Admin user ensured"

# Default Settings
[
  # General
  { key: "whatsapp_number", value: "5493813416824" },
  { key: "facebook_pixel", value: "1166448375323223" },
  { key: "google_analytics_id", value: "" },

  # Header
  { key: "site_name", value: "Codemate" },
  { key: "site_logo_url", value: "" }, # Se puede agregar después

  # Hero Section
  { key: "hero_badge_text", value: "Accepting new automation clients" },
  { key: "hero_badge_enabled", value: "true" },
  { key: "hero_title", value: "Building Scalable Automation for Rapid Growth Companies" },
  { key: "hero_title_highlight", value: "Scalable Automation" },
  { key: "hero_subtitle", value: "We deploy senior automation experts to build risk-free development sprints. Trusted by growing companies to ship faster." },
  { key: "hero_cta_primary_text", value: "Start Your Sprint" },
  { key: "hero_cta_primary_url", value: "#contact" },
  { key: "hero_cta_secondary_text", value: "View Portfolio" },
  { key: "hero_cta_secondary_url", value: "#portfolio" },
  { key: "hero_trusted_by_text", value: "Trusted by teams at" },

  # Footer CTA
  { key: "footer_cta_title", value: "Ready to automate your business?" },
  { key: "footer_cta_subtitle", value: "Get a custom roadmap and estimate within 24 hours." },
  { key: "footer_cta_button_text", value: "Get Estimate" },
  { key: "footer_cta_button_url", value: "#contact" },
  { key: "footer_rating_text", value: "4.9/5 on Clutch" },
  { key: "footer_badge_text", value: "n8n Certified Partner" },
  { key: "footer_copyright", value: "© 2026 Codemate. All rights reserved." }
].each do |setting_attrs|
  Setting.find_or_create_by!(key: setting_attrs[:key]) do |setting|
    setting.value = setting_attrs[:value]
  end
end
puts "✅ Settings ensured"

# Sample Packages
[
  {
    title: "Mendoza a Pleno",
    price: 350000.00,
    stars: "⭐⭐⭐",
    duration: "4 Noches / 5 Días",
    dates: "Salida: 15 de Febrero",
    regime: "Media Pensión",
    featured: true,
    description: "Disfrutá de la tierra del buen sol y del buen vino. Excursiones imperdibles y bodegas de primera."
  },
  {
    title: "Cataratas del Iguazú",
    price: 420000.00,
    stars: "⭐⭐⭐⭐",
    duration: "5 Noches / 6 Días",
    dates: "Salida: 20 de Marzo",
    regime: "Desayuno",
    featured: true,
    description: "Viví una de las maravillas naturales del mundo. Incluye excursión lado Argentino y Brasileño."
  },
  {
    title: "Merlo San Luis",
    price: 280000.00,
    stars: "⭐⭐⭐",
    duration: "3 Noches / 4 Días",
    dates: "Salida: 10 de Abril",
    regime: "Pensión Completa",
    featured: false,
    description: "El tercer microclima del mundo te espera. Relax y naturaleza."
  }
].each do |package_attrs|
  Package.find_or_create_by!(title: package_attrs[:title]) do |package|
    package.assign_attributes(package_attrs)

    # Nuevos campos
    package.keyword = package_attrs[:title].parameterize
    package.gpt_prompt = "Eres un agente de ventas de #{package_attrs[:title]}. Sé amable y profesional."
    package.start_date = 1.month.from_now
    package.end_date = 1.month.from_now + 5.days
    package.kids_friendly = package_attrs[:title].include?("Merlo")
    package.extras = {
      incluye_traslado: true,
      incluye_seguro: true,
      comidas: package_attrs[:regime]
    }

    package.main_image.attach(
      io: File.open(Rails.root.join("db/fixtures/placeholder.jpg")),
      filename: "placeholder.jpg",
      content_type: "image/jpeg"
    )
  end
end
puts "✅ Packages ensured"

# Sample Questions (FAQs) para el primer paquete
mendoza = Package.find_by(title: "Mendoza a Pleno")
if mendoza && mendoza.questions.empty?
  [
    {
      name: "¿Qué incluye el paquete?",
      answer: "El paquete incluye traslados, alojamiento con media pensión, y excursiones a bodegas seleccionadas.",
      kind: :description,
      enabled: true
    },
    {
      name: "¿Cuál es la mejor época para ir?",
      answer: "La mejor época es de febrero a abril (vendimia) o septiembre a noviembre (primavera).",
      kind: :detail,
      enabled: true
    },
    {
      name: "¿Es apto para niños?",
      answer: "Sí, tenemos excursiones familiares aunque algunas bodegas tienen restricción de edad.",
      kind: :detail,
      enabled: true
    }
  ].each do |question_attrs|
    mendoza.questions.create!(question_attrs)
  end
  puts "✅ Questions for Mendoza package created"
end
# Service Cards - Herramientas reales que vendés
[
  {
    position: 1,
    title: 'n8n Automation',
    description: 'Conectamos todas tus herramientas en flujos automatizados. Desde CRM hasta facturación, todo sincronizado sin código.',
    link_text: 'Ver casos de uso',
    link_url: '#',
    enabled: true,
    svg_code: '<svg viewBox="0 0 24 24" fill="currentColor" class="w-10 h-10"><path d="M12 2L2 7v10l10 5 10-5V7L12 2zm0 2.18L19.82 8 12 11.82 4.18 8 12 4.18zM4 9.47l7 3.5v7.85l-7-3.5V9.47zm16 0v7.85l-7 3.5v-7.85l7-3.5z"/></svg>',
    icon_color: 'blue-400'
  },
  {
    position: 2,
    title: 'Chatwoot Support',
    description: 'Implementamos y personalizamos Chatwoot para centralizar WhatsApp, email y chat en vivo en una sola plataforma.',
    link_text: 'Conocer más',
    link_url: '#',
    enabled: true,
    svg_code: '<svg viewBox="0 0 24 24" fill="currentColor" class="w-10 h-10"><path d="M12 2C6.48 2 2 6.48 2 12c0 1.54.36 3 .97 4.29L2 22l5.71-.97C9 21.64 10.46 22 12 22c5.52 0 10-4.48 10-10S17.52 2 12 2zm0 18c-1.38 0-2.68-.29-3.86-.81l-.28-.13-2.86.49.49-2.86-.13-.28C4.29 14.68 4 13.38 4 12c0-4.41 3.59-8 8-8s8 3.59 8 8-3.59 8-8 8z"/></svg>',
    icon_color: 'green-400'
  },
  {
    position: 3,
    title: 'Custom Integrations',
    description: 'Desarrollamos integraciones a medida entre tus sistemas legacy y herramientas modernas. APIs, webhooks y sincronización en tiempo real.',
    link_text: 'Consultar',
    link_url: '#',
    enabled: true,
    svg_code: '<svg viewBox="0 0 24 24" fill="currentColor" class="w-10 h-10"><path d="M9.4 16.6L4.8 12l4.6-4.6L8 6l-6 6 6 6 1.4-1.4zm5.2 0l4.6-4.6-4.6-4.6L16 6l6 6-6 6-1.4-1.4z"/></svg>',
    icon_color: 'purple-400'
  }
].each do |attrs|
  ServiceCard.find_or_create_by!(title: attrs[:title]) do |card|
    card.assign_attributes(attrs)
  end
end
puts "✅ Service Cards ensured"

# Case Study - Solo 1 caso real
# IMPORTANTE: Necesitarás agregar una imagen real después
# Por ahora usamos el placeholder
case_study_attrs = {
  position: 1,
  title: 'TerralViajes Automation',
  category: 'AUTOMATION',
  metric_label: '80% Time Saved',
  metric_color: 'green',
  description: 'Automatizamos el flujo completo desde leads de Meta hasta WhatsApp con Chatwoot. Integramos n8n para sincronizar reservas con el CRM y enviar confirmaciones automáticas.',
  link_url: '#',
  enabled: true
}

CaseStudy.find_or_create_by!(title: case_study_attrs[:title]) do |study|
  study.assign_attributes(case_study_attrs)

  # Attach placeholder image (reemplazar con imagen real después)
  if File.exist?(Rails.root.join("db/fixtures/placeholder.jpg"))
    study.cover_image.attach(
      io: File.open(Rails.root.join("db/fixtures/placeholder.jpg")),
      filename: "terral-case-study.jpg",
      content_type: "image/jpeg"
    )
  end
end
puts "✅ Case Study ensured"
