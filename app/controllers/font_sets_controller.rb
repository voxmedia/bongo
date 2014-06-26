class FontSetsController < ApplicationController
  before_action :set_font_set_and_project, only: [:show, :edit, :update, :destroy]

  def show

  end

  # GET /font_sets/new
  def new
    @project = Project.find(params[:project_id])
    @font_set = @project.font_sets.build
    @font_families = get_font_family_array(@project)
  end

  # GET /font_sets/1/edit
  def edit
    @project = Project.find(params[:project_id])
    @font_set = @project.font_sets.find(params[:id])
    @font_families = get_font_family_array(@project)
  end

  # POST /font_sets
  # POST /font_sets.json
  def create
    @project = Project.find(params[:project_id])
    @font_set = @project.font_sets.build(font_set_params)

    respond_to do |format|
      if @font_set.save
        format.html { redirect_to project_details_url(@project), notice: 'Font set was successfully created.' }
        format.json { render :show, status: :created, location: @font_set }
      else
        format.html { render :new }
        format.json { render json: @font_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /font_sets/1
  # PATCH/PUT /font_sets/1.json
  def update
    @project = Project.find(params[:project_id])
    @font_set = @project.font_sets.find(params[:id])
    respond_to do |format|
      if @font_set.update(font_set_params)
        format.html { redirect_to project_details_url(@project), notice: 'Font set was successfully updated.' }
        format.json { render :show, status: :ok, location: @font_set }
      else
        format.html { render :edit }
        format.json { render json: @font_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /font_sets/1
  # DELETE /font_sets/1.json
  def destroy
    @font_set.destroy
    respond_to do |format|
      format.html { redirect_to font_sets_url, notice: 'Font set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_font_set_and_project
      @project = Project.find(params[:project_id])
      @font_set = @project.font_sets.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def font_set_params
      params.require(:font_set).permit(:sass,
                                       :project_id,
                                       :name,
                                       :main_headline,
                                       :secondary_headline,
                                       :body,
                                       :byline,
                                       :pullquote,
                                       :blockquote,
                                       :big_number,
                                       :big_number_label)
    end

    def get_font_family_array(project)
      families = []
      project.kit['kit']['families'].each do |f|
        f['variations'].each do |v|
          families << ["#{f['name']} (#{view_context.font_variation_to_string(v)})", "#{f['id']}:#{v}"]
        end
      end
      families
    end
end
