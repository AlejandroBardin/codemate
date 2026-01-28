# frozen_string_literal: true

class CaseStudiesComponent < ViewComponent::Base
  def initialize(studies:)
    @studies = studies
    @single_featured = CaseStudy.single_featured?
  end
end
