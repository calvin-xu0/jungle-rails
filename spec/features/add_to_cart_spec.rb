require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do
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
  
  scenario "They add a product and see the nav bar's cart text update" do
    visit root_path
    page.first('.product').find_button('Add').click

    # DEBUG
    sleep 3
    save_and_open_screenshot

    expect(page).to have_text "My Cart (1)"
  end

end
