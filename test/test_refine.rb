gem 'minitest'
require 'minitest/autorun'
require_relative '../lib/refine.rb'


describe Refine do

  before do
    @refine_project = Refine.new({ "project_name" => 'date_cleanup', "file_name" => './test/dates.txt' })
  end

	it "refine_initializer_has_instance_variable_project_name" do
		assert_equal 'date_cleanup', @refine_project.project_name
	end

  it "refine_initializer_has_instance_variable_project_id" do
    assert @refine_project.project_id.match(/^[0-9]+$/)
  end

  it "get_all_project_metadata" do
    assert Refine.get_all_project_metadata.instance_of? Hash
  end

  it "apply_operations" do
    assert @refine_project.apply_operations( './test/operations.json' )
  end

  it "call" do
     assert @refine_project.call( 'apply-operations', 'operations' => File.read( './test/operations.json' ) )
  end

  describe "deep linking into a facet state" do
    it "generates a link to the server"
    it "succeeds, with status 200 and a document"

    describe "sets up facets for us automatically" do
      it "one at a time"
      it "many at once"

      describe "with custom expressions" do
        it "has a `value` expression by default"

        # our own expression
      end

      describe "with custom sorting" do

        it "sorts by `name` by default"
        it "sorts by `count` when specified"
      end

      describe "inverstion" do
        it "default"
        it "specified"
      end
    end
  end

  after do
    @refine_project.delete_project
  end

end
