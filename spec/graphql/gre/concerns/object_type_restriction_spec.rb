# frozen_string_literal: true

RSpec.describe Gre::Concerns::ObjectTypeRestriction do
  let(:klass) do
    Class.new do
      include Gre::Concerns::ObjectTypeRestriction

      object_types << String

      def initialize(object)
        type_check_object!(object)
      end
    end
  end
  let(:another_klass) { Class.new }

  describe "#type_check_object!" do
    subject { klass.new(object) }

    context "when the object is kind of the specified object type" do
      let(:object) { "foo" }

      it "does not raise an error" do
        expect { subject }.not_to raise_error
      end
    end

    context "when the object is not kind of the specified object type" do
      let(:object) { 123 }

      it "raises an ArgumentError" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".filter_types" do
    subject { described_class.filter_types(possible_types, object) }

    let(:possible_types) { [klass, another_klass] }

    context "when the object is kind of the specified object type of any possible type" do
      let(:object) { "foo" }

      it "returns filtered possible types" do
        expect(subject).to contain_exactly(klass)
      end
    end

    context "when the object is not kind of the specified object type of any possible type" do
      let(:object) { 123 }

      it "returns the original possible types" do
        expect(subject).to match_array(possible_types)
      end
    end
  end
end
