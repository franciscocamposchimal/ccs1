class Record < ApplicationRecord
  belongs_to :client, optional: true
end
