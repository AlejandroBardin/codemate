FactoryBot.define do
  factory :case_study do
    position { 1 }
    title { "MyString" }
    category { "MyString" }
    metric_label { "MyString" }
    metric_color { "MyString" }
    description { "MyText" }
    link_url { "MyString" }
    enabled { false }
  end
end
