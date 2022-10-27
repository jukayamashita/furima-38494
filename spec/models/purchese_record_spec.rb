require 'rails_helper'

RSpec.describe , type: :model do
  belongs_to :user
  belongs_to :product
  has_one :destination
end
