require 'test_helper'

class FontSetTest < ActiveSupport::TestCase
  test 'is valid with required fields and formats' do
    @font_set = font_sets(:valid)
    load_kit
    assert @font_set.valid?
  end

  # test 'is invalid with invalid sass' do
  #   @font_set = font_sets(:valid)
  #   load_kit
  #   @font_set.sass = 'bongo'
  #   assert_not @font_set.valid?
  # end
  #
  # (FontSet::ELEMENTS + ['name']).each do |required_field|
  #   test "is invalid without a #{required_field}" do
  #     @font_set = font_sets(:valid)
  #     load_kit
  #     @font_set.send("#{required_field}=", nil)
  #     assert_not @font_set.valid?
  #   end
  # end
  #
  # test 'slug should be the name parameterized' do
  #   @font_set = font_sets(:valid)
  #   assert @font_set.slug == @font_set.name.parameterize
  # end
  #
  # test 'element_font_name returns nil with an invalid element' do
  #   @font_set = font_sets(:valid)
  #   load_kit
  #   element = 'bongo'
  #   assert_not FontSet::ELEMENTS.include?(element)
  #   assert_not @font_set.element_font_name(element)
  # end
  #
  # FontSet::ELEMENTS.each do |element|
  #   test "element_font_name returns something with #{element}" do
  #     @font_set = font_sets(:valid)
  #     load_kit
  #     assert @font_set.element_font_name(element)
  #   end
  # end
  #
  # test 'element_css returns nil with an invalid element' do
  #   @font_set = font_sets(:valid)
  #   load_kit
  #   element = 'bongo'
  #   assert_not FontSet::ELEMENTS.include?(element)
  #   assert_not @font_set.element_css(element)
  # end
  #
  # FontSet::ELEMENTS.each do |element|
  #   test "element_css returns something with #{element}" do
  #     @font_set = font_sets(:valid)
  #     load_kit
  #     assert @font_set.element_css(element)
  #   end
  # end
  #
  # test 'uncompiled_sass should be valid' do
  #   @font_set = font_sets(:valid)
  #   load_kit
  #   assert_nothing_raised do
  #     Sass::Engine.new(@font_set.uncompiled_sass, syntax: :scss).to_css
  #   end
  # end

  private

  def load_kit
    kit = YAML.load_file('test/fixtures/kit.yml')
    @font_set.project.stubs(:kit).returns(kit)
  end
end
