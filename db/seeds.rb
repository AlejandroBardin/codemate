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
  { key: "site_tagline", value: "Automation & Software" },

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
    title: 'Desarrollo Ágil & CMS a Medida',
    description: 'Sitios web de alto impacto diseñados en tiempo récord. Incluimos un panel de administración 100% editable para que gestiones textos e imágenes sin depender de desarrolladores.',
    link_text: 'Ver demo del panel →',
    link_url: '/admin',
    enabled: true,
    svg_code: '<svg viewBox="0 0 24 24" fill="currentColor" class="w-10 h-10"><path d="M20 6h-2.18c.11-.31.18-.65.18-1 0-1.66-1.34-3-3-3-1.05 0-1.96.54-2.5 1.35l-.5.67-.5-.68C10.96 2.54 10.05 2 9 2 7.34 2 6 3.34 6 5c0 .35.07.69.18 1H4c-1.11 0-1.99.89-1.99 2L2 19c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V8c0-1.11-.89-2-2-2zm-5-2c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zM9 4c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zm11 15H4v-2h16v2zm0-5H4V8h5.08L7 10.83 8.62 12 11 8.76l1-1.36 1 1.36L15.38 12 17 10.83 14.92 8H20v6z"/></svg>',
    icon_color: 'blue-400'
  },
  {
    position: 2,
    title: 'E-commerce & Pasarelas de Pago',
    description: 'Transformamos tu web en una máquina de ventas. Integración fluida de carritos de compra, checkout seguro y cobros locales/internacionales (Stripe, Mercado Pago) listos para usar.',
    link_text: 'Consultar integración →',
    link_url: '#contact',
    enabled: true,
    svg_code: '<svg viewBox="0 0 24 24" fill="currentColor" class="w-10 h-10"><path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/></svg>',
    icon_color: 'green-400'
  },
  {
    position: 3,
    title: 'Integración de IA',
    description: 'Implementamos asistentes de IA personalizados en tu web. Desde chatbots inteligentes hasta automatización de respuestas, análisis de datos y generación de contenido.',
    link_text: 'Consultar →',
    link_url: '#contact',
    enabled: true,
    svg_code: '<svg viewBox="0 0 24 24" fill="currentColor" class="w-10 h-10"><path d="M20 2H4c-1.1 0-1.99.9-1.99 2L2 22l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 9h12v2H6V9zm8 5H6v-2h8v2zm4-6H6V6h12v2z"/></svg>',
    icon_color: 'purple-400'
  },
  {
    position: 4,
    title: 'n8n Automation',
    description: 'Conectamos todas tus herramientas en flujos automatizados. Desde CRM hasta facturación, todo sincronizado sin código.',
    link_text: 'Ver casos de uso',
    link_url: '#',
    enabled: false,
    svg_code: '<svg viewBox="0 0 24 24" fill="currentColor" class="w-10 h-10"><path d="M12 2L2 7v10l10 5 10-5V7L12 2zm0 2.18L19.82 8 12 11.82 4.18 8 12 4.18zM4 9.47l7 3.5v7.85l-7-3.5V9.47zm16 0v7.85l-7 3.5v-7.85l7-3.5z"/></svg>',
    icon_color: 'blue-400'
  },
  {
    position: 5,
    title: 'Chatwoot Support',
    description: 'Implementamos y personalizamos Chatwoot para centralizar WhatsApp, email y chat en vivo en una sola plataforma.',
    link_text: 'Conocer más',
    link_url: '#',
    enabled: false,
    svg_code: '<svg viewBox="0 0 24 24" fill="currentColor" class="w-10 h-10"><path d="M12 2C6.48 2 2 6.48 2 12c0 1.54.36 3 .97 4.29L2 22l5.71-.97C9 21.64 10.46 22 12 22c5.52 0 10-4.48 10-10S17.52 2 12 2zm0 18c-1.38 0-2.68-.29-3.86-.81l-.28-.13-2.86.49.49-2.86-.13-.28C4.29 14.68 4 13.38 4 12c0-4.41 3.59-8 8-8s8 3.59 8 8-3.59 8-8 8z"/></svg>',
    icon_color: 'green-400'
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
