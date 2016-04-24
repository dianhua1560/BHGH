class BragsController < ApplicationController

	def list
		render json: Brag.list(myEmail)
	end

	def click
		render nothing: true, status: 200
	end


	def create_form
		brag = params[:brag]
		puts 'brag was '
		puts brag
		Brag.create!(
			title: brag[:title],
			subject: brag[:subject],
			author: brag[:author] ? brag[:author] : myEmail,
			avatar: brag[:avatar],
			body: brag[:body]
			)
		redirect_to '/'
	end

	def update_photo
		brag = Brag.find(params[:id])
		brag.avatar = params[:avatar]
		brag.save!
		redirect_to '/'
	end
	def delete_photo
		brag = Brag.find(params[:id])
		brag.avatar = nil
		brag.save!
		render json: {:brags => Brag.list(myEmail), :brag => brag.tojson(myEmail)}.to_json , status: 200
	end

	def create
		puts params[:file]
		puts 'this was the file'
		puts params[:body]
		brag = Brag.new(
			title: params[:title],
			author: myEmail,
			subject: params[:subject],
			body: params[:body])
		if brag.save
			render json: {:brags=>Brag.list(myEmail), :brag=>brag.tojson(myEmail)} #json: brag.tojson(myEmail)
		else
			render json: brag.errors.to_json, status: 400
		end
	end

	def update
		brag = Brag.find(params[:id])
		if brag.update(brag_params)
			render json: Brag.list(myEmail) #brag.tojson(myEmail), status: 200
		else
			render json: brag.errors.to_json, status: 400
		end
	end

	def delete
	  	Brag.find(params[:id]).destroy
	  	if request.get?
	  		redirect_to '/admin'
	  	else
	  		render json: Brag.list(myEmail), status: 200
	  	end
	end

	def like
		BragLike.where(email: myEmail).where(brag_id: params[:id]).first_or_create!
		render nothing: true, status: 200
	end

	def unlike
		BragLike.where(email: myEmail).where(brag_id: params[:id]).destroy_all
		render nothing: true, status: 200
	end




	 private

  def brag_params
    params.permit(:title, :author, :subject, :body)
  end




	

end
