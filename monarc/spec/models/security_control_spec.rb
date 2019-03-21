require 'rails_helper'

# Test suite for the Todo model
RSpec.describe SecurityControl, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should belong_to(:security_control_family)}
  it { should belong_to(:security_policy)}

    # Validation tests
  # ensure columns name and org and version are present before saving
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:control_id) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:title) }
  
  
end