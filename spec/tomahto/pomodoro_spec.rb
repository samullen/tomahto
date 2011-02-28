require 'spec_helper'
require 'tomahto'

describe Tomahto::Pomodoro do
  before { @config = {:sleep_length => 0.01}}

  context "::new" do
    it 'instantiates a new Pomodoro instance' do
      Tomahto::Pomodoro.new.should be_an_instance_of Tomahto::Pomodoro
    end

    it "sets default values" do
      tp = Tomahto::Pomodoro.new
      tp.instance_variable_get(:@activity_length).should eq(25)
      tp.instance_variable_get(:@break_length).should eq(5)
      tp.instance_variable_get(:@iterations).should eq(4)
    end

    it "sets values based on what is passed to new" do
      @config.merge!({:activity_length => 30, :break_length => 10})

      tp = Tomahto::Pomodoro.new(@config)
      tp.instance_variable_get(:@activity_length).should eq(30)
      tp.instance_variable_get(:@break_length).should eq(10)
      tp.instance_variable_get(:@iterations).should eq(4)
    end
  end

  context "#run" do
    before { @tp = Tomahto::Pomodoro.new(@config) }

    it "runs for thirty minutes" do
      @tp.stub(:progress)
      @tp.stub(:notify)
      iterations = @tp.instance_variable_get(:@iterations)

      @tp.should_receive(:progress).with("Activity", 25).exactly(iterations).times
      @tp.should_receive(:progress).with("Break", 5).exactly(iterations).times
      @tp.should_receive(:notify).exactly(2 * iterations).times
      @tp.run
    end
  end

  describe "Private Methods" do
    before do
      @tp = Tomahto::Pomodoro.new(@config) 
      @summary = "summary"
      @message = "message"

      Kernel.stub(:sleep)
      @tp.stub(:display_progress)
    end

    context "#progress" do
      it "displays progress 60 times per minutes passed" do
        @tp.should_receive(:display_progress).exactly(60).times
        Kernel.should_receive(:sleep).exactly(60).times
        @tp.send(:progress, "label", 1)
      end

      it "prints a newline at the end of the method" do
        $stdout.should_receive(:puts).once
        @tp.send(:progress, "label", 1)
      end
    end

    # TODO Not sure how to test this
    pending "#display_progress" do
      it "" do
      end
    end

    context "#notify" do
      it "prints message to output" do
        $stdout.should_receive(:puts).with(@message)
        Kernel.stub(:system)
        @tp.send(:notify, @summary, @message)
      end

      it "sends message to system" do
        Kernel.should_receive(:system)
        @tp.send(:notify, @summary, @message)
      end
    end
  end
end
