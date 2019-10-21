require_relative 'spec_helper'

describe 'dotfiles::whatsapp' do
  describe file('/Applications/Whatsapp.app') do
    it { should be_directory }
  end
end
