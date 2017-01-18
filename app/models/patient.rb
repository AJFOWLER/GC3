class Patient < ActiveRecord::Base
  
  GENDERTYPES = "Male", "Female"
  validates :gender, inclusion: GENDERTYPES
  
end
