# frozen_string_literal: true

RSpec.describe Gre::FieldError do
  describe "#initialize" do
    subject { described_class.new(error_type, **details) }

    let(:error_type) { Gre::Errors::NotFound }
    let(:details) { {} }

    it "initializes #_error_type and #_details and uses error type default message" do
      expect(subject).to have_attributes(
        _error_type: error_type,
        _details: {},
        code: 404,
        message: "Not found",
      )
    end

    context "when message is provided in details" do
      let(:details) { { message: "Custom message" } }

      it "uses the message in details" do
        expect(subject).to have_attributes(
          _details: {},
          code: 404,
          message: "Custom message",
        )
      end
    end

    context "when error_type does not implement Interfaces::Error" do
      let(:error_type) { Gre::Types::Activity }

      it "raises an ArgumentError" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#method_missing" do
    subject { field_error.public_send(method_name) }

    let(:field_error) { described_class.new(Gre::Errors::NotFound, **details) }
    let(:details) { { foo: 123 } }

    context "when a method name is in the details" do
      let(:method_name) { :foo }

      it "returns the value in the details" do
        expect(subject).to eq 123
      end
    end

    context "when a method name is not in the details" do
      let(:method_name) { :bar }

      it "raises a NoMethodError" do
        expect { subject }.to raise_error(NoMethodError)
      end
    end
  end

  describe ".filter_types" do
    subject { described_class.filter_types(possible_types, obj) }

    let(:possible_types) { Gre::Unions::RegisterUserResult.possible_types }

    context "when the object is an instance of FieldError" do
      let(:obj) { described_class.new(error_type) }

      context "when the error_type conforms to the possible_types" do
        let(:error_type) { Gre::Errors::Conflict }

        it "returns error_type" do
          expect(subject).to contain_exactly(error_type)
        end
      end

      context "when the error_type does not conform to the possible_types" do
        let(:error_type) { Gre::Errors::NotFound }

        it "terminates by raising an error" do
          expect { super() }.to raise_error(StandardError)
        end
      end
    end

    context "when the object is not an instance of FieldError" do
      let(:obj) { "foo" }

      it "returns new possible types excluding error types" do
        expect(subject).to contain_exactly(Gre::Types::User)
      end
    end
  end
end
