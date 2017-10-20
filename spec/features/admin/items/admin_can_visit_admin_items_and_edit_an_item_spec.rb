require 'rails_helper'


RSpec.describe 'an admin can visit admin dashboard' do
	describe 'and see a link for all items' do
		it 'when clicked that link should be the admin item index with admin functionality' do
			Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
			default = Role.find(1)
			bus_man = Role.find(2)
			bus_admin = Role.find(3)
			plat_admin = Role.find(4)
			admin_user = User.create(first_name: "Admin", last_name: "McAdmin", email: "admin@admin.com", password: "boom", roles: [bus_man])
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)
			create_items
			visit admin_items_path
			click_on "Edit"
			fill_in "item[title]", with: "White Cat Twosie"
			fill_in "item[description]", with: "two is better"
			fill_in "item[price]", with: "39.99"
			page.attach_file("item[image]", Rails.root + 'app/assets/images/alien-onsie.png')

			click_on "Update"
			expect(page).to have_content("White Cat Twosie")
			expect(page).to have_content("39.99")
		end
	end
end
