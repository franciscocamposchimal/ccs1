class WarrantiesController < ApplicationController
  before_action :set_warranty, only: [:show, :edit, :update, :destroy]


  # POST /warranties
  # POST /warranties.json
  def create
    
    @warranty = Warranty.new(warranty_params)

    respond_to do |format|
      if @warranty.save
        format.html { redirect_to @warranty, notice: 'Warranty was successfully created.' }
        format.json { render :show, status: :created, location: @warranty }
      else
        format.html { render :new }
        format.json { render json: @warranty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /warranties/1
  # PATCH/PUT /warranties/1.json
  def update
    respond_to do |format|
      if @warranty.update(warranty_params)
        format.html { redirect_to @warranty, notice: 'Warranty was successfully updated.' }
        format.json { respond_with_bip(@warranty) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@warranty) }
      end
    end
  end

  # DELETE /warranties/1
  # DELETE /warranties/1.json
  def destroy
    @warranty.destroy
    respond_to do |format|
      format.html { redirect_to warranties_url, notice: 'Warranty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warranty
      @warranty = Warranty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warranty_params
      params.require(:warranty).permit(:garantia1, :garantia2, :garantia3, :garantia4, :client_id)
    end
end
