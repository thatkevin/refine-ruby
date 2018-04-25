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
    before do

    end

    describe "depends on generating a ui query" do
      describe "valid facet query" do
        it "needs a control key ('c') for each facet" do
          structure = @refine_project.facet_parameters("Date")
          assert_includes structure.first.keys, "c"
        end

        it "each facet needs a columnName" do
          facet = @refine_project.facet_parameters("Date").first.fetch('c')
          assert_includes facet.keys, "columnName"
        end
        it "each facet needs an expression" do
          facet = @refine_project.facet_parameters("Date").first.fetch('c')
          assert_includes facet.keys, "expression"
        end
        it "each facet needs a name" do
          facet = @refine_project.facet_parameters("Date").first.fetch('c')
          assert_includes facet.keys, "name"
        end
      end

      it "creates text facets for each column name provided" do
        date_facet, company_facet = @refine_project.facet_parameters("Date","company")

        assert_equal "Date", date_facet.fetch("c").fetch("columnName")
        assert_equal "Date", date_facet.fetch("c").fetch("name")

        assert_equal "company", company_facet.fetch("c").fetch("columnName")
        assert_equal "company", company_facet.fetch("c").fetch("name")
      end

      describe "with custom expressions" do
        it "has a `value` expression by default" do
          date_facet, company_facet = @refine_project.facet_parameters("Date","company")

          assert_equal "value", date_facet.fetch("c").fetch("expression")
          assert_equal "value", company_facet.fetch("c").fetch("expression")
        end

        # our own expression
        it "can pass custom expressions through a hash" do
          date_facet, company_facet = @refine_project
            .facet_parameters({"Date" => "date.utcTime()"},{"Company"=>"company.titleCase()"})

          assert_equal "date.utcTime()", date_facet.fetch("c").fetch("expression")
          assert_equal "Date", date_facet.fetch("c").fetch("columnName")

          assert_equal "company.titleCase()", company_facet.fetch("c").fetch("expression")
          assert_equal "Company", company_facet.fetch("c").fetch("columnName")
        end
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

    it "generates a link to the server" do
      assert(URI::HTTP === URI::parse(@refine_project.link_to_facets("Date")))
    end

    # @refine_project.link_to_facets(...)
    # => http://foo.bar/project/adfasdfsdf
    it "succeeds, with status 200 and a document" do
      assert(HTTPClient.get(@refine_project.link_to_facets("Date")).code == 200)
    end

    describe "sets up facets for us automatically" do
      # these tests will GET the url
      # assert on the html body -- (maybe just string contains)

      it "for the provided column" #do
    #    pending "optimistic, OpenRefine builds the UI in javascript, maybe check for a headless browser"
    #    assert(HTTPClient.get(@refine_project.link_to_facets("Date1")).body
    #    .include?('<span bind="titleSpan">Date1</span>'))
    #  end

      it "many at once"


    end
  end

  after do
    @refine_project.delete_project
  end

end
