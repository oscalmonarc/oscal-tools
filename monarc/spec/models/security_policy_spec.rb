require 'rails_helper'

# Test suite for the Todo model
RSpec.describe SecurityPolicy, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it {should have_many(:security_control_families).dependent(:destroy)}
  it {should have_many(:security_controls).dependent(:destroy)}
  
    # Validation tests
  # ensure columns name and org and version are present before saving
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:version)}
  
end