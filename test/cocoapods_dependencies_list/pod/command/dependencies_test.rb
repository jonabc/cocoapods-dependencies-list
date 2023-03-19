# frozen_string_literal: true

require "test_helper"
require "json"

class Pod::Command::DependenciesTest < Minitest::Test
  def run_plugin(raw: false, options: {})
    io = StringIO.new
    Pod::UI.output_io = io

    options_args = options.map { |k, v| "--#{k}=#{v}" }
    argv = CLAide::ARGV.new(["--project-directory=#{FIXTURES_DIRECTORY}", *options_args])
    command = Pod::Command::Dependencies.new(argv)
    command.run

    io.pos = 0
    result = io.read
    raw ? result : JSON.parse(result)
  ensure
    io.close
  end

  def test_it_prints_content_as_json_string_to_the_ui
    content = run_plugin(raw: true)
    assert content.is_a?(String)

    assert JSON.parse(content).any?
  end

  def test_it_lists_dependencies_by_target_with_default_fields
    dependencies_by_target = run_plugin
    assert dependencies_by_target

    pods_ios_dependencies = dependencies_by_target["Pods-ios"]
    assert pods_ios_dependencies

    dependency = pods_ios_dependencies.find { |dep| dep["name"] == "Alamofire" }
    assert dependency

    assert_equal Pod::Command::Dependencies::DEFAULT_FIELDS.length, dependency.keys.length
    Pod::Command::Dependencies::DEFAULT_FIELDS.each do |field|
      assert dependency.has_key?(field)
    end
  end

  def test_it_filters_targets_with_targets_option
    dependencies_by_target = run_plugin(options: { targets: "Pods,Pods-iosTests" })

    assert dependencies_by_target.has_key?("Pods")
    assert dependencies_by_target.has_key?("Pods-iosTests")
    refute dependencies_by_target.has_key?("Pods-ios")
  end

  def test_it_filters_targets_with_fields_option
    dependencies_by_target = run_plugin(options: { fields: "name,version" })

    pods_ios_dependencies = dependencies_by_target["Pods-ios"]
    assert pods_ios_dependencies

    dependency = pods_ios_dependencies.find { |dep| dep["name"] == "Alamofire" }
    assert dependency

    assert_equal 2, dependency.keys.length
    assert dependency.has_key?("name")
    assert dependency.has_key?("version")
  end

  def test_it_includes_pod_installation_paths_with_include_path_option
    dependencies_by_target = run_plugin(options: { "include-path" => true })

    pods_ios_dependencies = dependencies_by_target["Pods-ios"]
    assert pods_ios_dependencies

    dependency = pods_ios_dependencies.find { |dep| dep["name"] == "Alamofire" }
    assert dependency
    assert dependency.has_key?("path")
  end
end
