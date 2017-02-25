require 'rails_helper'

describe Worker do
  it { should have_many :jobs }
  it {should validate_presence_of :email}
  # it {should validate_uniqueness_of :email}
end
