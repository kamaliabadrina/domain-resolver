class QueryHistory < ApplicationRecord
    validates :domain_name, presence: true
    validates :query_type, presence: true
  end
  