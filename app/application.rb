require 'pry'

class Application
	def call(env)
		req = Rack::Request.new(env)
		resp = Rack::Response.new

		if req.path.match(/items/)
			searched_item = req.path.split("/items/").last
			found_item = @@items.find{|a| a.name == searched_item}
			if found_item
				resp.write "#{found_item.price}"
				resp.status = 200
			else
				resp.write "Item not found"
				resp.status = 400
			end
		else
			resp.write "Route not found"
			resp.status = 404
		end

		resp.finish
	end
end