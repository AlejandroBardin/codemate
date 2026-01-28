class HomeController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]

  def index
    @service_cards = ServiceCard.enabled
    @case_studies = CaseStudy.enabled
    @packages = Package.featured.by_price
  end
end
