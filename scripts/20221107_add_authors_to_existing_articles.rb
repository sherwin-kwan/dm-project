Article.all.each do |article|
  if !article.author_id
    article.update(author_id: Person.last.id)
  end
end