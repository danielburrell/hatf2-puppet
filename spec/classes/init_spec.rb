require 'spec_helper'
describe 'hatf2' do

  context 'with defaults for all parameters' do
    it { should contain_class('hatf2') }
  end
end
