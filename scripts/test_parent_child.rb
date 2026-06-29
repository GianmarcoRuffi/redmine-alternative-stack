p = Project.find_by(identifier: 'delivery-modernization-pilot')
admin = User.where(admin: true).first || User.first
arr = []
parent = Issue.create!(project: p, subject: 'Parent test from runner', author: admin)
child = Issue.create!(project: p, subject: 'Child test from runner', author: admin)
begin
  child.parent_id = parent.id
  child.save!
  arr << 'set parent_id ok'
rescue => e
  arr << "set parent_id failed: #{e.message}"
end
begin
  child.update!(parent_id: parent.id)
  arr << 'update parent_id ok'
rescue => e
  arr << "update parent_id failed: #{e.message}"
end
begin
  parent.children << child
  arr << 'parent.children << child ok'
rescue => e
  arr << "parent.children << child failed: #{e.message}"
end
begin
  rel = IssueRelation.create!(issue_from: parent, issue_to: child, relation_type: 'precedes')
  arr << "IssueRelation precedes ok: #{rel.id}"
rescue => e
  arr << "IssueRelation precedes failed: #{e.message}"
end
begin
  rel2 = IssueRelation.create!(issue_from: parent, issue_to: child, relation_type: 'relates')
  arr << "IssueRelation relates ok: #{rel2.id}"
rescue => e
  arr << "IssueRelation relates failed: #{e.message}"
end
puts arr.join("\n")
puts "Parent id: #{parent.id}, Child parent_id: #{child.parent_id}"
puts "Parent children ids: #{parent.children.pluck(:id).inspect}"
