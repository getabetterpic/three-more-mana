json.sets do
  json.array! @sets do |set|
    json.id set.code
    json.name set.name
  end
end
