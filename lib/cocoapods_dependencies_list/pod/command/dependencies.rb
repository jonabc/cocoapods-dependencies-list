# frozen_string_literal: true

require "cocoapods"

module Pod
  class Command
    # A cocoapods plugin command `pod project dependencies` that outputs project dependency metadata
    class Dependencies < Command
      include Pod::Command::Options::ProjectDirectory

      DEFAULT_FIELDS = %w{name version summary homepage license}

      self.summary = "List cocoapod project dependencies with metadata."

      self.description = <<-DESC
        List cocoapod project dependencies with metadata.
      DESC

      def self.options
        [
          ["--targets", "A comma-delimited list of podfile targets"],
          ["--fields", "A comma-delimited list of podspec fields to include"]
        ].concat(super)
      end

      attr_reader :targets, :fields

      def initialize(argv)
        @targets = argv.option("targets", "").split(",").map(&:strip)
        @fields = argv.option("fields", "").split(",").map(&:strip)
        @fields = DEFAULT_FIELDS if !@fields.any?

        super
      end

      def run
        verify_podfile_exists!

        require "json"
        UI.puts specs_by_target.to_json
      end

      def specs_by_target
        analyzer = Installer::Analyzer.new(config.sandbox, config.podfile, config.lockfile)
        specs_by_target = config.with_changes(silent: true) { analyzer.analyze(false).specs_by_target }

        if @targets.any?
          specs_by_target = specs_by_target.select { |target, _| @targets.include? target.label }
        end

        specs_by_target.each do |target, specs|
          specs.map! do |spec|
            requested_fields_from_spec(spec)
          end
        end
      end

      def requested_fields_from_spec(spec)
        @fields.reduce({}) do |accum, field|
          accum[field] = spec.respond_to?(field.to_sym) ? spec.send(field.to_sym) : nil
          accum
        end
      end
    end
  end
end
