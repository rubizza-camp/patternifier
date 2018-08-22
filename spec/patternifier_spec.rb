require "patternifier"
require asset_path("useless_patterns", "smoking")

RSpec.describe Patternifier::Base do
  context "include as a module" do
    class SampleClass
      include Patternifier::Base
      patterns_root asset_path
      patterns :useless_patterns
    end

    subject { SampleClass.new }

    it "has method useful_pattern_for" do
      expect(subject.methods).to include(:useless_pattern_for)
    end

    it "#useful_pattern_for for smoking returns smoking object" do
      expect(subject.useless_pattern_for(:smoking)).to be_a(Smoking)
    end
  end

  it "has a version number" do
    expect(Patternifier::VERSION).not_to be nil
  end
end
