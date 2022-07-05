require "rails_helper"

class PaginationTest < ActionDispatch::IntegrationTest
  describe "pagination", type: "feature", js: true do
    before(:each) do
      1.upto(20).each do |i|
        FactoryBot.create(:article, title: "This is Article #{i}")
      end
    end

    context "navigating between pages" do

      it "initial homepage displays first page of 5 results" do
        visit "/"
        expect(page).to have_content("Article 20")
        expect(page).to have_content("Article 16")
        expect(page).to_not have_content("Article 15")
        expect(page).to have_select(selected: "1")
      end

      it "Next takes you to Page 2" do
        visit "/"
        click_on "Next"
        expect(page).to have_content("Article 15")
        expect(page).to have_content("Article 11")
        expect(page).to_not have_content("Article 20")
        expect(page).to have_select(selected: "2")
      end

      it "Last takes you to last page" do
        visit "/"
        click_on "Last"
        expect(page).to have_content("Article 5")
        expect(page).to have_select(selected: "4")
        expect(page).to_not have_content("Last")
      end

      it "clicking Page 3 takes you to Page 3" do
        visit "/"
        select "3", from: 'page-selector'
        expect(page).to have_content("Article 10")
        expect(page).to have_select(selected: "3")
      end

      it "no Prev when you're on the first page" do
        visit "/"
        expect(page).to_not have_content("Prev")
      end

    end

    context "changing limit on pages" do
      it "only two articles appear after setting limit to 2" do
        visit "/"
        select "2", from: "limit-selector"
        expect(page).to have_css("div.article", count: 2)
      end
    end
  end
end
