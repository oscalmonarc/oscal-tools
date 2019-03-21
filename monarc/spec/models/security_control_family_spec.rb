require 'rails_helper'

# Test suite for the Todo model
RSpec.describe SecurityControlFamily, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it {should have_many(:security_controls).dependent(:destroy)}
  it {should belong_to(:security_policy)}

    # Validation tests
  # ensure columns name and org and version are present before saving
  
  it {should validate_presence_of(:abv)}
  it {should validate_presence_of(:family)}
  it {should validate_presence_of(:title)}
  
  
end