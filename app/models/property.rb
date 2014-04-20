class Property < ActiveRecord::Base
  belongs_to :user

  validates :property_name, presence: true
  validates :ga_property_id, presence: true
  validates :custom_data_id, presence: true
end
