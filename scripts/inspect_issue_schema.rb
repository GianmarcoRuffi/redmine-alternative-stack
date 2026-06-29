puts "COLUMNS:"
p Issue.column_names.sort
puts "ASSOCIATIONS:"
Issue.reflect_on_all_associations.each do |a|
  puts "#{a.macro} #{a.name} (class=#{a.class_name})"
end
