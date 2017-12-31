class TucdocsController < ApplicationController
  before_action :set_tucdoc, only: [:show, :edit, :update, :destroy]

  # GET /tucdocs
  # GET /tucdocs.json
  def index
    @tucdocs = Tucdoc.all
  end

  # GET /tucdocs/1
  # GET /tucdocs/1.json
  def show
  end

  # GET /tucdocs/new
  def new
    @tucdoc = Tucdoc.new
  end

  # GET /tucdocs/1/edit
  def edit
  end

  # POST /tucdocs
  # POST /tucdocs.json
  def create
    @tucdoc = Tucdoc.new(tucdoc_params)

    respond_to do |format|
      if @tucdoc.save
        format.html { redirect_to @tucdoc, notice: 'Tucdoc was successfully created.' }
        format.json { render :show, status: :created, location: @tucdoc }
      else
        format.html { render :new }
        format.json { render json: @tucdoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tucdocs/1
  # PATCH/PUT /tucdocs/1.json
  def update
    respond_to do |format|
      if @tucdoc.update(tucdoc_params)
        format.html { redirect_to @tucdoc, notice: 'Tucdoc was successfully updated.' }
        format.json { render :show, status: :ok, location: @tucdoc }
      else
        format.html { render :edit }
        format.json { render json: @tucdoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tucdocs/1
  # DELETE /tucdocs/1.json
  def destroy
    @tucdoc.destroy
    respond_to do |format|
      format.html { redirect_to tucdocs_url, notice: 'Tucdoc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tucdoc
      @tucdoc = Tucdoc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tucdoc_params
      params.require(:tucdoc).permit(:coagyear, :project_id, :object_class_id, :item_no, :amend_no, :doc)
    end
end
