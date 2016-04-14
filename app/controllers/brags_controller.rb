class BragsController < ApplicationController

	def modal_show
		@brag = Brag.find(params[:id])
		render layout: false
	end

	def list
		render json: Brag.list
	end

	def create
		brag = Brag.new(
			title: params[:title],
			author: params[:author],
			subject: params[:subject],
			body: params[:body])
		if brag.save
			render json: brag.to_json
		else
			render json: brag.errors.to_json, status: 400
		end
	end

	def update
		brag = Brag.find(params[:id])
		if brag.update(brag_params)
			render json: brag.to_json
		else
			render json: brag.errors.to_json, status: 400
		end
	end

	def delete
	  	Brag.find(params[:id]).destroy
	  	render nothing: true, status: 200
	end

	def like
		BragLike.where(email: myEmail).where(brag_id: params[:id]).first_or_create!
		render json: Brag.list, status: 200
	end



	 private

  def brag_params
    params.permit(:title, :author, :subject, :body)
  end




	

end
