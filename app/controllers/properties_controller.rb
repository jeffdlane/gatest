class PropertiesController < ApplicationController
  def index
    @properties = current_user.properties.all if current_user
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
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    if @property.update_attributes(properties_params)
      flash[:notice] = "Property was updated."
      redirect_to @property
    else
      flash[:error] = "Property was not updated."
      render :edit
    end
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
