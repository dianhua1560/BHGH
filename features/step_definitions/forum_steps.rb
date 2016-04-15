Given(/^the following posts exist:$/) do |table|
	table.hashes.each do |row|
		params = {
			title: row[:title],
			body: row[:body],
			author: row[:author]
		}
		page.driver.post('/forum/create', params)
		puts Post.all.length
	end
end

Given /there should be "(.*)" posts/ do |num|
	Post.all.length.should == num.to_i
end

Given /I delete post "(.*)"/ do |title|
	post = Post.find_by_title(title)
	page.driver.post('/forum/delete_post/'+post.id.to_s)
end

Given /I add response "(.*)" to "(.*)"/ do |params, title|
	p = Post.find_by_title(title)
	params = eval(params)
	page.driver.post('/forum/response/create/'+p.id.to_s, params)
end

Then /post "(.*)" should have "(.*)" responses/ do |title, num|
	post = Post.find_by_title(title)
	post.post_responses.length.should == num.to_i
end

Then /I should see post responses/ do 
	true
end

Then /I should see a post with title "(.*)"/ do |title|
	post = Post.find_by_title(title)
	post.should_not == nil
end

Given /I update post "(.*)" with "(.*)"/ do |title, params|
	params = eval(params)
	post = Post.find_by_title(title)
	page.driver.post('/forum/update/'+post.id.to_s, params)
end

Then /there should be a post with title "(.*)"/ do |title|
	post = Post.find_by_title(title)
	post.should_not == nil
end

Given /I delete response "(.*)" on "(.*)"/ do |body, title|
	post = Post.find_by_title(title)
	response = post.post_responses.where(body: body).first
	page.driver.post('/forum/response/delete/'+response.id.to_s)
end

Then /I should be able to use the admin page for post "(.*)"/ do |title|
	post = Post.find_by_title(title)
	page.driver.get('/forum/admin/'+post.id.to_s)
end

Then /I should be able to use the admin page for all posts/ do
	Post.all.each do |post|
		step 'I should be able to use the admin page for post "'+post.title+'"'
	end
end

When(/^I try to use the admin page for post "([^"]*)"$/) do |title|
	post = Post.find_by_title(title)
	visit '/forum/admin/'+post.id.to_s
end