class Admin::ServiceCardsController < Admin::BaseController
  before_action :set_service_card, only: %i[ edit update destroy ]

  # GET /admin/service_cards
  def index
    @service_cards = ServiceCard.order(:position)
  end

  # GET /admin/service_cards/new
  def new
    @service_card = ServiceCard.new
  end

  # GET /admin/service_cards/1/edit
  def edit
  end

  # POST /admin/service_cards
  def create
    @service_card = ServiceCard.new(service_card_params)

    if @service_card.save
      redirect_to admin_service_cards_path, notice: "Service card created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/service_cards/1
  def update
    if @service_card.update(service_card_params)
      redirect_to admin_service_cards_path, notice: "Service card updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/service_cards/1
  def destroy
    @service_card.destroy!
    redirect_to admin_service_cards_path, status: :see_other, notice: "Service card deleted successfully."
  end

  private

  def set_service_card
    @service_card = ServiceCard.find(params.expect(:id))
  end

  def service_card_params
    params.expect(service_card: [
      :title, :description, :position, :enabled,
      :svg_code, :icon_color, :link_text, :link_url,
      :custom_icon
    ])
  end
end
