require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'project is invalid without required fields' do
    @project = projects(:invalid)
    kit = YAML.load('fixtures/kit.yml')
    @project.expects(:kit).returns(kit)
    assert_not @project.valid?
  end

  test 'project is valid with required fields' do
    @project = projects(:valid)
    kit = YAML.load('fixtures/kit.yml')
    @project.expects(:kit).returns(kit)
    assert @project.valid?
  end

  test 'kit should not be nil' do
    @project = projects(:valid)
    kit = YAML.load('fixtures/kit.yml')
    @project.expects(:kit).returns(kit)
    assert @project.kit
  end

  test 'slug return parameterized title' do
    @project = projects(:valid)
    assert @project.slug == @project.title.parameterize
  end

  test 'compiled sass is sassy' do
    @project = projects(:valid)
    assert_match /(#{@project.slug})/, @project.compiled_css
    assert_match /(#{@project.primary_color})/, @project.compiled_css
    assert_match /(#{@project.secondary_color})/, @project.compiled_css
  end
end
