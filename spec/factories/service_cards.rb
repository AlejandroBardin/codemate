FactoryBot.define do
  factory :service_card do
    position { 1 }
    title { "MyString" }
    description { "MyText" }
    link_text { "MyString" }
    link_url { "MyString" }
    enabled { false }
    svg_code { "MyText" }
    icon_color { "MyString" }
  end
end
