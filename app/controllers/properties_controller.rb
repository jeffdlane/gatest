class PropertiesController < ApplicationController
  def index
    @properties = Property.all
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(properties_params)
    if @property.save
      flash[:notice] = "Property was saved."
      redirect_to @property
    else
      flash[:error] = "Property was not saved."
      render :new
    end
  end

  def edit
  end

  def show
    @property = Property.find(params[:id])
  end

  def delete
  end

private
  
  def properties_params
    params.require(:property).permit(:property_name, :ga_property_id, :custom_data_id)
  end


end
