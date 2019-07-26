class SolarPanelsController < ApplicationController
  before_action :find_solar_panel, only: [:edit, :update, :destroy]
  layout 'form', only: [:new, :create, :edit, :update]

  def new
    @solar_panel = SolarPanel.new
    authorize @solar_panel
  end

  def create
    @solar_panel = SolarPanel.new(solar_panel_params)
    authorize @solar_panel
    if @solar_panel.save
      flash[:notice] = "A new solar panel has been created."
      redirect_to power_components_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @solar_panel.update(solar_panel_params)
      flash[:notice] = "The solar panel has been updated."
      redirect_to power_components_path
    else
      render :edit
    end
  end

  def destroy
    @solar_panel.destroy
    @solar_panels = policy_scope(SolarPanel).all
    # flash[:notice] = "The solar panel has been deleted"
  end

  private

  def find_solar_panel
    @solar_panel = SolarPanel.find(params[:id])
    authorize @solar_panel
  end

  def solar_panel_params
    params.require(:solar_panel).permit(
      :technology,
      :power,
      :price_min,
      :price_max,
      :currency
    )
  end
end
