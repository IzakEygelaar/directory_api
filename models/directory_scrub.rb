class Scrubbing
  def directory_scrub_for_info(path)

    if check_if_path_exists(path) != true
      result  = {
        :path => path,
        :message => "Path does not exists!"
      }
      result
    else
      result_array = []
      parent_hashes = { :message => "Parent path:", :path => "#{path}", :size => get_size_of_path(path), :type => check_if_dir_or_file(path), :owner => get_owner(path), :group => get_group(path), :permissions => get_permissions(path) }
      result_array.push(parent_hashes)

      listings = Dir.glob("#{path}/*")
      listings.each do |item|
        result_hashes = { :message => "Substructure of parent folder:", :path => "#{item}", :size => get_size_of_path(item), :type => check_if_dir_or_file(item), :owner => get_owner(item), :group => get_group(item), :permissions => get_permissions(item) }
        result_array.push(result_hashes)
      end
      return result_array
    end
  end

  def check_if_path_exists(path)
    Dir.exists?(path)
  end

  def get_size_of_path(path)
    size = 0
    %x[du -sh #{path}].split("\t").first
  end

  def get_size_of_path(path)
    %x[du -sh #{path}].split("\t").first
  end

  def check_if_dir_or_file(path)
    if File.directory?(path) == true
      return "Directory"
    else
      return "File"
    end
  end

  def get_owner(path)
    %x[ls -ld #{path} | awk {'print $3'}].strip
  end

  def get_group(path)
    %x[ls -ld #{path} | awk {'print $4'}].strip
  end

  def get_permissions(path)
    %x[ls -ld #{path} | awk {'print $1'}].strip
  end
end