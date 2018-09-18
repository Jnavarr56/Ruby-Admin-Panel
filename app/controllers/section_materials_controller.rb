class SectionMaterialsController < ApplicationController
  before_action :set_section_material, only: [:show, :edit, :update, :destroy]

  # GET /section_materials
  # GET /section_materials.json
  def index
    @section_materials = SectionMaterial.all
  end

  # GET /section_materials/1
  # GET /section_materials/1.json
  def show
  end

  # GET /section_materials/new
  def new
    @section_material = SectionMaterial.new
  end

  # GET /section_materials/1/edit
  def edit
  end

  # POST /section_materials
  # POST /section_materials.json
  def create
    @section_material = SectionMaterial.new(section_material_params)

    respond_to do |format|
      if @section_material.save
        format.html { redirect_to @section_material, notice: 'Section material was successfully created.' }
        format.json { render :show, status: :created, location: @section_material }
      else
        format.html { render :new }
        format.json { render json: @section_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /section_materials/1
  # PATCH/PUT /section_materials/1.json
  def update
    respond_to do |format|
      if @section_material.update(section_material_params)
        format.html { redirect_to @section_material, notice: 'Section material was successfully updated.' }
        format.json { render :show, status: :ok, location: @section_material }
      else
        format.html { render :edit }
        format.json { render json: @section_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /section_materials/1
  # DELETE /section_materials/1.json
  def destroy
    @section_material.destroy
    respond_to do |format|
      format.html { redirect_to section_materials_url, notice: 'Section material was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section_material
      @section_material = SectionMaterial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_material_params
      params.require(:section_material).permit(:material_id, :section_id)
    end
end
