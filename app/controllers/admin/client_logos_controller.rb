class Admin::ClientLogosController < Admin::BaseController
  before_action :set_client_logo, only: %i[ edit update destroy ]

  # GET /admin/client_logos
  def index
    @client_logos = ClientLogo.order(:position)
  end

  # GET /admin/client_logos/new
  def new
    @client_logo = ClientLogo.new
  end

  # GET /admin/client_logos/1/edit
  def edit
  end

  # POST /admin/client_logos
  def create
    @client_logo = ClientLogo.new(client_logo_params)

    if @client_logo.save
      redirect_to admin_client_logos_path, notice: "Client logo created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/client_logos/1
  def update
    if @client_logo.update(client_logo_params)
      redirect_to admin_client_logos_path, notice: "Client logo updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/client_logos/1
  def destroy
    @client_logo.destroy!
    redirect_to admin_client_logos_path, status: :see_other, notice: "Client logo deleted successfully."
  end

  private

  def set_client_logo
    @client_logo = ClientLogo.find(params.expect(:id))
  end

  def client_logo_params
    params.expect(client_logo: [ :name, :position, :enabled, :logo_image ])
  end
end
