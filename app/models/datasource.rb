class Datasource < ActiveRecord::Base
  has_many :activities
  validates_uniqueness_of :company_2_tf_token
end
