class Report < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :hours, presence: true
end
