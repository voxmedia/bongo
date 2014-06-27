class ProjectsController < ApplicationController
  before_action :set_project, only: [:details, :show, :edit, :update, :destroy]

  layout "admin"

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1/details
  # GET /projects/1/details.json
  def details
    @typekit = @project.kit
  end

  def show
    respond_to do |format|
      if @project.font_sets.size == 0
        format.html { redirect_to project_details_url(@project), notice: 'You need to add font sets to this project before you can launch it!' }
      else
        font_set = @project.font_sets.first
        format.html { redirect_to show_font_set_url(@project.id, @project.slug, font_set.id, font_set.slug)}
      end
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_details_url(@project), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_details_url(@project), notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :kit_id, :typekit_token, :feature_image_url, :background_url, :lede_image_url, :three_up_first_url, :three_up_last_url, :logo_url, :primary_color, :secondary_color)
    end
end
