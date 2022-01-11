require 'rails_helper'

RSpec.feature "Visitor can add a product to the cart", type: :feature, js: true do

  # SETUP
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

  scenario "The 'My Cart' is updated from 0 to 1" do
    visit root_path
    first('article.product').find_button('Add').click

    # save_screenshot

    expect(page).to have_content 'My Cart (1)'
  end
end