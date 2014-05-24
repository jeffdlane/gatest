require 'csv'

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
    @property.user_id = current_user.id
    if @property.update_attributes(properties_params)
      flash[:notice] = "Property was updated."
      redirect_to @property
    else
      flash[:error] = "Property was not updated."
      render :edit
    end
    CSV.new(params[:property][:data])
  end

  def show
    @property = Property.find(params[:id])
  end

  def delete
  end


def upload
  uploaded_io = params[:property][:data]
  File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    file.write(uploaded_io.read)
  end
end

private
  
  def properties_params
    params.require(:property).permit(:property_name, :ga_property_id, :custom_data_id)
  end


end
