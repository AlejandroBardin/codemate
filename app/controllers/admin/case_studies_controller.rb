class Admin::CaseStudiesController < Admin::BaseController
  before_action :set_case_study, only: %i[ edit update destroy ]

  # GET /admin/case_studies
  def index
    @case_studies = CaseStudy.order(:position)
  end

  # GET /admin/case_studies/new
  def new
    @case_study = CaseStudy.new
  end

  # GET /admin/case_studies/1/edit
  def edit
  end

  # POST /admin/case_studies
  def create
    @case_study = CaseStudy.new(case_study_params)

    if @case_study.save
      redirect_to admin_case_studies_path, notice: "Case study created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/case_studies/1
  def update
    if @case_study.update(case_study_params)
      redirect_to admin_case_studies_path, notice: "Case study updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/case_studies/1
  def destroy
    @case_study.destroy!
    redirect_to admin_case_studies_path, status: :see_other, notice: "Case study deleted successfully."
  end

  private

  def set_case_study
    @case_study = CaseStudy.find(params.expect(:id))
  end

  def case_study_params
    params.expect(case_study: [
      :title, :category, :description, :position, :enabled,
      :metric_label, :metric_color, :link_url,
      :cover_image
    ])
  end
end
