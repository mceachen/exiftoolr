require 'test_helper'

describe Exiftoolr do

  DUMP_RESULTS = false

  it 'raises NoSuchFile for missing files' do
    proc { Exiftoolr.new('no/such/file') }.must_raise Exiftoolr::NoSuchFile
  end

  it 'raises NotAFile for directories' do
    proc { Exiftoolr.new('lib') }.must_raise Exiftoolr::NotAFile
  end

  it 'no-ops with no files' do
    e = Exiftoolr.new([])
    e.errors?.must_be_false
  end

  it 'has errors with files without EXIF headers' do
    e = Exiftoolr.new('Gemfile')
    e.errors?.must_be_true
  end

  describe 'single-get' do
    it 'responds with known correct responses' do
      Dir['test/*.jpg'].each do |filename|
        e = Exiftoolr.new(filename)
        validate_result(e, filename)
      end
    end
  end

  describe 'multi-get' do
    def test_multi_matches
      filenames = Dir['**/*.jpg'].to_a
      e = Exiftoolr.new(filenames)
      filenames.each { |f| validate_result(e.result_for(f), f) }
    end
  end

  def validate_result(result, filename)
    yaml_file = "#{filename}.yaml"
    exif = result.to_hash
    File.open(yaml_file, 'w') { |out| YAML.dump(exif, out) } if DUMP_RESULTS
    e = File.open(yaml_file) { |f| YAML::load(f) }
    exif.keys.each do |k|
      next if ignorable_key?(k)
      expected = e[k]
      next if expected.nil? # older version of exiftool
      actual = exif[k]
      if expected.is_a?(String)
        expected.downcase!
        actual.downcase!
      end
      puts "Key '#{k}' was incorrect for #{filename}" if expected != actual
    end
  end

  # These are expected to be different on travis, due to different paths, filesystems, or
  # exiftool version differences.
  # fov and hyperfocal_distance, for example, are different between v8 and v9.
  IGNORABLE_KEYS = [
    :circle_of_confusion,
    :create_date,
    :date_time_original,
    :directory,
    :exif_tool_version,
    :file_access_date,
    :file_modify_date,
    :file_permissions,
    :fov,
    :hyperfocal_distance,
    :modify_date,
    :nd_filter,
    :source_file
  ]

  IGNORABLE_PATTERNS = [
    /.*\-ml-\w\w-\w\w$/, # < translatable
    /35efl$/ # < 35mm Effective focal length, whose calculation was changed between v8 and v9.
  ]

  def ignorable_key?(key)
    IGNORABLE_KEYS.include?(key) || IGNORABLE_PATTERNS.any? { |ea| key.to_s =~ ea }
  end
end
