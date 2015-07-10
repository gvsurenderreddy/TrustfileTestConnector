class Datasource < ActiveRecord::Base
  has_many :activities
  has_one :fake_connnection
  validates_uniqueness_of :company_2_tf_token
end
