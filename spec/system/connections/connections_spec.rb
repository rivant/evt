require 'rails_helper'

RSpec.describe 'Connections', type: :system do
  include Devise::Test::IntegrationHelpers

  it 'displays all connections' do
    user = user_with_connections(2)

    visit connections_path

    expect(page).to have_content(user.connections.first.email)
    expect(page).to have_content(user.connections.second.email)
  end

  it 'shows current connection' do
    user = user_with_connections(1)

    visit connection_path(user.connections.first)

    expect(page).to have_content(user.connections.first.email)
  end

  it 'displays the new connection form' do
    visit new_connection_path

    expect(page).to have_field('First name')
    expect(page).to have_field('Last name')
    expect(page).to have_field('Email')
    expect(page).to have_field('Phone')
    expect(page).to have_button('Create Connection')
  end

  it 'displays the edit connection form' do
    user = user_with_connections(1)

    visit edit_connection_path(user.connections.first)

    expect(page).to have_field('First name', with: 'John')
    expect(page).to have_field('Last name', with: 'Doe')
    expect(page).to have_field('Relation', with: 'Friend')
    expect(page).to have_field('Email', with: user.connections.first.email)
    expect(page).to have_button('Update Connection')
  end

  it 'creates a connection' do
    login
    visit new_connection_path

    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Relation', with: 'Friend'
    fill_in 'Email', with: 'jd@example.com'
    fill_in 'Phone', with: '123-456-7890'
    click_button 'Create Connection'

    expect(page).to have_content('Connection was successfully created')
    expect(page).to have_content('John')
    expect(page).to have_content('Doe')
  end

  it 'updates a connection' do
    user = user_with_connections(1)
    visit edit_connection_path(user.connections.first)

    fill_in 'First name', with: 'Jane'
    click_button 'Update Connection'

    expect(page).to have_content('Connection was successfully updated.')
    expect(page).to have_content 'Jane'
  end

  it 'deletes a connection' do
    user = user_with_connections(2)

    visit connection_path(user.connections.first)
    click_button 'Destroy this connection'

    expect(page).to have_content('Connection was successfully destroyed.')
    expect(user.connections.count).to be 1
  end

  def login
    user = create(:user)
    sign_in user
  end

  def user_with_connections(amount)
    create(:user, :with_connections, connections_count: amount)
  end
end
