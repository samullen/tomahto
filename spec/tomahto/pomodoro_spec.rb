$:.unshift File.dirname(__FILE__) + '/..'
require 'spec_helper'
require 'tomahto/pomodoro'

describe Tomahto::Pomodoro do
  context "#new" do
    it 'instantiates a new Pomodoro instance' do
      Tomahto::Pomodoro.new.should be_an_instance_of Tomahto::Pomodoro
    end
  end
end
