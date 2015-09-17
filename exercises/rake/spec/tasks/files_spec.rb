require 'rake'
require 'tmpdir'

shared_context 'rake' do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { self.class.top_level_description }
  let(:task_path) { "tasks/#{task_name.split(':').first}.rake" }
  subject         { rake[task_name] }

  before do
    Rake.application = rake
    rake.add_import(task_path)
    rake.load_imports
  end
end

describe 'files:list' do

  include_context 'rake'

  let(:temp_directory) { Dir.mktmpdir }

  before do
    4.times do |i|
      File.open("#{temp_directory}#{File::SEPARATOR}file#{i}.#{i%2 == 0 ? 'csv' : 'txt'}", "w") {}
    end
  end

  after do
    FileUtils.remove_entry_secure temp_directory
  end

  it 'raises ArgumentError when no directory is provided' do
    expect { subject.invoke }.to raise_error(ArgumentError, 'A directory must be provided to the list task')
  end

  it 'lists all files in a directory' do
    expect { subject.invoke(temp_directory) }.to output("file0.csv\nfile1.txt\nfile2.csv\nfile3.txt\n").to_stdout

  end

  it 'lists files that match the pattern' do
    expect { subject.invoke(temp_directory, '*.txt') }.to output("file1.txt\nfile3.txt\n").to_stdout
  end

end




