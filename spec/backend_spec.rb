require 'spec_helper'

describe Delayed::Backend::Base do

class Story < ActiveRecord::Base
  def perform; end
end

  context 'identifiable job' do
    it "should not enqeue duplicated identifiable objects" do
      story = Story.create!
      lambda {
        Delayed::Job.enqueue story, :identifiable => true
        Delayed::Job.enqueue story, :identifiable => true
      }.should change(Delayed::Job, :count).by(1)
    end    
  end
end
