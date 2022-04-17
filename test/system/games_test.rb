require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Games"
  # end
  test 'Going to /new gives us a new random grid to play with' do
    visit new_url
    assert test: 'New game'
    assert_selector 'p', count: 10
  end

  test 'Random word gives us message that you cant build it with chars you have' do
    visit new_url
    assert test: 'Random word'
    fill_in('capiinput', with: 'potatoe')
    click_on('capisubmit')
    assert_selector 'h2', text: /Sorry, you can't build .+/
  end

  test 'Sumbitting no word as empty string gives us message accordingly' do
    visit new_url
    assert test: 'No word'
    fill_in('capiinput', with: '')
    click_on('capisubmit')
    assert_selector 'h2', text: 'You did not give any word'
  end
end
