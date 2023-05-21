# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cnab, type: :model do
  before(:all) do
    @cnab = create(:cnab)
  end

  it 'is valid with all attributes' do
    expect(@cnab).to be_valid
  end
end
