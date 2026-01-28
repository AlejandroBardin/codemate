# frozen_string_literal: true

class ServiceCardsComponent < ViewComponent::Base
  def initialize(cards:)
    @cards = cards
  end
end
