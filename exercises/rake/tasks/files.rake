namespace :files do
  task :list, [:directory, :file_pattern] do |_, args|
    raise ArgumentError, 'A directory must be provided to the list task' unless args[:directory]
    Dir.chdir args[:directory] do
      Rake::FileList[args[:file_pattern] || '*'].each { |file| puts file }
    end
  end
end