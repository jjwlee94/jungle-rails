require 'rails_helper'

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see the product details" do
    visit root_path
    
    first('h4').click

    # save_and_open_screenshot
    
    expect(page).to have_css 'article.product-detail'
  end
end