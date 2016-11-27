namespace :tag_cleaner do
  desc 'Print duplicate tags in ignore case'
  task duplicate_list: :environment do
    duplicate_tags = Tag.all.group_by { |tag| tag.name.downcase }.select { |_, tags| tags.size > 1 }
    duplicate_tags.each do |name, tags|
      puts "Duplicate Tag: #{name}"
      tags.each do |tag|
        referenced_count = MonthlyReportTag.where(tag: tag).count
        puts "  id: #{tag.id}, name: #{tag.name}, status: #{tag.status}, referenced_count: #{referenced_count}"
      end
    end
  end
end
