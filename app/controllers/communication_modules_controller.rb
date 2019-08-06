class CommunicationModulesController < ApplicationController
  before_action :find_communication_module, only: [:edit, :update]
  layout 'form', only: [:new, :create, :edit, :update]

  def new
    @communication_module = CommunicationModule.new
    authorize @communication_module
  end

  def create
    @communication_module = CommunicationModule.new(communication_module_params)
    authorize @communication_module
    if @communication_module.save
      flash[:notice] = "A new monitoring system has been created."
      redirect_to power_components_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @communication_module.update(communication_module_params)
      flash[:notice] = "The monitoring system has been updated."
      redirect_to power_components_path
    else
      render :edit
    end
  end

  private

  def find_communication_module
    @communication_module = CommunicationModule.find(params[:id])
    authorize @communication_module
  end

  def communication_module_params
    params.require(:communication_module).permit(
      :price_min,
      :price_max,
      :currency,
      :daily_consumption
    )
  end
end
